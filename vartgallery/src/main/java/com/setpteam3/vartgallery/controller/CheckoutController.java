package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.Transaction;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.ArtworkService;

import com.setpteam3.vartgallery.service.EmailService;
import com.setpteam3.vartgallery.service.TransactionService;
import com.setpteam3.vartgallery.service.UserService;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import jakarta.persistence.OptimisticLockException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.hibernate.StaleObjectStateException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.stream.Collectors;

@Controller
public class CheckoutController {
    @Value("${stripe.public}")
    private String stripePublicKey;

    @Value("${stripe.secret}")
    private String stripeSecretKey;

    private final ArtworkService artworkService;
    private final EmailService emailService;
    private final UserService userService;
    private final TransactionService transactionService;

    public CheckoutController(ArtworkService artworkService, EmailService emailService, UserService userService, TransactionService transactionService) {
        this.artworkService = artworkService;
        this.emailService = emailService;
        this.userService = userService;
        this.transactionService = transactionService;
    }

    @GetMapping("/checkout")
    public String checkout(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        double total = cart.stream().map(Artwork::getPrice).mapToDouble(BigDecimal::doubleValue).sum();
        model.addAttribute("cart", cart);
        model.addAttribute("total", total);
        model.addAttribute("stripePublicKey", stripePublicKey);
        return "public/checkout";
    }

    @PostMapping("/charge")
    public ResponseEntity<?> charge(HttpServletRequest request) {
        Stripe.apiKey = stripeSecretKey;

        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        List<Integer> artworkIds = cart.stream().map(Artwork::getId).collect(Collectors.toList());
        List<Artwork> artworks = artworkService.findArtworksByIds(artworkIds);

        // Check if artworks are still available
        List<Artwork> unavailableArtworks = artworks.stream()
                .filter(artwork -> !artworkService.isAvailable(artwork.getId()))
                .collect(Collectors.toList());

        if (!unavailableArtworks.isEmpty()) {
            List<Map<String, Object>> unavailableArtworksInfo = unavailableArtworks.stream().map(artwork -> {
                Map<String, Object> artworkInfo = new HashMap<>();
                artworkInfo.put("id", artwork.getId());
                artworkInfo.put("title", artwork.getTitle());
                return artworkInfo;
            }).collect(Collectors.toList());

            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "Some artworks are no longer available");
            errorResponse.put("unavailableArtworks", unavailableArtworksInfo);
            System.out.println("Unavailable Artworks: " + unavailableArtworksInfo);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }

        double total = cart.stream().map(Artwork::getPrice).mapToDouble(BigDecimal::doubleValue).sum();
        int amount = (int) (total * 100); // Amount in cents

        try {
            // Create PaymentIntent
            Map<String, Object> params = new HashMap<>();
            params.put("amount", amount);
            params.put("currency", "usd");
            params.put("payment_method_types", List.of("card"));
            PaymentIntent intent = PaymentIntent.create(params);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("status", "success");
            responseData.put("clientSecret", intent.getClientSecret());

            // Temporarily mark artworks as pending
            for (Artwork artwork : artworks) {
                artwork.setStatus("pending");
                artworkService.save(artwork);
            }

            return ResponseEntity.status(HttpStatus.OK).body(responseData);
        } catch (StripeException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An error occurred while creating the payment intent: " + e.getMessage()));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An unexpected error occurred: " + e.getMessage()));
        }
    }

    @Transactional
    @PostMapping("/finalizePurchase")
    public ResponseEntity<?> finalizePurchase(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");
        if (cart == null || user == null) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("error", "Cart or user information is missing"));
        }

        List<Integer> artworkIds = cart.stream().map(Artwork::getId).collect(Collectors.toList());
        List<Artwork> artworks = artworkService.findArtworksByIds(artworkIds);
        String uniqueTransactionId = "TRX-" + UUID.randomUUID().toString();

        try {
            ResponseEntity<?> result = retryOnOptimisticLockingFailure(() -> {
                for (Artwork artwork : artworks) {
                    artwork.setStatus("sold");
                    artwork.setBuyerId(user);
                    artworkService.save(artwork);

                    Transaction transaction = new Transaction();
                    transaction.setTransactionId(uniqueTransactionId);
                    transaction.setUserId(user.getId());
                    transaction.setArtworkId(artwork.getId());
                    transaction.setAmount(artwork.getPrice());
                    transactionService.save(transaction);

                    // Send emails
                    User artist = artwork.getArtistId();
                    emailService.sendBuyerArtworkPurchasedEmail(user, artwork);
                    emailService.sendArtistArtworkPurchasedEmail(artist, artwork);
                }

                session.setAttribute("cart", new ArrayList<>()); // Clear cart
                return ResponseEntity.ok(Collections.singletonMap("status", "success"));
            }, 3); // Retry up to 3 times
            return result;
        } catch (OptimisticLockException e) {
            resetPendingArtworks(artworks);
            return ResponseEntity.status(HttpStatus.CONFLICT).body(Collections.singletonMap("error", "One or more artworks have been updated by another transaction. Please try again."));
        } catch (Exception e) {
            resetPendingArtworks(artworks);
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An unexpected error occurred: " + e.getMessage()));
        }
    }

    private void resetPendingArtworks(List<Artwork> artworks) {
        for (Artwork artwork : artworks) {
            if ("pending".equals(artwork.getStatus())) {
                artwork.setStatus("available");
                artworkService.save(artwork);
            }
        }
    }

    private ResponseEntity<?> retryOnOptimisticLockingFailure(Callable<ResponseEntity<?>> callable, int maxRetries) throws Exception {
        int attempts = 0;
        while (attempts < maxRetries) {
            try {
                return callable.call();
            } catch (ObjectOptimisticLockingFailureException | StaleObjectStateException e) {
                attempts++;
                if (attempts >= maxRetries) {
                    throw e;
                }
            }
        }
        throw new RuntimeException("Failed after maximum retries");
    }
}

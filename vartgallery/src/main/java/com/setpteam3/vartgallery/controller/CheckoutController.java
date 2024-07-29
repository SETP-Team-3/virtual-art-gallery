package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.Transaction;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.CommentService;
import com.setpteam3.vartgallery.service.TransactionService;
import com.setpteam3.vartgallery.service.UserService;
import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class CheckoutController {
    @Value("${stripe.public}")
    private String stripePublicKey;

    @Value("${stripe.secret}")
    private String stripeSecretKey;

    private final ArtworkService artworkService;
    private final UserService userService;
    private final TransactionService transactionService;

    public CheckoutController(ArtworkService artworkService, UserService userService, TransactionService transactionService) {
        this.artworkService = artworkService;
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
    public ResponseEntity<?> charge(HttpServletRequest request) throws StripeException {
        Stripe.apiKey = stripeSecretKey;

        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        // check if artworks are still available
        List<Artwork> unavailableArtworks = cart.stream()
                .filter(artwork -> !artworkService.isAvailable(artwork.getId()))
                .collect(Collectors.toList());

        if (!unavailableArtworks.isEmpty()) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("status", "error");
            errorResponse.put("message", "Some artworks are no longer available");
            errorResponse.put("unavailableArtworks", unavailableArtworks);
            return ResponseEntity.badRequest().body(errorResponse);
        }

        double total = cart.stream().map(Artwork::getPrice).mapToDouble(BigDecimal::doubleValue).sum();
        int amount = (int) (total * 100); // Amount in cents

        // Create PaymentIntent
        Map<String, Object> params = new HashMap<>();
        params.put("amount", amount);
        params.put("currency", "usd");
        params.put("payment_method_types", List.of("card"));
        PaymentIntent intent = PaymentIntent.create(params);

        Map<String, String> responseData = new HashMap<>();
        responseData.put("clientSecret", intent.getClientSecret());

        return ResponseEntity.ok(responseData);
    }

    @PostMapping("/finalizePurchase")
    public ResponseEntity<?> finalizePurchase(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || user == null) {
            return ResponseEntity.badRequest().body(Collections.singletonMap("error", "Cart or user information is missing"));
        }

        for (Artwork artwork : cart) {
            artwork.setStatus("sold");
            artwork.setBuyerId(user);
            artworkService.save(artwork);

            Transaction transaction = new Transaction();
            transaction.setUserId(user.getId());
            transaction.setArtworkId(artwork.getId());
            transaction.setAmount(artwork.getPrice());
            transactionService.save(transaction);
        }

        session.setAttribute("cart", new ArrayList<>()); // Clear the cart

        return ResponseEntity.ok(Collections.singletonMap("status", "success"));
    }
}

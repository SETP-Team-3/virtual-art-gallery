package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.service.ArtworkService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/cart")
public class CartController {
    private final ArtworkService artworkService;

    public CartController(ArtworkService artworkService) {
        this.artworkService = artworkService;
    }

    @GetMapping
    public String index(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        model.addAttribute("cart", cart);
        return "public/cart";
    }

    @PostMapping("/add")
    public ResponseEntity<?> addToCart(@RequestParam int artworkId, HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        Optional<Artwork> artworkOptional = artworkService.getArtworkById(artworkId);
        if (artworkOptional.isPresent()) {
            Artwork artwork = artworkOptional.get();
            if ("available".equals(artwork.getStatus())) {
                boolean alreadyInCart = cart.stream().anyMatch(item -> item.getId() == artworkId);
                if (!alreadyInCart) {
                    cart.add(artwork);
                    session.setAttribute("cart", cart);
                    return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("status", "success"));
                } else {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("error", "Artwork is already in the cart"));
                }
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("error", "Artwork not available"));
            }
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("error", "Artwork not found"));
        }
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeFromCart(@RequestParam int artworkId, HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");

        if (cart != null) {
            boolean removed = cart.removeIf(artwork -> artwork.getId() == artworkId);
            session.setAttribute("cart", cart);
            if (removed) {
                return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("status", "success"));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("error", "Artwork not found in cart"));
            }
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("error", "Cart is empty"));
        }
    }
}

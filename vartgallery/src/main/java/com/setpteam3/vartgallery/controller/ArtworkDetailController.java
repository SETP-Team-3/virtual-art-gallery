package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.CommentService;
import com.setpteam3.vartgallery.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Collections;
import java.util.Optional;

@Controller
@RequestMapping("/artwork-detail")
public class ArtworkDetailController {
    private final ArtworkService artworkService;
    private final UserService userService;
    private final CommentService commentService;

    public ArtworkDetailController(ArtworkService artworkService, UserService userService, CommentService commentService) {
        this.artworkService = artworkService;
        this.userService = userService;
        this.commentService = commentService;
    }

    @GetMapping
    public String artworkDetail(@RequestParam("id") int id, Model model, Principal principal) {
        try {
            Optional<Artwork> artwork = artworkService.getArtworkById(id);
            if (artwork.isPresent()) {
                Artwork artworkDetails = artwork.get();
                if (principal != null) {
                    String username = principal.getName();
                    boolean isLiked = userService.isArtworkLikedByUser(artworkDetails.getId(), username);
                    artworkDetails.setLiked(isLiked);
                } else {
                    artworkDetails.setLiked(false);
                }
                model.addAttribute("artwork", artworkDetails);
                model.addAttribute("comments", commentService.getCommentsByArtworkId(id));
                return "public/artwork-detail";
            } else {
                return "redirect:/public/gallery";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "An error occurred while retrieving the artwork");
            return "redirect:/public/gallery";
        }
    }

    @PostMapping("/add-to-cart")
    public ResponseEntity<?> addToCart(@RequestParam("artworkId") int artworkId, Principal principal) {
        try {
            String username = principal.getName();
            boolean success = userService.addArtworkToCart(artworkId, username);
            if (success) {
                return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("message", "Artwork added to cart!"));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("error", "Failed to add artwork to cart."));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An error occurred while adding artwork to cart"));
        }
    }

    @PostMapping("/toggle-like")
    public ResponseEntity<?> toggleLike(@RequestParam("artworkId") int artworkId, Principal principal) {
        try {
            String username = principal.getName();
            boolean liked = userService.toggleLikeArtwork(artworkId, username);
            if (liked) {
                return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("message", "Artwork liked!"));
            } else {
                return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("message", "Artwork unliked!"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An error occurred while toggling like status"));
        }
    }

    @PostMapping("/add-comment")
    public ResponseEntity<?> addComment(@RequestParam("artworkId") int artworkId, @RequestParam("comment") String content, Principal principal) {
        try {
            String username = principal.getName();
            commentService.addComment(artworkId, username, content);
            return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("message", "Comment added successfully!"));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An error occurred while adding the comment"));
        }
    }
}

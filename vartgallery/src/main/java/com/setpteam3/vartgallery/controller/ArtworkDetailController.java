package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.CommentService;
import com.setpteam3.vartgallery.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Collections;
import java.util.List;
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
    public String index(@RequestParam("id") int id, Model model, Principal principal, HttpServletRequest request) {
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

                HttpSession session = request.getSession();
                List<Artwork> cart = (List<Artwork>) session.getAttribute("cart");
                boolean isInCart = cart != null && cart.stream().anyMatch(item -> item.getId() == id);

                model.addAttribute("artwork", artworkDetails);
                model.addAttribute("isInCart", isInCart);
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
}

package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.Genre;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.GenreService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/my-artworks")
public class MyArtworksController {
    private final ArtworkService artworkService;
    private final GenreService genreService;

    public MyArtworksController(ArtworkService artworkService, GenreService genreService) {
        this.artworkService = artworkService;
        this.genreService = genreService;
    }

    @GetMapping
    public String index(Model model,
                        HttpServletRequest request,
                        @RequestParam Optional<Integer> page,
                        @RequestParam Optional<Integer> size) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            int currentPage = page.orElse(1) - 1;
            int pageSize = size.orElse(8);
            Pageable pageable = PageRequest.of(currentPage, pageSize);

            Page<Artwork> artworksPage = artworkService.getArtworksByUserId(user.getId(), pageable);
            List<Genre> genres = genreService.getAllGenres();

            model.addAttribute("artworks", artworksPage.getContent());
            model.addAttribute("totalArtworkPages", artworksPage.getTotalPages());
            model.addAttribute("currentArtworkPage", currentPage + 1);
            model.addAttribute("genres", genres);
        } else {
            model.addAttribute("artworks", List.of());
            model.addAttribute("totalArtworkPages", 0);
            model.addAttribute("currentArtworkPage", 1);
        }

        return "public/my-artworks";
    }

    @PostMapping("/upload")
    public ResponseEntity<?> uploadArtwork(HttpServletRequest request,
                                           @RequestParam("title") String title,
                                           @RequestParam("genres") List<Integer> genreIds,
                                           @RequestParam("description") String description,
                                           @RequestParam("dimension") String dimension,
                                           @RequestParam("price") double price,
                                           @RequestParam("image") MultipartFile image) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            try {
                artworkService.insertPendingArtwork(title, genreIds, description, dimension, price, image, user);
                return ResponseEntity.ok(Collections.singletonMap("status", "success"));
            } catch (IOException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "Failed to upload artwork"));
            }
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Collections.singletonMap("error", "User not authenticated"));
        }
    }
}

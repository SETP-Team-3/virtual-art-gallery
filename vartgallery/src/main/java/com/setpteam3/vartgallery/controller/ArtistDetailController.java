package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.Optional;

@Controller
@RequestMapping("/artist-detail")
public class ArtistDetailController {
    private final UserService userService;
    private final ArtworkService artworkService;

    public ArtistDetailController(UserService userService, ArtworkService artworkService) {
        this.userService = userService;
        this.artworkService = artworkService;
    }

    @GetMapping
    public String index(@RequestParam("id") int id,
                        @RequestParam Optional<Integer> page,
                        @RequestParam Optional<Integer> size,
                        Model model, Principal principal) {
        try {
            Optional<User> artistOptional = userService.getUserById(id);
            if (artistOptional.isPresent()) {
                User artist = artistOptional.get();

                int currentPage = page.orElse(1) - 1;
                int pageSize = size.orElse(8);
                Pageable pageable = PageRequest.of(currentPage, pageSize);

                Page<Artwork> artworksPage = artworkService.getArtworksByUserId(artist.getId(), pageable);

                model.addAttribute("artist", artist);
                model.addAttribute("artworks", artworksPage.getContent());
                model.addAttribute("totalArtworkPages", artworksPage.getTotalPages());
                model.addAttribute("currentArtworkPage", currentPage + 1);

                return "public/artist-detail";
            } else {
                return "redirect:/public/gallery";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "An error occurred while retrieving the artist");
            return "redirect:/public/gallery";
        }
    }
}

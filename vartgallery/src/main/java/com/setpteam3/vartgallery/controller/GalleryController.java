package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.service.ArtworkService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/gallery")
public class GalleryController {
    private final ArtworkService artworkService;

    public GalleryController(ArtworkService artworkService) {
        this.artworkService = artworkService;
    }

    @GetMapping
    public String index(Model model) {
        List<Artwork> artworks = artworkService.getLatestArtworks(8);
        model.addAttribute("artworks", artworks);
        return "public/gallery";
    }
}

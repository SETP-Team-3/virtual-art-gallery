package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.service.ArtworkService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
public class HomeController {
    private final ArtworkService artworkService;

    public HomeController(ArtworkService artworkService) {
        this.artworkService = artworkService;
    }

    @GetMapping
    public String home(Model model) {
        List<Artwork> featuredArtworks = artworkService.getRandomArtworks(8);
        model.addAttribute("featuredArtworks", featuredArtworks);
        return "public/home";
    }

    @GetMapping("/about")
    public String about() {
        return "public/about";
    }
}

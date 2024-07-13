package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.service.ArtworkService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/artwork")
public class ArtworkController {
    private final ArtworkService artworkService;

    public ArtworkController(ArtworkService artworkService) {
        this.artworkService = artworkService;
    }

    @GetMapping
    public ResponseEntity<?> getAllArtworks() {
        try {
            List<Artwork> artworks = artworkService.getAllArtworks();
            return ResponseEntity.status(HttpStatus.OK).body(artworks);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An error occurred while retrieving all artwork"));
        }
    }
}

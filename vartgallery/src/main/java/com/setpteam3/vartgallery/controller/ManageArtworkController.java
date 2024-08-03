package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.PendingArtwork;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.repository.PendingArtworkRepository;
import com.setpteam3.vartgallery.service.ArtworkService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class ManageArtworkController {
    private final PendingArtworkRepository pendingArtworkRepository;
    private final ArtworkService artworkService;

    public ManageArtworkController(PendingArtworkRepository pendingArtworkRepository, ArtworkService artworkService) {
        this.pendingArtworkRepository = pendingArtworkRepository;
        this.artworkService = artworkService;
    }

    @GetMapping("/manage-artworks")
    public String manageArtworks(HttpServletRequest request, Model model, Pageable pageable) {
        HttpSession session = request.getSession(false);
        User adminUser = (User) (session != null ? session.getAttribute("adminUser") : null);
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            return "redirect:/admin/login";
        }

        List<Artwork> artworks = artworkService.getAllArtworks();
        model.addAttribute("artworks", artworks);
        return "admin/manage-artworks";
    }

    @GetMapping("/artwork-details")
    public ResponseEntity<?> artworkDetails(@RequestParam("artworkId") int artworkId) {
        try {
            Optional<Artwork> artwork = artworkService.getArtworkById(artworkId);
            return ResponseEntity.ok(artwork);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @PostMapping("/delete-artwork")
    public ResponseEntity<?> deleteArtwork(@RequestParam("artworkId") int artworkId) {
        try {
            artworkService.deleteArtwork(artworkId);
            return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @GetMapping("/pending-artworks")
    public String showPendingArtworks(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        User adminUser = (User) (session != null ? session.getAttribute("adminUser") : null);
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            return "redirect:/admin/login";
        }

        List<PendingArtwork> pendingArtworks = pendingArtworkRepository.findAll();
        model.addAttribute("pendingArtworks", pendingArtworks);
        return "admin/pending-artworks";
    }

    @PostMapping("/approve-artwork")
    public ResponseEntity<?> approveArtwork(@RequestParam("artworkId") int artworkId) {
        try {
            PendingArtwork pendingArtwork = pendingArtworkRepository.findById(artworkId).orElseThrow(() -> new RuntimeException("Artwork not found with id " + artworkId));
            artworkService.approveArtwork(pendingArtwork);
            return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @PostMapping("/reject-artwork")
    public ResponseEntity<?> rejectArtwork(@RequestParam("artworkId") int artworkId) {
        try {
            PendingArtwork pendingArtwork = pendingArtworkRepository.findById(artworkId).orElseThrow(() -> new RuntimeException("Artwork not found with id " + artworkId));
            artworkService.rejectArtwork(pendingArtwork);
            return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }
}

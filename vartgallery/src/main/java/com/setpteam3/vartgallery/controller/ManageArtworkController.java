package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.PendingArtwork;
import com.setpteam3.vartgallery.repository.PendingArtworkRepository;
import com.setpteam3.vartgallery.service.ArtworkService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class ManageArtworkController {
    private final PendingArtworkRepository pendingArtworkRepository;
    private final ArtworkService artworkService;

    public ManageArtworkController(PendingArtworkRepository pendingArtworkRepository, ArtworkService artworkService) {
        this.pendingArtworkRepository = pendingArtworkRepository;
        this.artworkService = artworkService;
    }

    @GetMapping("/pending-artworks")
    public String showPendingArtworks(Model model) {
        List<PendingArtwork> pendingArtworks = pendingArtworkRepository.findAll();
        model.addAttribute("pendingArtworks", pendingArtworks);
        return "admin/pending-artworks";
    }

    @PostMapping("/approve-artwork")
    public String approveArtwork(@RequestParam("artworkId") int artworkId) {
        PendingArtwork pendingArtwork = pendingArtworkRepository.findById(artworkId).orElseThrow();
        artworkService.approveArtwork(pendingArtwork);
        return "redirect:/admin/pending-artworks";
    }

    @PostMapping("/reject-artwork")
    public String rejectArtwork(@RequestParam("artworkId") int artworkId, @RequestParam("reason") String reason) {
        PendingArtwork pendingArtwork = pendingArtworkRepository.findById(artworkId).orElseThrow();
        artworkService.rejectArtwork(pendingArtwork, reason);
        return "redirect:/admin/pending-artworks";
    }
}

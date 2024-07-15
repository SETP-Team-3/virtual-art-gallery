package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.repository.ArtworkRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ArtworkService {
    private final ArtworkRepository artworkRepository;

    public ArtworkService(ArtworkRepository artworkRepository) {
        this.artworkRepository = artworkRepository;
    }

    public List<Artwork> getAllArtworks() {
        return artworkRepository.findAll();
    }

    public Optional<Artwork> getArtworkById(int id) {
        return artworkRepository.findById(id);
    }

    public List<Artwork> getLatestArtworks(int limit) {
        return artworkRepository.findTopByOrderByCreatedAtDesc(limit);
    }
}

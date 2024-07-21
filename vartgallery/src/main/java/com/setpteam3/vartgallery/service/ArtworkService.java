package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.repository.ArtworkRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.*;

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

    public Page<Artwork> getLatestArtworks(Pageable pageable) {
        return artworkRepository.findTopByOrderByCreatedAtDesc(pageable);
    }

    public Page<Artwork> filterArtworks(String title, String artist, Double minPrice, Double maxPrice, List<Integer> genreIds, Pageable pageable) {
        return artworkRepository.findArtworksByFilters(title, artist, minPrice, maxPrice, genreIds, pageable);
    }
}

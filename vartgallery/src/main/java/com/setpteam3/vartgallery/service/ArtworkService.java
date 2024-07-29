package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.Genre;
import com.setpteam3.vartgallery.entity.PendingArtwork;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.repository.ArtworkRepository;
import com.setpteam3.vartgallery.repository.GenreRepository;
import com.setpteam3.vartgallery.repository.PendingArtworkRepository;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ArtworkService {
    private final ArtworkRepository artworkRepository;
    private final PendingArtworkRepository pendingArtworkRepository;
    private final GenreRepository genreRepository;
    private final Path uploadPath = Paths.get("src/main/resources/static/artwork");

    public ArtworkService(ArtworkRepository artworkRepository, PendingArtworkRepository pendingArtworkRepository, GenreRepository genreRepository) {
        this.artworkRepository = artworkRepository;
        this.pendingArtworkRepository = pendingArtworkRepository;
        this.genreRepository = genreRepository;

        try {
            Files.createDirectories(uploadPath);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory", e);
        }
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

    public Page<Artwork> getArtworksByUserId(int artistId, Pageable pageable) {
        return artworkRepository.findByArtistId(artistId, pageable);
    }

    public void save(Artwork artwork) {
        artworkRepository.save(artwork);
    }

    /* public void insertArtwork(String title, List<Integer> genreIds, String description, double price, MultipartFile image, User user) throws IOException {
        String fileName = saveImage(image);
        Artwork artwork = new Artwork();
        artwork.setTitle(title);
        artwork.setDescription(description);
        artwork.setPrice(BigDecimal.valueOf(price));
        artwork.setImage(fileName);
        artwork.setArtistId(user);
        artwork.setStatus("available");

        Set<Genre> genres = genreRepository.findAllById(genreIds).stream().collect(Collectors.toSet());
        artwork.setGenres(genres);

        artworkRepository.save(artwork);
    } */

    public void insertPendingArtwork(String title, List<Integer> genreIds, String description, double price, MultipartFile image, User user) throws IOException {
        String fileName = saveImage(image);
        PendingArtwork pendingArtwork = new PendingArtwork();
        pendingArtwork.setTitle(title);
        pendingArtwork.setDescription(description);
        pendingArtwork.setPrice(BigDecimal.valueOf(price));
        pendingArtwork.setImage(fileName);
        pendingArtwork.setArtistId(user);

        Set<Genre> genres = genreRepository.findAllById(genreIds).stream().collect(Collectors.toSet());
        pendingArtwork.setGenres(genres);

        pendingArtworkRepository.save(pendingArtwork);
    }

    public void approveArtwork(PendingArtwork pendingArtwork) {
        Artwork artwork = new Artwork();
        artwork.setTitle(pendingArtwork.getTitle());
        artwork.setDescription(pendingArtwork.getDescription());
        artwork.setPrice(pendingArtwork.getPrice());
        artwork.setImage(pendingArtwork.getImage());
        artwork.setArtistId(pendingArtwork.getArtistId());
        artwork.setStatus("available");
        artwork.setGenres(pendingArtwork.getGenres());

        artworkRepository.save(artwork);
        pendingArtworkRepository.delete(pendingArtwork);

        // Send approval email to the artist
        // emailService.sendApprovalEmail(pendingArtwork.getArtist(), pendingArtwork);
    }

    public void rejectArtwork(PendingArtwork pendingArtwork, String reason) {
        pendingArtworkRepository.delete(pendingArtwork);

        // Send rejection email to the artist with the reason
        // emailService.sendRejectionEmail(pendingArtwork.getArtist(), pendingArtwork, reason);
    }

    private String saveImage(MultipartFile image) throws IOException {
        String fileName = System.currentTimeMillis() + "_" + image.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);
        Thumbnails.of(image.getInputStream()).size(600, 600).toFile(filePath.toFile());
        return fileName;
    }

    public boolean isAvailable(int artworkId) {
        Optional<Artwork> artworkOptional = getArtworkById(artworkId);
        return artworkOptional.isPresent() && "available".equals(artworkOptional.get().getStatus());
    }
}

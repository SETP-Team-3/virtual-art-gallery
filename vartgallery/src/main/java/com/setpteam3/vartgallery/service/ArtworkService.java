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
    private final EmailService emailService;
    private final Path uploadPath = Paths.get("src/main/resources/static/artwork");

    public ArtworkService(ArtworkRepository artworkRepository, PendingArtworkRepository pendingArtworkRepository, GenreRepository genreRepository, EmailService emailService) {
        this.artworkRepository = artworkRepository;
        this.pendingArtworkRepository = pendingArtworkRepository;
        this.genreRepository = genreRepository;
        this.emailService = emailService;

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

    public List<Artwork> getRandomArtworks(int limit) {
        return artworkRepository.findRandomArtworks(limit);
    }

    public void deleteArtwork(int id) {
        artworkRepository.deleteById(id);
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

    public void insertPendingArtwork(String title, List<Integer> genreIds, String description, double price, MultipartFile image, User user) throws IOException {
        String fileName = saveImage(image);
        PendingArtwork pendingArtwork = new PendingArtwork();
        pendingArtwork.setTitle(title);
        pendingArtwork.setDescription(description);
        pendingArtwork.setPrice(BigDecimal.valueOf(price));
        pendingArtwork.setImage(fileName);
        pendingArtwork.setArtistId(user);

        String genreIdsString = genreIds.stream().map(String::valueOf).collect(Collectors.joining(","));
        pendingArtwork.setGenreIds(genreIdsString);

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

        if (pendingArtwork.getGenreIds() != null && !pendingArtwork.getGenreIds().isEmpty()) {
            List<Integer> genreIds = Arrays.stream(pendingArtwork.getGenreIds().split(","))
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            Set<Genre> genres = new HashSet<>(genreRepository.findAllById(genreIds));
            artwork.setGenres(genres);
        } else {
            artwork.setGenres(Collections.emptySet());
        }

        artworkRepository.save(artwork);
        pendingArtworkRepository.delete(pendingArtwork);
        emailService.sendApprovalEmail(pendingArtwork.getArtistId(), pendingArtwork);
    }

    public void rejectArtwork(PendingArtwork pendingArtwork) {
        pendingArtworkRepository.delete(pendingArtwork);
        emailService.sendRejectionEmail(pendingArtwork.getArtistId(), pendingArtwork);
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

    public List<PendingArtwork> getAllPendingArtworks() {
        return pendingArtworkRepository.findAll();
    }
}

package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.*;
import com.setpteam3.vartgallery.repository.ArtworkRepository;
import com.setpteam3.vartgallery.repository.GenreRepository;
import com.setpteam3.vartgallery.repository.PendingUserRepository;
import com.setpteam3.vartgallery.repository.UserRepository;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    private final UserRepository userRepository;
    private final PendingUserRepository pendingUserRepository;
    private final ArtworkRepository artworkRepository;
    private final GenreRepository genreRepository;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;
    private final Path uploadPath = Paths.get("src/main/resources/static/portrait");

    public UserService(UserRepository userRepository, PendingUserRepository pendingUserRepository, GenreRepository genreRepository, ArtworkRepository artworkRepository, EmailService emailService, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.pendingUserRepository = pendingUserRepository;
        this.genreRepository = genreRepository;
        this.artworkRepository = artworkRepository;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;

        try {
            Files.createDirectories(uploadPath);
        } catch (IOException e) {
            throw new RuntimeException("Could not create upload directory", e);
        }
    }

    public List<User> getAllUsers() {
        return userRepository.findByActive("Y");
    }

    public Optional<User> getUserById(int id) {
        return userRepository.findById(id);
    }

    public void deleteUser(int id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            User u = user.get();
            u.setActive("N");
            userRepository.save(u);
        }
    }

    public Page<User> getArtists(Pageable pageable) {
        return userRepository.findByRoleAndActive("artist", "Y", pageable);
    }

    public Page<User> filterArtists(String name, List<Integer> genreIds, Pageable pageable) {
        return userRepository.findArtistsByFilters(name, genreIds, "Y", pageable);
    }

    public boolean addArtworkToCart(int artworkId, String username) {
        User user = userRepository.findByEmail(username);
        if (user != null) {
            Optional<Artwork> artworkOptional = artworkRepository.findById(artworkId);
            if (artworkOptional.isPresent()) {
                Artwork artwork = artworkOptional.get();
                user.getCart().add(artwork);
                userRepository.save(user);
                return true;
            }
        }
        return false;
    }

    public boolean toggleLikeArtwork(int artworkId, String username) {
        User user = userRepository.findByEmail(username);
        if (user != null) {
            Optional<Artwork> artworkOptional = artworkRepository.findById(artworkId);
            if (artworkOptional.isPresent()) {
                Artwork artwork = artworkOptional.get();
                if (user.getLikedArtworks().contains(artwork)) {
                    user.getLikedArtworks().remove(artwork);
                } else {
                    user.getLikedArtworks().add(artwork);
                }
                userRepository.save(user);
                return user.getLikedArtworks().contains(artwork);
            }
        }
        return false;
    }

    public boolean isArtworkLikedByUser(int artworkId, String username) {
        User user = userRepository.findByEmail(username);
        if (user != null) {
            Optional<Artwork> artworkOptional = artworkRepository.findById(artworkId);
            return artworkOptional.isPresent() && user.getLikedArtworks().contains(artworkOptional.get());
        }
        return false;
    }

    public User authenticateUser(String email, String password) {
        User user = userRepository.findActiveUserByEmail(email);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public User authenticateAdmin(String email, String password) {
        User user = userRepository.findActiveUserByEmail(email);
        if (user != null && "admin".equals(user.getRole()) && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public void insertPendingUser(String name, String email, String password, String role, String portfolio,
                                  String description, MultipartFile portrait, String address,
                                  String phone, String genreIds) throws IOException {
        String fileName = saveImage(portrait);
        String encodedPassword = passwordEncoder.encode(password);

        PendingUser pendingUser = new PendingUser();
        pendingUser.setName(name);
        pendingUser.setEmail(email);
        pendingUser.setPassword(encodedPassword);
        pendingUser.setRole(role);
        pendingUser.setPortfolio(portfolio);
        pendingUser.setDescription(description);
        pendingUser.setPortrait(fileName);
        pendingUser.setAddress(address);
        pendingUser.setPhone(phone);
        pendingUser.setGenreIds(genreIds);

        pendingUserRepository.save(pendingUser);
    }

    public void approveUser(PendingUser pendingUser) {
        User user = new User();
        user.setEmail(pendingUser.getEmail());
        user.setPassword(pendingUser.getPassword());
        user.setRole(pendingUser.getRole());
        user.setName(pendingUser.getName());
        user.setDescription(pendingUser.getDescription());
        user.setPortrait(pendingUser.getPortrait());
        user.setAddress(pendingUser.getAddress());
        user.setPhone(pendingUser.getPhone());

        if (pendingUser.getGenreIds() != null && !pendingUser.getGenreIds().isEmpty()) {
            List<Integer> genreIds = Arrays.stream(pendingUser.getGenreIds().split(","))
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
            Set<Genre> genres = new HashSet<>(genreRepository.findAllById(genreIds));
            user.setGenres(genres);
        } else {
            user.setGenres(Collections.emptySet());
        }

        userRepository.save(user);
        emailService.sendAccountApprovalEmail(pendingUser);
        pendingUserRepository.delete(pendingUser);
    }

    public void rejectUser(PendingUser pendingUser) {
        emailService.sendAccountRejectionEmail(pendingUser);
        pendingUserRepository.delete(pendingUser);
    }

    public String saveImage(MultipartFile image) throws IOException {
        String fileName = System.currentTimeMillis() + "_" + image.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);
        Thumbnails.of(image.getInputStream()).size(600, 600).toFile(filePath.toFile());
        return fileName;
    }

    public List<PendingUser> getAllPendingUsers() {
        return pendingUserRepository.findAll();
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public User findById(int id) {
        return userRepository.findById(id).orElse(null);
    }

    public void save(User user) {
        userRepository.save(user);
    }

    public void deleteById(int id) {
        userRepository.deleteById(id);
    }

    public User emailExists(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findActiveUserByEmail(email);
        if (user != null) {
            return user;
        } else {
            throw new UsernameNotFoundException("User not found with email: " + email);
        }
    }
}

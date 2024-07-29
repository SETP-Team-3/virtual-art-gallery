package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.repository.ArtworkRepository;
import com.setpteam3.vartgallery.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {
    private final UserRepository userRepository;
    private final ArtworkRepository artworkRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, ArtworkRepository artworkRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.artworkRepository = artworkRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> getUserById(int id) {
        return userRepository.findById(id);
    }

    public Page<User> getArtists(Pageable pageable) {
        return userRepository.findByRole("artist", pageable);
    }

    public Page<User> filterArtists(String name, List<Integer> genreIds, Pageable pageable) {
        return userRepository.findArtistsByFilters(name, genreIds, pageable);
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
        User user = userRepository.findByEmail(email);
        if (user != null && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public User authenticateAdmin(String email, String password) {
        User user = userRepository.findByEmail(email);
        if (user != null && "admin".equals(user.getRole()) && passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email);
        if (user != null) {
            return user;
        } else {
            throw new UsernameNotFoundException("User not found with email: " + email);
        }
    }
}

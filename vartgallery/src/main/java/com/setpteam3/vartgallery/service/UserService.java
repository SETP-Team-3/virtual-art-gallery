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
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {
    private final UserRepository userRepository;
    private final ArtworkRepository artworkRepository;

    public UserService(UserRepository userRepository, ArtworkRepository artworkRepository) {
        this.userRepository = userRepository;
        this.artworkRepository = artworkRepository;
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
        Optional<User> userOptional = userRepository.findByEmail(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
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
        Optional<User> userOptional = userRepository.findByEmail(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
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
        Optional<User> userOptional = userRepository.findByEmail(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            Optional<Artwork> artworkOptional = artworkRepository.findById(artworkId);
            return artworkOptional.isPresent() && user.getLikedArtworks().contains(artworkOptional.get());
        }
        return false;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<User> userOptional = userRepository.findByEmail(email);
        User user = userOptional.orElseThrow(() -> new UsernameNotFoundException("User not found"));

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .roles(user.getRole())
                .build();
    }
}

package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.Genre;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.GenreService;
import com.setpteam3.vartgallery.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/gallery")
public class GalleryController {
    private final ArtworkService artworkService;
    private final UserService userService;
    private final GenreService genreService;

    public GalleryController(ArtworkService artworkService, UserService userService, GenreService genreService) {
        this.artworkService = artworkService;
        this.userService = userService;
        this.genreService = genreService;
    }

    @GetMapping
    public String index(Model model,
                        @RequestParam Optional<Integer> page,
                        @RequestParam Optional<Integer> size) {
        int currentPage = page.orElse(1) - 1;
        int pageSize = size.orElse(8);
        Pageable pageable = PageRequest.of(currentPage, pageSize);

        Page<Artwork> artworksPage = artworkService.getLatestArtworks(pageable);
        Page<User> artistsPage = userService.getArtists(pageable);
        List<Genre> genres = genreService.getAllGenres();

        model.addAttribute("artworks", artworksPage.getContent());
        model.addAttribute("totalArtworkPages", artworksPage.getTotalPages());
        model.addAttribute("currentArtworkPage", currentPage + 1);

        model.addAttribute("artists", artistsPage.getContent());
        model.addAttribute("totalArtistPages", artistsPage.getTotalPages());
        model.addAttribute("currentArtistPage", currentPage + 1);

        model.addAttribute("genres", genres);
        return "public/gallery";
    }

    @PostMapping("/filter-artworks")
    @ResponseBody
    public Page<Artwork> filterArtworks(@RequestBody Map<String, Object> filters,
                                        @RequestParam Optional<Integer> page,
                                        @RequestParam Optional<Integer> size) {
        String title = (String) filters.get("title");
        String artist = (String) filters.get("artist");
        Double minPrice = Double.valueOf(filters.get("minPrice").toString());
        Double maxPrice = Double.valueOf(filters.get("maxPrice").toString());
        List<Integer> genreIds = (List<Integer>) filters.get("genres");

        int currentPage = page.orElse(1) - 1;
        int pageSize = size.orElse(8);
        Pageable pageable = PageRequest.of(currentPage, pageSize);

        return artworkService.filterArtworks(title, artist, minPrice, maxPrice, genreIds, pageable);
    }

    @PostMapping("/filter-artists")
    @ResponseBody
    public Page<User> filterArtists(@RequestBody Map<String, Object> filters,
                                    @RequestParam Optional<Integer> page,
                                    @RequestParam Optional<Integer> size) {
        String name = (String) filters.get("name");
        List<Integer> genreIds = (List<Integer>) filters.get("genres");

        int currentPage = page.orElse(1) - 1;
        int pageSize = size.orElse(8);
        Pageable pageable = PageRequest.of(currentPage, pageSize);

        return userService.filterArtists(name, genreIds, pageable);
    }
}

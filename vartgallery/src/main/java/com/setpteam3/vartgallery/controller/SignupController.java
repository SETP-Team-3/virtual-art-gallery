package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Genre;
import com.setpteam3.vartgallery.service.GenreService;
import com.setpteam3.vartgallery.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/signup")
public class SignupController {
    private final UserService userService;
    private final GenreService genreService;

    public SignupController(UserService userService, GenreService genreService) {
        this.userService = userService;
        this.genreService = genreService;
    }

    @GetMapping
    public String signup(Model model) {
        List<Genre> genres = genreService.getAllGenres();
        model.addAttribute("genres", genres);

        return "public/signup";
    }

    @PostMapping("/submit")
    public ResponseEntity<?> submitSignup(@RequestParam("name") String name,
                                          @RequestParam("email") String email,
                                          @RequestParam("password") String password,
                                          @RequestParam("role") String role,
                                          @RequestParam(value = "portfolio", required = false) String portfolio,
                                          @RequestParam(value = "description", required = false) String description,
                                          @RequestParam("portrait") MultipartFile portrait,
                                          @RequestParam(value = "address", required = false) String address,
                                          @RequestParam(value = "phone", required = false) String phone,
                                          @RequestParam(value = "genre_ids", required = false) String genreIds) throws IOException {
        try {
            userService.insertPendingUser(name, email, password, role, portfolio, description, portrait, address, phone, genreIds);
            return ResponseEntity.ok(Collections.singletonMap("status", "success"));
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "Failed to submit account request"));
        }
    }
}

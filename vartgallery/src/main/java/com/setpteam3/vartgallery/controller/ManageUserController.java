package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.PendingUser;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.repository.PendingUserRepository;
import com.setpteam3.vartgallery.repository.UserRepository;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class ManageUserController {
    private final PendingUserRepository pendingUserRepository;
    private final UserRepository userRepository;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public ManageUserController(PendingUserRepository pendingUserRepository, UserRepository userRepository, UserService userService, PasswordEncoder passwordEncoder) {
        this.pendingUserRepository = pendingUserRepository;
        this.userRepository = userRepository;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/manage-users")
    public String manageUsers(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        User adminUser = (User) (session != null ? session.getAttribute("adminUser") : null);
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            return "redirect:/admin/login";
        }

        List<User> users = userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/manage-users";
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<?> getUser(@PathVariable int id) {
        try {
            Optional<User> user = userService.getUserById(id);
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @PostMapping("/user")
    public ResponseEntity<?> createUser(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String role,
            @RequestParam String name,
            @RequestParam(required = false) String description,
            @RequestParam MultipartFile portrait,
            @RequestParam(required = false) String address,
            @RequestParam(required = false) String phone) {

        if (userService.emailExists(email) != null) {
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }

        String encodedPassword = passwordEncoder.encode(password);
        String fileName;
        try {
            fileName = userService.saveImage(portrait);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error saving image");
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(encodedPassword);
        user.setRole(role);
        user.setName(name);
        user.setDescription(description);
        user.setPortrait(fileName);
        user.setAddress(address);
        user.setPhone(phone);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());

        userService.save(user);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/user/{id}")
    public ResponseEntity<?> updateUser(
            @PathVariable int id,
            @RequestParam String email,
            @RequestParam(required = false) String password,
            @RequestParam String role,
            @RequestParam String name,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) MultipartFile portrait,
            @RequestParam(required = false) String address,
            @RequestParam(required = false) String phone) {

        User user = userService.findById(id);
        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }

        user.setEmail(email);
        if (password != null && !password.isEmpty()) {
            user.setPassword(passwordEncoder.encode(password));
        }
        user.setRole(role);
        user.setName(name);
        user.setDescription(description);
        if (portrait != null && !portrait.isEmpty()) {
            try {
                String fileName = userService.saveImage(portrait);
                user.setPortrait(fileName);
            } catch (IOException e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error saving image");
            }
        }
        user.setAddress(address);
        user.setPhone(phone);
        user.setUpdatedAt(LocalDateTime.now());

        userService.save(user);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/user/{id}")
    public ResponseEntity<?> deleteUser(@PathVariable int id) {
        try {
            userService.deleteUser(id);
            return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @GetMapping("/user-details")
    public ResponseEntity<?> userDetails(@RequestParam("userId") int userId) {
        try {
            Optional<User> user = userService.getUserById(userId);
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @GetMapping("/pending-users")
    public String showPendingUsers(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        User adminUser = (User) (session != null ? session.getAttribute("adminUser") : null);
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            return "redirect:/admin/login";
        }

        List<PendingUser> pendingUsers = pendingUserRepository.findAll();
        model.addAttribute("pendingUsers", pendingUsers);
        return "admin/pending-users";
    }

    @PostMapping("/approve-user")
    public ResponseEntity<?> approveUser(@RequestParam("userId") int userId) {
        try {
            PendingUser pendingUser = pendingUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found with id " + userId));
            userService.approveUser(pendingUser);
            return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @PostMapping("/reject-user")
    public ResponseEntity<?> rejectUser(@RequestParam("userId") int userId) {
        try {
            PendingUser pendingUser = pendingUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found with id " + userId));
            userService.rejectUser(pendingUser);
            return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }
}

package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.PendingUser;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.repository.PendingUserRepository;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class ManageUserController {
    private final PendingUserRepository pendingUserRepository;
    private final UserService userService;

    public ManageUserController(PendingUserRepository pendingUserRepository, UserService userService) {
        this.pendingUserRepository = pendingUserRepository;
        this.userService = userService;
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

    @GetMapping("/user-details")
    public ResponseEntity<?> userDetails(@RequestParam("userId") int userId) {
        try {
            Optional<User> user = userService.getUserById(userId);
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", e.getMessage()));
        }
    }

    @PostMapping("/delete-user")
    public ResponseEntity<?> deleteUser(@RequestParam("userId") int userId) {
        try {
            userService.deleteUser(userId);
            return ResponseEntity.ok().body(Collections.singletonMap("status", "success"));
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

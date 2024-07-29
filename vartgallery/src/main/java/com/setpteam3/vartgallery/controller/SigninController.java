package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
@RequestMapping("/sign")
public class SigninController {
    private final UserService userService;

    public SigninController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/in")
    public ResponseEntity<?> handleSignin(@RequestParam String signinEmail, @RequestParam String signinPassword, Model model, HttpServletRequest request) {
        try {
            User user = userService.authenticateUser(signinEmail, signinPassword);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("status", "success"));
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.singletonMap("error", "Invalid email or password"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An error occurred while signing in"));
        }
    }

    @PostMapping("/out")
    public ResponseEntity<?> handleSignout(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("user");
            return ResponseEntity.status(HttpStatus.OK).body(Collections.singletonMap("status", "success"));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("error", "An error occurred while signing out"));
        }
    }

    @GetMapping("/profile")
    public String userProfile(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        model.addAttribute("username", userDetails.getUsername());
        return "public/profile";
    }
}

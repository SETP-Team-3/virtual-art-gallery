package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.PendingArtwork;
import com.setpteam3.vartgallery.entity.PendingUser;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class DashboardController {
    private final UserService userService;
    private final ArtworkService artworkService;

    public DashboardController(UserService userService, ArtworkService artworkService) {
        this.userService = userService;
        this.artworkService = artworkService;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        User adminUser = (User) (session != null ? session.getAttribute("adminUser") : null);
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            return "redirect:/admin/login";
        }

        List<PendingUser> pendingUsers = userService.getAllPendingUsers();
        List<PendingArtwork> pendingArtworks = artworkService.getAllPendingArtworks();

        model.addAttribute("pendingUsers", pendingUsers);
        model.addAttribute("pendingArtworks", pendingArtworks);

        return "admin/dashboard";
    }
}

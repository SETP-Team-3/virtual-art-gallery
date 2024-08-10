package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.Transaction;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.ArtworkService;
import com.setpteam3.vartgallery.service.TransactionService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/my-transactions")
public class MyTransactionsController {
    private final ArtworkService artworkService;
    private final TransactionService transactionService;

    public MyTransactionsController(ArtworkService artworkService, TransactionService transactionService) {
        this.artworkService = artworkService;
        this.transactionService = transactionService;
    }

    @GetMapping
    public String viewTransactions(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user != null) {
            List<Transaction> transactions = transactionService.getTransactionsByUserId(user.getId());
            model.addAttribute("transactions", transactions);

            if ("artist".equals(user.getRole())) {
                List<Artwork> artworksSold = artworkService.findArtworksSoldByArtistId(user);
                model.addAttribute("artworksSold", artworksSold);
            }

            model.addAttribute("user", user);
            return "public/my-transactions";
        } else {
            return "public/home";
        }
    }
}

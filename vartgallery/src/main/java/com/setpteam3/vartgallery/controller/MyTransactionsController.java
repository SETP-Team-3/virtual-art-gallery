package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Transaction;
import com.setpteam3.vartgallery.entity.User;
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
    private final TransactionService transactionService;

    public MyTransactionsController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @GetMapping
    public String viewTransactions(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            List<Transaction> transactions = transactionService.getTransactionsByUserId(user.getId());
            model.addAttribute("transactions", transactions);
            return "public/my-transactions";
        } else {
            return "public/home";
        }
    }
}

package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.entity.Transaction;
import com.setpteam3.vartgallery.entity.User;
import com.setpteam3.vartgallery.service.TransactionService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ManageTransactionController {
    private final TransactionService transactionService;

    public ManageTransactionController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @GetMapping("/admin/manage-transactions")
    public String manageTransactions(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        User adminUser = (User) (session != null ? session.getAttribute("adminUser") : null);
        if (adminUser == null || !"admin".equals(adminUser.getRole())) {
            return "redirect:/admin/login";
        }

        List<Object[]> transactions = transactionService.findAllGroupedByTransactionId();
        model.addAttribute("transactions", transactions);
        return "admin/manage-transactions";
    }

    @GetMapping("/admin/transaction-details")
    public ResponseEntity<?> transactionDetails(@RequestParam("transactionId") String transactionId) {
        List<Transaction> transactions = transactionService.findByTransactionId(transactionId);
        return ResponseEntity.ok(transactions);
    }
}

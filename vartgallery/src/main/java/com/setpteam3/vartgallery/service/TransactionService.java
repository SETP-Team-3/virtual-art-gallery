package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Transaction;
import com.setpteam3.vartgallery.repository.TransactionRepository;
import org.springframework.stereotype.Service;

@Service
public class TransactionService {
    private final TransactionRepository transactionRepository;

    public TransactionService(TransactionRepository transactionRepository) {
        this.transactionRepository = transactionRepository;
    }

    public void save(Transaction transaction) {
        transactionRepository.save(transaction);
    }
}

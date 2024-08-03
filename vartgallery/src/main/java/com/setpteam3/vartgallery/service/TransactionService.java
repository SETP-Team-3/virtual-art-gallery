package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.Transaction;
import com.setpteam3.vartgallery.repository.ArtworkRepository;
import com.setpteam3.vartgallery.repository.TransactionRepository;
import com.setpteam3.vartgallery.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TransactionService {
    private final TransactionRepository transactionRepository;
    private final UserRepository userRepository;
    private final ArtworkRepository artworkRepository;

    public TransactionService(TransactionRepository transactionRepository, UserRepository userRepository, ArtworkRepository artworkRepository) {
        this.transactionRepository = transactionRepository;
        this.userRepository = userRepository;
        this.artworkRepository = artworkRepository;
    }

    public List<Object[]> findAllGroupedByTransactionId() {
        return transactionRepository.findAllGroupedByTransactionId();
    }

    public List<Transaction> findByTransactionId(String transactionId) {
        List<Transaction> transactions = transactionRepository.findByTransactionId(transactionId);
        return transactions.stream().map(transaction -> {
            transaction.setUserEmail(userRepository.findById(transaction.getUserId()).orElseThrow().getEmail());
            transaction.setArtworkTitle(artworkRepository.findById(transaction.getArtworkId()).orElseThrow().getTitle());
            return transaction;
        }).collect(Collectors.toList());
    }

    public List<Transaction> getTransactionsByUserId(int userId) {
        List<Transaction> transactions = transactionRepository.findByUserId(userId);
        return transactions.stream().map(transaction -> {
            Artwork artwork = artworkRepository.findById(transaction.getArtworkId()).orElse(null);
            if (artwork != null) {
                transaction.setArtworkTitle(artwork.getTitle());
            }
            return transaction;
        }).collect(Collectors.toList());
    }

    public void save(Transaction transaction) {
        transactionRepository.save(transaction);
    }
}

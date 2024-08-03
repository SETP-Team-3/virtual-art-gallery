package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Integer> {
    @Query("SELECT t.transactionId, t.userId, MIN(t.transactionDate) AS transactionDate, SUM(t.amount) AS totalAmount FROM Transaction t GROUP BY t.transactionId, t.userId")
    List<Object[]> findAllGroupedByTransactionId();

    List<Transaction> findByTransactionId(String transactionId);

    List<Transaction> findByUserId(int userId);
}

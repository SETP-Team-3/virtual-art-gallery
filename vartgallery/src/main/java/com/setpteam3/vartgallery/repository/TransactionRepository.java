package com.setpteam3.vartgallery.repository;

import com.setpteam3.vartgallery.entity.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransactionRepository extends JpaRepository<Transaction, Integer> {

}

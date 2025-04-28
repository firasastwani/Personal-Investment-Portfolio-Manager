package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Portfolio;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    List<Transaction> findByPortfolio(Portfolio portfolio);
    List<Transaction> findByPortfolioId(Long portfolioId);
} 
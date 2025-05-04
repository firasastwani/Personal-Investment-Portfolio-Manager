package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.Security;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Integer> {
    List<Transaction> findByPortfolio(Portfolio portfolio);
    List<Transaction> findByPortfolio_PortfolioId(Integer portfolioId);
    List<Transaction> findBySecurity(Security security);
} 
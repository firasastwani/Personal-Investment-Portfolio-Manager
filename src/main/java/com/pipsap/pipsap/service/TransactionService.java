package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    public Transaction createTransaction(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    public Optional<Transaction> getTransactionById(Long id) {
        return transactionRepository.findById(id);
    }

    public List<Transaction> getTransactionsByPortfolio(Portfolio portfolio) {
        return transactionRepository.findByPortfolio(portfolio);
    }

    public List<Transaction> getTransactionsByPortfolioId(Long portfolioId) {
        return transactionRepository.findByPortfolioId(portfolioId);
    }

    public Transaction updateTransaction(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    public void deleteTransaction(Long id) {
        transactionRepository.deleteById(id);
    }
} 
package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;

    public List<Transaction> getTransactionsByPortfolio(Portfolio portfolio) {
        return transactionRepository.findByPortfolio(portfolio);
    }

    public Transaction createTransaction(Transaction transaction) {
        return transactionRepository.save(transaction);
    }

    public Transaction getTransactionById(Integer transactionId) {
        return transactionRepository.findById(transactionId).orElse(null);
    }

    public void deleteTransaction(Integer transactionId) {
        transactionRepository.deleteById(transactionId);
    }
} 
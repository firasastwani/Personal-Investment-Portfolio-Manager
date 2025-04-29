package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.service.TransactionService;
import com.pipsap.pipsap.service.PortfolioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/transactions")
public class TransactionController {
    @Autowired
    private TransactionService transactionService;

    @Autowired
    private PortfolioService portfolioService;

    @GetMapping("/portfolio/{portfolioId}")
    public ResponseEntity<List<Transaction>> getTransactionsByPortfolio(@PathVariable Integer portfolioId) {
        Portfolio portfolio = portfolioService.getPortfolioById(portfolioId).orElse(null);
        if (portfolio == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(transactionService.getTransactionsByPortfolio(portfolio));
    }

    @PostMapping
    public ResponseEntity<Transaction> createTransaction(@RequestBody Transaction transaction) {
        return ResponseEntity.ok(transactionService.createTransaction(transaction));
    }

    @GetMapping("/{transactionId}")
    public ResponseEntity<Transaction> getTransactionById(@PathVariable Integer transactionId) {
        Transaction transaction = transactionService.getTransactionById(transactionId);
        if (transaction == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(transaction);
    }

    @DeleteMapping("/{transactionId}")
    public ResponseEntity<Void> deleteTransaction(@PathVariable Integer transactionId) {
        transactionService.deleteTransaction(transactionId);
        return ResponseEntity.ok().build();
    }
} 
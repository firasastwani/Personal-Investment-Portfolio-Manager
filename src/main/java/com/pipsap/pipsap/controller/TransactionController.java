package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api/transactions")
public class TransactionController {
    @Autowired
    private TransactionService transactionService;

    @PostMapping
    public ResponseEntity<Transaction> createTransaction(
            @RequestParam Integer portfolioId,
            @RequestParam String symbol,
            @RequestParam Transaction.TransactionType type,
            @RequestParam BigDecimal quantity,
            @RequestParam BigDecimal price,
            @RequestParam(required = false) String notes) {
        try {
            Transaction transaction = transactionService.createTransaction(
                portfolioId, symbol, type, quantity, price, notes);
            return ResponseEntity.ok(transaction);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/portfolio/{portfolioId}")
    public ResponseEntity<List<Transaction>> getTransactionsByPortfolio(@PathVariable Integer portfolioId) {
        try {
            List<Transaction> transactions = transactionService.getTransactionsByPortfolioId(portfolioId);
            return ResponseEntity.ok(transactions);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Transaction> getTransactionById(@PathVariable Integer id) {
        try {
            return transactionService.getTransactionById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTransaction(@PathVariable Integer id) {
        try {
            transactionService.deleteTransaction(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
} 
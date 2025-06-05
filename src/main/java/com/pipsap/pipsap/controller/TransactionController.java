package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.service.TransactionService;
import com.pipsap.pipsap.service.PortfolioService;
import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/transactions")
public class TransactionController {
    private final TransactionService transactionService;
    private final PortfolioService portfolioService;
    private final UserService userService;

    @Autowired
    public TransactionController(TransactionService transactionService,
                               PortfolioService portfolioService,
                               UserService userService) {
        this.transactionService = transactionService;
        this.portfolioService = portfolioService;
        this.userService = userService;
    }

    private User getCurrentUser() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getUserByUsername(username);
        if (user == null) {
            throw new RuntimeException("User not found");
        }
        return user;
    }

    private void validatePortfolioOwnership(Portfolio portfolio) {
        User currentUser = getCurrentUser();
        if (!portfolio.getUser().getUserId().equals(currentUser.getUserId())) {
            throw new RuntimeException("Not authorized to access this portfolio");
        }
    }

    @PostMapping
    public ResponseEntity<Transaction> createTransaction(
            @RequestParam Integer portfolioId,
            @RequestParam String symbol,
            @RequestParam Transaction.TransactionType type,
            @RequestParam BigDecimal quantity,
            @RequestParam BigDecimal price,
            @RequestParam(required = false) String notes) {
        try {
            // Validate portfolio ownership
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            validatePortfolioOwnership(portfolio);

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
            // Validate portfolio ownership
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            validatePortfolioOwnership(portfolio);

            List<Transaction> transactions = transactionService.getTransactionsByPortfolioId(portfolioId);
            return ResponseEntity.ok(transactions);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Transaction> getTransactionById(@PathVariable Integer id) {
        try {
            Optional<Transaction> transaction = transactionService.getTransactionById(id);
            if (transaction.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            // Validate portfolio ownership
            validatePortfolioOwnership(transaction.get().getPortfolio());

            return ResponseEntity.ok(transaction.get());
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTransaction(@PathVariable Integer id) {
        try {
            Optional<Transaction> transaction = transactionService.getTransactionById(id);
            if (transaction.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            // Validate portfolio ownership
            validatePortfolioOwnership(transaction.get().getPortfolio());

            transactionService.deleteTransaction(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
} 
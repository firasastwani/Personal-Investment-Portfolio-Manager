package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.service.PortfolioAnalyticsService;
import com.pipsap.pipsap.service.PortfolioService;
import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/analytics")
public class PortfolioAnalyticsController {

    private final PortfolioAnalyticsService portfolioAnalyticsService;
    private final PortfolioService portfolioService;
    private final UserService userService;

    @Autowired
    public PortfolioAnalyticsController(PortfolioAnalyticsService portfolioAnalyticsService,
                                      PortfolioService portfolioService,
                                      UserService userService) {
        this.portfolioAnalyticsService = portfolioAnalyticsService;
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

    @GetMapping("/portfolio/{portfolioId}/sector-diversification")
    public ResponseEntity<List<Map<String, Object>>> getPortfolioSectorDiversification(
            @PathVariable Integer portfolioId) {
        try {
            // Validate portfolio ownership
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            validatePortfolioOwnership(portfolio);

            return ResponseEntity.ok(portfolioAnalyticsService.getPortfolioSectorDiversification(portfolioId));
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/securities/top-performing")
    public ResponseEntity<List<Map<String, Object>>> getTopPerformingSecurities(
            @RequestParam(defaultValue = "1") int minPortfolios,
            @RequestParam(defaultValue = "10") int limit) {
        try {
            // Ensure user is authenticated
            getCurrentUser();
            return ResponseEntity.ok(portfolioAnalyticsService.getTopPerformingSecurities(minPortfolios, limit));
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/portfolio/{portfolioId}/transactions")
    public ResponseEntity<List<Map<String, Object>>> getPortfolioTransactionHistory(
            @PathVariable Integer portfolioId,
            @RequestParam(defaultValue = "10") int limit) {
        try {
            // Validate portfolio ownership
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            validatePortfolioOwnership(portfolio);

            return ResponseEntity.ok(portfolioAnalyticsService.getPortfolioTransactionHistory(portfolioId, limit));
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/portfolio/{portfolioId}/total-value")
    public ResponseEntity<Double> getTotalValueOfHoldings(
            @PathVariable Integer portfolioId) {
        try {
            // Validate portfolio ownership
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            validatePortfolioOwnership(portfolio);

            return ResponseEntity.ok(portfolioAnalyticsService.getTotalValueOfHoldings(portfolioId));
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/total-account-value")
    public ResponseEntity<BigDecimal> getTotalAccountValue() {
        try {
            User currentUser = getCurrentUser();
            return ResponseEntity.ok(currentUser.getTotalAccountValue());
        } catch (Exception e) {
            System.err.println("Error in getTotalAccountValue: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(401).build();
        }
    }

    @GetMapping("/historical-tav")
    public ResponseEntity<List<Map<String, Object>>> getHistoricalTAVData(
            @RequestParam(defaultValue = "7") int days) {
        try {
            User currentUser = getCurrentUser();
            return ResponseEntity.ok(portfolioAnalyticsService.getHistoricalTAVData(currentUser, days));
        } catch (Exception e) {
            System.err.println("Error in getHistoricalTAVData: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(401).build();
        }
    }
} 
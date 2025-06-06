package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.service.PortfolioService;
import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.Optional;
import java.util.Map;
import java.util.List;
import org.springframework.security.core.context.SecurityContextHolder;

@RestController
@RequestMapping("/api/portfolios")
@CrossOrigin(origins = "*")
public class PortfolioController {

    @Autowired
    private PortfolioService portfolioService;

    @Autowired
    private UserService userService;

    @PostMapping("/getPortfoliosForUser")
    public ResponseEntity<List<Portfolio>> getPortfoliosByUsername(@RequestBody Map<String, String> request) {
        String username = request.get("username");
        Integer userId = userService.getUserIdByUsername(username);
        if (userId == null) {
            return ResponseEntity.notFound().build();
        }
        List<Portfolio> portfolios = portfolioService.getPortfoliosByUserId(userId);
        return ResponseEntity.ok(portfolios);
    }

    @GetMapping("/{id}/holdings")
    public ResponseEntity<List<PortfolioHolding>> getPortfolioHoldings(@PathVariable Integer id) {
        List<PortfolioHolding> holdings = portfolioService.getPortfolioHoldings(id);
        return ResponseEntity.ok(holdings);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPortfolio(@PathVariable Integer id) {
        Optional<Portfolio> portfolio = portfolioService.getPortfolioById(id);
        if (portfolio.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(portfolio.get());
    }

    @PostMapping
    public ResponseEntity<?> createPortfolio(@RequestBody Portfolio portfolio) {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            Portfolio createdPortfolio = portfolioService.createPortfolioForUser(portfolio, username);
            return ResponseEntity.ok(createdPortfolio);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to create portfolio: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updatePortfolio(@PathVariable Integer id, @RequestBody Portfolio portfolio) {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            User user = userService.getUserByUsername(username);
            Portfolio updatedPortfolio = portfolioService.updatePortfolioWithValidation(portfolio, user);
            return ResponseEntity.ok(updatedPortfolio);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to update portfolio: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePortfolio(@PathVariable Integer id) {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            User user = userService.getUserByUsername(username);
            portfolioService.deletePortfolioWithValidation(id, user);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to delete portfolio: " + e.getMessage());
        }
    }
} 
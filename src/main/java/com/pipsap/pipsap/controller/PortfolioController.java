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
        System.out.println("Fetching portfolios for username: " + username);

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

        System.out.println("PortfolioController: Getting portfolio with id: " + id);

        Optional<Portfolio> portfolio = portfolioService.getPortfolioById(id);

        if (portfolio.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(portfolio.get());
    }

    @PostMapping
    public ResponseEntity<?> createPortfolio(@RequestBody Portfolio portfolio) {
        try {
            // Get the authenticated user from the security context
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            User user = userService.getUserByUsername(username);
            
            if (user == null) {
                return ResponseEntity.status(401).body("User not found");
            }
            
            // Set the user for the portfolio
            portfolio.setUser(user);
            Portfolio createdPortfolio = portfolioService.createPortfolio(portfolio);
            return ResponseEntity.ok(createdPortfolio);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Failed to create portfolio: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updatePortfolio(@PathVariable Integer id, @RequestBody Portfolio portfolio) {

        Portfolio updatedPortfolio = portfolioService.updatePortfolio(portfolio);
        return ResponseEntity.ok(updatedPortfolio);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePortfolio(@PathVariable Integer id) {
        
        portfolioService.deletePortfolio(id);
        return ResponseEntity.ok().build();
    }
} 
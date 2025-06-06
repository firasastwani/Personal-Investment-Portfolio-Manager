package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.service.PortfolioHoldingService;
import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/holdings")
public class PortfolioHoldingController {

    private final PortfolioHoldingService portfolioHoldingService;
    private final UserService userService;

    @Autowired
    public PortfolioHoldingController(PortfolioHoldingService portfolioHoldingService,
                                    UserService userService) {
        this.portfolioHoldingService = portfolioHoldingService;
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

    @PostMapping("/buy/{portfolioId}/{symbol}")
    public ResponseEntity<?> buySecurity(
            @PathVariable Integer portfolioId,
            @PathVariable String symbol,
            @RequestParam Integer quantity) {
        try {
            User user = getCurrentUser();
            Transaction transaction = portfolioHoldingService.buySecurity(portfolioId, symbol, quantity, user);
            return ResponseEntity.ok(transaction);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/sell/{portfolioId}/{symbol}")
    public ResponseEntity<?> sellSecurity(
            @PathVariable Integer portfolioId,
            @PathVariable String symbol,
            @RequestParam Integer quantity) {
        try {
            User user = getCurrentUser();
            Transaction transaction = portfolioHoldingService.sellSecurity(portfolioId, symbol, quantity, user);
            return ResponseEntity.ok(transaction);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/portfolio/{portfolioId}")
    public ResponseEntity<?> getHoldingsByPortfolio(@PathVariable Integer portfolioId) {
        try {
            User user = getCurrentUser();
            List<PortfolioHolding> holdings = portfolioHoldingService.getHoldingsByPortfolioWithValidation(portfolioId, user);
            return ResponseEntity.ok(holdings);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getHoldingById(@PathVariable Integer id) {
        try {
            User user = getCurrentUser();
            PortfolioHolding holding = portfolioHoldingService.getHoldingByIdWithValidation(id, user);
            return ResponseEntity.ok(holding);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
} 
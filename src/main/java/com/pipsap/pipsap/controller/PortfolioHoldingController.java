package com.pipsap.pipsap.controller;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.service.PortfolioHoldingService;
import com.pipsap.pipsap.service.PortfolioService;
import com.pipsap.pipsap.service.TransactionService;
import com.pipsap.pipsap.service.SecurityService;
import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/holdings")
public class PortfolioHoldingController {

    private final PortfolioHoldingService portfolioHoldingService;
    private final PortfolioService portfolioService;
    private final TransactionService transactionService;
    private final SecurityService securityService;
    private final UserService userService;

    @Autowired
    public PortfolioHoldingController(PortfolioHoldingService portfolioHoldingService, 
                                    PortfolioService portfolioService,
                                    TransactionService transactionService,
                                    SecurityService securityService,
                                    UserService userService) {
        this.portfolioHoldingService = portfolioHoldingService;
        this.portfolioService = portfolioService;
        this.transactionService = transactionService;
        this.securityService = securityService;
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

    @PostMapping("/buy/{portfolioId}/{symbol}")
    public ResponseEntity<?> buySecurity(
            @PathVariable Integer portfolioId,
            @PathVariable String symbol,
            @RequestParam Integer quantity) {
        try {
            // Get portfolio and security
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            
            // Validate portfolio ownership
            validatePortfolioOwnership(portfolio);
            
            Security security = securityService.getSecurityBySymbol(symbol)
                .orElseThrow(() -> new RuntimeException("Security not found"));

            // Create transaction
            Transaction transaction = transactionService.createTransaction(
                portfolioId,
                symbol,
                Transaction.TransactionType.BUY,
                new BigDecimal(quantity),
                security.getStaticPrice(),
                "Buy transaction"
            );

            // Update or create portfolio holding
            Optional<PortfolioHolding> existingHolding = portfolioHoldingService
                .getHoldingByPortfolioAndSecurity(portfolio, security);

            if (existingHolding.isPresent()) {
                // Update existing holding
                PortfolioHolding holding = existingHolding.get();
                int newQuantity = holding.getQuantity() + quantity;
                portfolioHoldingService.updateHolding(
                    holding.getId(),
                    newQuantity,
                    security.getStaticPrice()
                );
            } else {
                // Create new holding
                portfolioHoldingService.createHolding(portfolioId, symbol, quantity);
            }

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
            // Get portfolio and security
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            
            // Validate portfolio ownership
            validatePortfolioOwnership(portfolio);
            
            Security security = securityService.getSecurityBySymbol(symbol)
                .orElseThrow(() -> new RuntimeException("Security not found"));

            // Check if holding exists and has sufficient quantity
            Optional<PortfolioHolding> existingHolding = portfolioHoldingService
                .getHoldingByPortfolioAndSecurity(portfolio, security);

            if (existingHolding.isEmpty()) {
                return ResponseEntity.badRequest().body("No holdings found for this security");
            }

            PortfolioHolding holding = existingHolding.get();
            if (holding.getQuantity() < quantity) {
                return ResponseEntity.badRequest().body("Insufficient quantity to sell");
            }

            // Create transaction
            Transaction transaction = transactionService.createTransaction(
                portfolioId,
                symbol,
                Transaction.TransactionType.SELL,
                new BigDecimal(quantity),
                security.getStaticPrice(),
                "Sell transaction"
            );

            // Update holding quantity
            int newQuantity = holding.getQuantity() - quantity;
            if (newQuantity == 0) {
                // Delete holding if quantity becomes 0
                portfolioHoldingService.deleteHolding(holding.getId());
            } else {
                // Update holding with new quantity
                portfolioHoldingService.updateHolding(
                    holding.getId(),
                    newQuantity,
                    security.getStaticPrice()
                );
            }

            return ResponseEntity.ok(transaction);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/portfolio/{portfolioId}")
    public ResponseEntity<List<PortfolioHolding>> getHoldingsByPortfolio(@PathVariable Integer portfolioId) {
        try {
            Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
                .orElseThrow(() -> new RuntimeException("Portfolio not found"));
            
            // Validate portfolio ownership
            validatePortfolioOwnership(portfolio);
            
            List<PortfolioHolding> holdings = portfolioHoldingService.getHoldingsByPortfolioId(portfolioId);
            return ResponseEntity.ok(holdings);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<PortfolioHolding> getHoldingById(@PathVariable Integer id) {
        try {
            Optional<PortfolioHolding> holding = portfolioHoldingService.getHoldingById(id);
            if (holding.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            
            // Validate portfolio ownership
            validatePortfolioOwnership(holding.get().getPortfolio());
            
            return ResponseEntity.ok(holding.get());
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteHolding(@PathVariable Integer id) {
        try {
            Optional<PortfolioHolding> holding = portfolioHoldingService.getHoldingById(id);
            if (holding.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            
            // Validate portfolio ownership
            validatePortfolioOwnership(holding.get().getPortfolio());
            
            portfolioHoldingService.deleteHolding(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
} 
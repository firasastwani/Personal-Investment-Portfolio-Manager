package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.service.PortfolioHoldingService;
import com.pipsap.pipsap.service.PortfolioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/portfolios/{portfolioId}/holdings")
public class PortfolioHoldingController {

    private final PortfolioHoldingService portfolioHoldingService;
    private final PortfolioService portfolioService;

    @Autowired
    public PortfolioHoldingController(PortfolioHoldingService portfolioHoldingService, 
                                    PortfolioService portfolioService) {
        this.portfolioHoldingService = portfolioHoldingService;
        this.portfolioService = portfolioService;
    }

    @GetMapping
    public ResponseEntity<?> getPortfolioHoldings(@PathVariable Integer portfolioId) {
        try {
            List<PortfolioHolding> holdings = portfolioHoldingService.getHoldingsByPortfolioId(portfolioId);
            return ResponseEntity.ok(holdings);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Error retrieving portfolio holdings: " + e.getMessage()
            ));
        }
    }

    @GetMapping("/{symbol}")
    public ResponseEntity<?> getHoldingBySymbol(
            @PathVariable Integer portfolioId,
            @PathVariable String symbol) {
        try {
            Optional<Portfolio> portfolio = portfolioService.getPortfolioById(portfolioId);
            if (portfolio.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            Optional<PortfolioHolding> holding = portfolioHoldingService
                .getHoldingByPortfolioAndSymbol(portfolio.get(), symbol);
            
            return holding.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Error retrieving holding: " + e.getMessage()
            ));
        }
    }

    @PostMapping
    public ResponseEntity<?> addHolding(
            @PathVariable Integer portfolioId,
            @RequestBody PortfolioHolding holding) {
        try {
            Optional<Portfolio> portfolio = portfolioService.getPortfolioById(portfolioId);
            if (portfolio.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            holding.setPortfolio(portfolio.get());
            PortfolioHolding savedHolding = portfolioHoldingService.addHolding(holding);
            return ResponseEntity.ok(savedHolding);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Error adding holding: " + e.getMessage()
            ));
        }
    }

    @PutMapping("/{holdingId}")
    public ResponseEntity<?> updateHolding(
            @PathVariable Integer portfolioId,
            @PathVariable Integer holdingId,
            @RequestBody PortfolioHolding holding) {
        try {
            Optional<Portfolio> portfolio = portfolioService.getPortfolioById(portfolioId);
            if (portfolio.isEmpty()) {
                return ResponseEntity.notFound().build();
            }

            holding.setPortfolio(portfolio.get());
            holding.setHoldingId(holdingId);
            PortfolioHolding updatedHolding = portfolioHoldingService.updateHolding(holding);
            return ResponseEntity.ok(updatedHolding);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Error updating holding: " + e.getMessage()
            ));
        }
    }

    @PutMapping("/{holdingId}/value")
    public ResponseEntity<?> updateHoldingValue(
            @PathVariable Integer portfolioId,
            @PathVariable Integer holdingId,
            @RequestBody Map<String, BigDecimal> request) {
        try {
            BigDecimal newValue = request.get("value");
            if (newValue == null) {
                return ResponseEntity.badRequest().body(Map.of(
                    "success", false,
                    "message", "Value is required"
                ));
            }

            PortfolioHolding updatedHolding = portfolioHoldingService
                .updateHoldingValue(holdingId, newValue);
            
            if (updatedHolding == null) {
                return ResponseEntity.notFound().build();
            }

            return ResponseEntity.ok(updatedHolding);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Error updating holding value: " + e.getMessage()
            ));
        }
    }

    @DeleteMapping("/{holdingId}")
    public ResponseEntity<?> deleteHolding(
            @PathVariable Integer portfolioId,
            @PathVariable Integer holdingId) {
        try {
            portfolioHoldingService.deleteHolding(holdingId);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Holding deleted successfully"
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "message", "Error deleting holding: " + e.getMessage()
            ));
        }
    }
} 
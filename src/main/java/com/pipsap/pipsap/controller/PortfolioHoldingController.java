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
@RequestMapping("/api/holdings")
public class PortfolioHoldingController {

    private final PortfolioHoldingService portfolioHoldingService;
    private final PortfolioService portfolioService;

    @Autowired
    public PortfolioHoldingController(PortfolioHoldingService portfolioHoldingService, 
                                    PortfolioService portfolioService) {
        this.portfolioHoldingService = portfolioHoldingService;
        this.portfolioService = portfolioService;
    }

    @PostMapping
    public ResponseEntity<PortfolioHolding> createHolding(
            @RequestParam Integer portfolioId,
            @RequestParam String symbol,
            @RequestParam Integer quantity,
            @RequestParam BigDecimal averagePurchasePrice) {
        try {
            PortfolioHolding holding = portfolioHoldingService.createHolding(
                portfolioId, symbol, quantity, averagePurchasePrice);
            return ResponseEntity.ok(holding);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/portfolio/{portfolioId}")
    public ResponseEntity<List<PortfolioHolding>> getHoldingsByPortfolio(@PathVariable Integer portfolioId) {
        try {
            List<PortfolioHolding> holdings = portfolioHoldingService.getHoldingsByPortfolioId(portfolioId);
            return ResponseEntity.ok(holdings);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<PortfolioHolding> getHoldingById(@PathVariable Integer id) {
        try {
            return portfolioHoldingService.getHoldingById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<PortfolioHolding> updateHolding(
            @PathVariable Integer id,
            @RequestParam Integer quantity,
            @RequestParam BigDecimal averagePurchasePrice) {
        try {
            PortfolioHolding holding = portfolioHoldingService.updateHolding(id, quantity, averagePurchasePrice);
            return ResponseEntity.ok(holding);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteHolding(@PathVariable Integer id) {
        try {
            portfolioHoldingService.deleteHolding(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
} 
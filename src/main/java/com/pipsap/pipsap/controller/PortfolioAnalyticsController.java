package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.service.PortfolioAnalyticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/analytics")
public class PortfolioAnalyticsController {

    @Autowired
    private PortfolioAnalyticsService portfolioAnalyticsService;

    @GetMapping("/portfolio/{portfolioId}/sector-diversification")
    public ResponseEntity<List<Map<String, Object>>> getPortfolioSectorDiversification(
            @PathVariable Integer portfolioId) {
        return ResponseEntity.ok(portfolioAnalyticsService.getPortfolioSectorDiversification(portfolioId));
    }

    @GetMapping("/securities/top-performing")
    public ResponseEntity<List<Map<String, Object>>> getTopPerformingSecurities(
            @RequestParam(defaultValue = "2") int minPortfolios,
            @RequestParam(defaultValue = "10") int limit) {
        return ResponseEntity.ok(portfolioAnalyticsService.getTopPerformingSecurities(minPortfolios, limit));
    }

    @GetMapping("/portfolio/{portfolioId}/transactions")
    public ResponseEntity<List<Map<String, Object>>> getPortfolioTransactionHistory(
            @PathVariable Integer portfolioId,
            @RequestParam(defaultValue = "10") int limit) {
        return ResponseEntity.ok(portfolioAnalyticsService.getPortfolioTransactionHistory(portfolioId, limit));
    }
} 
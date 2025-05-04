package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.service.PortfolioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import java.util.Optional;

import java.util.List;

@RestController
@RequestMapping("/api/portfolios")
public class PortfolioController {

    @Autowired
    private PortfolioService portfolioService;

    @GetMapping
    public ResponseEntity<List<Portfolio>> getAllPortfolios() {
        List<Portfolio> portfolios = portfolioService.getAllPortfolios();
        return ResponseEntity.ok(portfolios);
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
        Portfolio createdPortfolio = portfolioService.createPortfolio(portfolio);
        return ResponseEntity.ok(createdPortfolio);
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
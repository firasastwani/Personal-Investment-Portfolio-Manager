package com.pipsap.pipsap.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/portfolios")
public class PortfolioController {

    @GetMapping
    public ResponseEntity<?> getAllPortfolios() {
        // TODO: Implement get all portfolios logic
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPortfolio(@PathVariable Long id) {
        // TODO: Implement get portfolio by id logic
        return ResponseEntity.ok().build();
    }

    @PostMapping
    public ResponseEntity<?> createPortfolio() {
        // TODO: Implement create portfolio logic
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updatePortfolio(@PathVariable Long id) {
        // TODO: Implement update portfolio logic
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePortfolio(@PathVariable Long id) {
        // TODO: Implement delete portfolio logic
        return ResponseEntity.ok().build();
    }
} 
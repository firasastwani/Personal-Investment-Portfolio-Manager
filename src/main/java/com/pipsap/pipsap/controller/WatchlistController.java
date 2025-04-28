package com.pipsap.pipsap.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/watchlist")
public class WatchlistController {

    @GetMapping
    public ResponseEntity<?> getWatchlist() {
        // TODO: Implement get watchlist logic
        return ResponseEntity.ok().build();
    }

    @PostMapping
    public ResponseEntity<?> addToWatchlist() {
        // TODO: Implement add to watchlist logic
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeFromWatchlist(@PathVariable Long id) {
        // TODO: Implement remove from watchlist logic
        return ResponseEntity.ok().build();
    }
} 
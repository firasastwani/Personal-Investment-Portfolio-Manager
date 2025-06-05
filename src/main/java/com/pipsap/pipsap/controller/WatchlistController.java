package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.service.WatchlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;

@RestController
@RequestMapping("/api/watchlist")
@CrossOrigin(origins = "*")
public class WatchlistController {
    @Autowired
    private WatchlistService watchlistService;

    @PostMapping("/{symbol}")
    public ResponseEntity<?> addToWatchlist(@PathVariable String symbol) {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            if (username == null) {
                return ResponseEntity.status(401).body("User not authenticated");
            }
            
            WatchlistItem item = watchlistService.addToWatchlist(symbol);
            return ResponseEntity.ok(item);
        } catch (Exception e) {
            System.err.println("Error adding to watchlist: " + e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeFromWatchlist(@PathVariable Integer id) {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            if (username == null) {
                return ResponseEntity.status(401).body("User not authenticated");
            }
            
            watchlistService.removeFromWatchlist(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            System.err.println("Error removing from watchlist: " + e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<?> getWatchlist() {
        try {
            String username = SecurityContextHolder.getContext().getAuthentication().getName();
            if (username == null) {
                return ResponseEntity.status(401).body("User not authenticated");
            }
            
            List<WatchlistItem> items = watchlistService.getWatchlistByUser();
            return ResponseEntity.ok(items);
        } catch (Exception e) {
            System.err.println("Error getting watchlist: " + e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
} 
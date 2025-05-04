package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.service.WatchlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/watchlist")
@CrossOrigin(origins = "*")
public class WatchlistController {
    @Autowired
    private WatchlistService watchlistService;

    @PostMapping("/{symbol}")
    public ResponseEntity<WatchlistItem> addToWatchlist(@PathVariable String symbol) {
        try {
            System.out.println("Adding symbol to watchlist: " + symbol);
            WatchlistItem item = watchlistService.addToWatchlist(symbol);
            return ResponseEntity.ok(item);
        } catch (Exception e) {
            System.err.println("Error adding to watchlist: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> removeFromWatchlist(@PathVariable Integer id) {
        try {
            watchlistService.removeFromWatchlist(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            System.err.println("Error removing from watchlist: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping
    public ResponseEntity<List<WatchlistItem>> getWatchlist() {
        try {
            List<WatchlistItem> items = watchlistService.getWatchlistByUser();
            return ResponseEntity.ok(items);
        } catch (Exception e) {
            System.err.println("Error getting watchlist: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }
} 
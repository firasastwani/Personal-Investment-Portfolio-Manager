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
        WatchlistItem item = watchlistService.addToWatchlist(symbol);
        return ResponseEntity.ok(item);
    }

    @DeleteMapping("/{symbol}")
        public ResponseEntity<Void> removeFromWatchlist(@PathVariable String symbol) {
        watchlistService.removeFromWatchlist(symbol);
        return ResponseEntity.ok().build();
    }

    @GetMapping
    public ResponseEntity<List<WatchlistItem>> getWatchlist() {
        List<WatchlistItem> items = watchlistService.getWatchlistByUser();
        return ResponseEntity.ok(items);
    }
} 
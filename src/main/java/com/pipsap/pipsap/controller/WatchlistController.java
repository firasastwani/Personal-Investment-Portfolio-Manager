package com.pipsap.pipsap.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import com.pipsap.pipsap.model.User;    
import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.service.UserService;
import com.pipsap.pipsap.service.WatchlistService;

@RestController
@RequestMapping("/api/watchlist")
public class WatchlistController {

    @Autowired
    private UserService userService;

    @Autowired
    private WatchlistService watchlistService;

    @GetMapping
    public ResponseEntity<?> getWatchlist() {

        User user = userService.getLoggedInUser();
        List<WatchlistItem> watchlistItems = watchlistService.getWatchlistByUser(user);

        return ResponseEntity.ok(watchlistItems);
    }

    @PostMapping
    public ResponseEntity<?> addToWatchlist(@RequestBody WatchlistItem watchlistItem) {

        User user = userService.getLoggedInUser();
        watchlistItem.setUser(user);
        watchlistService.addToWatchlist(watchlistItem);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> removeFromWatchlist(@PathVariable Integer id) {

        User user = userService.getLoggedInUser();
        watchlistService.removeFromWatchlist(id);
        return ResponseEntity.ok().build();
    }
} 
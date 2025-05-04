package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.WatchlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class WatchlistService {
    @Autowired
    private WatchlistRepository watchlistRepository;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserService userService;

    @Transactional
    public WatchlistItem addToWatchlist(String symbol) {
        // Get the current user
        User user = userService.getLoggedInUser();
        if (user == null) {
            throw new RuntimeException("User not logged in");
        }

        // Get the security
        Security security = securityService.getSecurityBySymbol(symbol)
            .orElseThrow(() -> new RuntimeException("Security not found: " + symbol));

        // Check if already in watchlist
    
        List<WatchlistItem> existingItems = watchlistRepository.findByUserAndSecurity(user, security);
        if (!existingItems.isEmpty()) {
            throw new RuntimeException("Security already in watchlist");
        }

        // Create new watchlist item
        WatchlistItem watchlistItem = new WatchlistItem();
        watchlistItem.setUser(user);
        watchlistItem.setSecurity(security);

        return watchlistRepository.save(watchlistItem);
    }

    @Transactional
    public void removeFromWatchlist(Integer id) {
        watchlistRepository.deleteById(id);
    }

    public List<WatchlistItem> getWatchlistByUser() {
        User user = userService.getLoggedInUser();
        if (user == null) {
            throw new RuntimeException("User not logged in");
        }
        return watchlistRepository.findByUser(user);
    }

    public List<WatchlistItem> getWatchlistByUserId(Integer userId) {
        return watchlistRepository.findByUser_UserId(userId);
    }

    public List<WatchlistItem> getWatchlistBySecurity(Security security) {
        return watchlistRepository.findBySecurity(security);
    }
} 
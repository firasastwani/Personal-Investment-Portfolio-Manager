package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.WatchlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;

@Service
public class WatchlistService {
    @Autowired
    private WatchlistRepository watchlistRepository;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserService userService;

    private User getCurrentUser() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getUserByUsername(username);
        if (user == null) {
            throw new RuntimeException("User not found");
        }
        return user;
    }

    @Transactional
    public WatchlistItem addToWatchlist(String symbol) {
        User user = getCurrentUser();

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
        User user = getCurrentUser();
        WatchlistItem item = watchlistRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Watchlist item not found"));
            
        if (!item.getUser().getUserId().equals(user.getUserId())) {
            throw new RuntimeException("Not authorized to remove this item");
        }
        
        watchlistRepository.deleteById(id);
    }

    public List<WatchlistItem> getWatchlistByUser() {
        User user = getCurrentUser();
        return watchlistRepository.findByUser(user);
    }

    public List<WatchlistItem> getWatchlistByUserId(Integer userId) {
        return watchlistRepository.findByUser_UserId(userId);
    }

    public List<WatchlistItem> getWatchlistBySecurity(Security security) {
        return watchlistRepository.findBySecurity(security);
    }
} 
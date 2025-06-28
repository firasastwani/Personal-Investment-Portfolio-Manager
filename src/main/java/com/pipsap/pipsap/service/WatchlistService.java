package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.WatchlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class WatchlistService {

    private final WatchlistRepository watchlistRepository;
    private final SecurityService securityService;
    private final UserService userService;

    @Autowired
    public WatchlistService(WatchlistRepository watchlistRepository, SecurityService securityService, UserService userService) {
        this.watchlistRepository = watchlistRepository;
        this.securityService = securityService;
        this.userService = userService;
    }


    private User getCurrentUser() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        if (username == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not authenticated");
        }
        User user = userService.getUserByUsername(username);
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }
        return user;
    }

    @Transactional
    public WatchlistItem addToWatchlist(String symbol) {
        try {
            User user = getCurrentUser();

            // Get the security
            Security security = securityService.getSecurityBySymbol(symbol)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Security not found: " + symbol));

            // Check if already in watchlist
            List<WatchlistItem> existingItems = watchlistRepository.findByUserAndSecurity(user, security);
            if (!existingItems.isEmpty()) {
                throw new ResponseStatusException(HttpStatus.CONFLICT, "Security already in watchlist");
            }

            // Create new watchlist item
            WatchlistItem watchlistItem = new WatchlistItem();
            watchlistItem.setUser(user);
            watchlistItem.setSecurity(security);

            return watchlistRepository.save(watchlistItem);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error adding to watchlist: " + e.getMessage());
        }
    }

    @Transactional
    public void removeFromWatchlist(String symbol) {

        Security security = securityService.getSecurityBySymbol(symbol)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Security not found: " + symbol));

        try {
            User user = getCurrentUser();
            List<WatchlistItem> items = watchlistRepository.findByUserAndSecurity(user, security);
            if (items.isEmpty()) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Watchlist item not found");
            }
            WatchlistItem item = items.get(0);
                
            if (!item.getUser().getUserId().equals(user.getUserId())) {
                throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Not authorized to remove this item");
            }
            
            watchlistRepository.delete(item);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error removing from watchlist: " + e.getMessage());
        }
    }

    public List<WatchlistItem> getWatchlistByUser() {
        try {
            User user = getCurrentUser();
            return watchlistRepository.findByUser(user);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error getting watchlist: " + e.getMessage());
        }
    }

    public List<WatchlistItem> getWatchlistByUserId(Integer userId) {
        return watchlistRepository.findByUser_UserId(userId);
    }

    public List<WatchlistItem> getWatchlistBySecurity(Security security) {
        return watchlistRepository.findBySecurity(security);
    }
} 
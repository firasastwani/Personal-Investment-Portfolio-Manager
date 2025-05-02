package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.WatchlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WatchlistService {
    @Autowired
    private WatchlistRepository watchlistRepository;

    @Autowired
    private SecurityService securityService;

    public List<WatchlistItem> getWatchlistByUser(User user) {
        return watchlistRepository.findByUser(user);
    }

    public List<WatchlistItem> getWatchlistByUserId(Integer userId) {
        
        return watchlistRepository.findByUser_UserId(userId);
    }

    public List<WatchlistItem> getWatchlistBySecurity(Security security) {

        return watchlistRepository.findBySecurity(security);
    }

    public WatchlistItem addToWatchlist(WatchlistItem watchlistItem) {

        return watchlistRepository.save(watchlistItem);
    }

    public void removeFromWatchlist(Integer watchlistId) {

        watchlistRepository.deleteById(watchlistId);
    }
} 
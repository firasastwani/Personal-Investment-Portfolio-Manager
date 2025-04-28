package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.WatchlistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class WatchlistService {
    @Autowired
    private WatchlistRepository watchlistRepository;

    public WatchlistItem createWatchlistItem(WatchlistItem watchlistItem) {
        return watchlistRepository.save(watchlistItem);
    }

    public Optional<WatchlistItem> getWatchlistItemById(Long id) {
        return watchlistRepository.findById(id);
    }

    public List<WatchlistItem> getWatchlistByUser(User user) {
        return watchlistRepository.findByUser(user);
    }

    public List<WatchlistItem> getWatchlistByUserId(Long userId) {
        return watchlistRepository.findByUserId(userId);
    }

    public WatchlistItem updateWatchlistItem(WatchlistItem watchlistItem) {
        return watchlistRepository.save(watchlistItem);
    }

    public void deleteWatchlistItem(Long id) {
        watchlistRepository.deleteById(id);
    }
} 
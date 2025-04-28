package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface WatchlistRepository extends JpaRepository<WatchlistItem, Long> {
    List<WatchlistItem> findByUser(User user);
    List<WatchlistItem> findByUserId(Long userId);
} 
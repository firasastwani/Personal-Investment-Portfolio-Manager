package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.WatchlistItem;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.model.Security;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WatchlistRepository extends JpaRepository<WatchlistItem, Integer> {
    List<WatchlistItem> findByUser(User user);
    List<WatchlistItem> findByUser_UserId(Integer userId);
    List<WatchlistItem> findBySecurity(Security security);
} 
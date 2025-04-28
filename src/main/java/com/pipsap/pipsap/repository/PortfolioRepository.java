package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PortfolioRepository extends JpaRepository<Portfolio, Long> {
    List<Portfolio> findByUser(User user);
    List<Portfolio> findByUserId(Long userId);
} 
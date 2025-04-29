package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.PortfolioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PortfolioService {
    @Autowired
    private PortfolioRepository portfolioRepository;

    public Portfolio createPortfolio(Portfolio portfolio) {
        return portfolioRepository.save(portfolio);
    }

    public Optional<Portfolio> getPortfolioById(Integer id) {
        return portfolioRepository.findById(id);
    }

    public List<Portfolio> getPortfoliosByUser(User user) {
        return portfolioRepository.findByUser(user);
    }

    public List<Portfolio> getPortfoliosByUserId(Integer userId) {
        return portfolioRepository.findByUser_UserId(userId);
    }

    public Portfolio updatePortfolio(Portfolio portfolio) {
        return portfolioRepository.save(portfolio);
    }

    public void deletePortfolio(Integer id) {
        portfolioRepository.deleteById(id);
    }
} 
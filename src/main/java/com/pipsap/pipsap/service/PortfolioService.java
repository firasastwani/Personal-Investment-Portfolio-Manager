package com.pipsap.pipsap.service;

import com.pipsap.pipsap.service.UserService;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.repository.PortfolioRepository;
import com.pipsap.pipsap.repository.PortfolioHoldingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PortfolioService {

    @Autowired
    private PortfolioRepository portfolioRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private UserService User;

    @Autowired
    private PortfolioHoldingRepository portfolioHoldingRepository;

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

    public List<Portfolio> getAllPortfolios() {
        return portfolioRepository.findAll();
    }

    public List<PortfolioHolding> getPortfolioHoldings(Integer portfolioId) {
        return portfolioHoldingRepository.findByPortfolio_PortfolioId(portfolioId);
    }

    public Portfolio createPortfolioForUser(Portfolio portfolio, String username) {
        User user = userService.getUserByUsername(username);
        if (user == null) {
            throw new RuntimeException("User not found");
        }
        portfolio.setUser(user);
        return createPortfolio(portfolio);
    }

    public void validatePortfolioOwnership(Portfolio portfolio, User user) {
        if (!portfolio.getUser().getUserId().equals(user.getUserId())) {
            throw new RuntimeException("Not authorized to access this portfolio");
        }
    }

    public Portfolio updatePortfolioWithValidation(Portfolio portfolio, User user) {
        Portfolio existingPortfolio = getPortfolioById(portfolio.getPortfolioId())
            .orElseThrow(() -> new RuntimeException("Portfolio not found"));
        validatePortfolioOwnership(existingPortfolio, user);
        return updatePortfolio(portfolio);
    }

    public void deletePortfolioWithValidation(Integer id, User user) {
        Portfolio portfolio = getPortfolioById(id)
            .orElseThrow(() -> new RuntimeException("Portfolio not found"));
        validatePortfolioOwnership(portfolio, user);
        deletePortfolio(id);
    }
} 
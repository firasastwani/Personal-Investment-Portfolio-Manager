package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.repository.PortfolioHoldingRepository;
import com.pipsap.pipsap.repository.SecurityRepository;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.service.PortfolioService;
import com.pipsap.pipsap.service.SecurityService;
import com.pipsap.pipsap.service.TransactionService;
import com.pipsap.pipsap.service.BalanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class PortfolioHoldingService {

    private final PortfolioHoldingRepository portfolioHoldingRepository;
    private final SecurityRepository securityRepository;
    private final BalanceService balanceService;

    @Autowired
    public PortfolioHoldingService(PortfolioHoldingRepository portfolioHoldingRepository,
                                 SecurityRepository securityRepository,
                                 BalanceService balanceService) {
        this.portfolioHoldingRepository = portfolioHoldingRepository;
        this.securityRepository = securityRepository;
        this.balanceService = balanceService;
    }

    @Autowired
    private PortfolioService portfolioService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private TransactionService transactionService;

    @Transactional
    public PortfolioHolding createHolding(Integer portfolioId, String symbol, Integer quantity) {
        System.out.println("PortfolioHoldingService: Starting createHolding with portfolioId: " + portfolioId + ", symbol: " + symbol + ", quantity: " + quantity);
        
        Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Portfolio not found"));

        Security security = securityService.getSecurityBySymbol(symbol)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Security not found"));

        PortfolioHolding holding = new PortfolioHolding();
        holding.setPortfolio(portfolio);
        holding.setSecurity(security);
        holding.setQuantity(quantity);
        holding.setAveragePurchasePrice(security.getPrice());
        holding.setCurrentValue(security.getPrice().multiply(new BigDecimal(quantity)));
        holding.setLastUpdated(LocalDateTime.now());

        return portfolioHoldingRepository.save(holding);
    }

    public List<PortfolioHolding> getHoldingsByPortfolio(Portfolio portfolio) {
        return portfolioHoldingRepository.findByPortfolio(portfolio);
    }

    public List<PortfolioHolding> getHoldingsByPortfolioId(Integer portfolioId) {
        return portfolioHoldingRepository.findByPortfolio_PortfolioId(portfolioId);
    }

    public List<PortfolioHolding> getHoldingsBySecurity(Security security) {
        return portfolioHoldingRepository.findBySecurity(security);
    }

    public Optional<PortfolioHolding> getHoldingById(Integer id) {
        return portfolioHoldingRepository.findById(id);
    }

    @Transactional
    public void deleteHolding(Integer id) {
        portfolioHoldingRepository.deleteById(id);
    }

    @Transactional
    public PortfolioHolding updateHolding(Integer id, Integer quantity, BigDecimal securityPrice) {
        PortfolioHolding holding = portfolioHoldingRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Holding not found"));

        holding.setQuantity(quantity);
        holding.setAveragePurchasePrice(securityPrice);
        holding.setCurrentValue(securityPrice.multiply(new BigDecimal(quantity)));
        holding.setLastUpdated(LocalDateTime.now());

        return portfolioHoldingRepository.save(holding);
    }

    public boolean holdingExists(Portfolio portfolio, String symbol) {
        Optional<Security> security = securityRepository.findBySymbol(symbol);
        if (security.isEmpty()) {
            return false;
        }
        return portfolioHoldingRepository.existsByPortfolioAndSecurity(portfolio, security.get());
    }

    public Optional<PortfolioHolding> getHoldingByPortfolioAndSecurity(Portfolio portfolio, Security security) {
        return portfolioHoldingRepository.findByPortfolioAndSecurity(portfolio, security);
    }

    public void validatePortfolioOwnership(Portfolio portfolio, User user) {
        if (!portfolio.getUser().getUserId().equals(user.getUserId())) {
            throw new RuntimeException("Not authorized to access this portfolio");
        }
    }

    public Transaction buySecurity(Integer portfolioId, String symbol, Integer quantity, User user) {
        // Get portfolio and validate ownership
        Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
            .orElseThrow(() -> new RuntimeException("Portfolio not found"));
        validatePortfolioOwnership(portfolio, user);
        
        // Get security
        Security security = securityService.getSecurityBySymbol(symbol)
            .orElseThrow(() -> new RuntimeException("Security not found"));

        // Check if user has enough balance
        if (balanceService.getBalance(user.getUserId()).compareTo(security.getPrice().multiply(new BigDecimal(quantity))) < 0) {
            throw new RuntimeException("Insufficient balance to buy security");
        }

        balanceService.subtractBalance(user.getUserId(), security.getPrice().multiply(new BigDecimal(quantity))); 

        // Create transaction
        Transaction transaction = transactionService.createTransaction(
            portfolioId,
            symbol,
            Transaction.TransactionType.BUY,
            new BigDecimal(quantity),
            security.getPrice(),
            "Buy transaction"
        );

        // Update or create portfolio holding
        Optional<PortfolioHolding> existingHolding = getHoldingByPortfolioAndSecurity(portfolio, security);

        if (existingHolding.isPresent()) {
            // Update existing holding
            PortfolioHolding holding = existingHolding.get();
            int newQuantity = holding.getQuantity() + quantity;
            updateHolding(
                holding.getId(),
                newQuantity,
                security.getPrice()
            );
        } else {
            // Create new holding
            createHolding(portfolioId, symbol, quantity);
        }

        // Update total account value after transaction
        balanceService.updateTotalAccountValue(user.getUserId());

        return transaction;
    }

    public Transaction sellSecurity(Integer portfolioId, String symbol, Integer quantity, User user) {
        // Get portfolio and validate ownership
        Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
            .orElseThrow(() -> new RuntimeException("Portfolio not found"));
        validatePortfolioOwnership(portfolio, user);
        
        // Get security
        Security security = securityService.getSecurityBySymbol(symbol)
            .orElseThrow(() -> new RuntimeException("Security not found"));

        // Check if holding exists and has sufficient quantity
        Optional<PortfolioHolding> existingHolding = getHoldingByPortfolioAndSecurity(portfolio, security);

        if (existingHolding.isEmpty()) {
            throw new RuntimeException("No holdings found for this security");
        }

        PortfolioHolding holding = existingHolding.get();
        if (holding.getQuantity() < quantity) {
            throw new RuntimeException("Insufficient quantity to sell");
        }


        // Add price of sold security to balance
        balanceService.addBalance(user.getUserId(), security.getPrice().multiply(new BigDecimal(quantity))); 

        // Create transaction
        Transaction transaction = transactionService.createTransaction(
            portfolioId,
            symbol,
            Transaction.TransactionType.SELL,
            new BigDecimal(quantity),
            security.getPrice(),
            "Sell transaction"
        );

        // Update holding quantity
        int newQuantity = holding.getQuantity() - quantity;
        if (newQuantity == 0) {
            // Delete holding if quantity becomes 0
            deleteHolding(holding.getId());
        } else {
            // Update holding with new quantity
            updateHolding(
                holding.getId(),
                newQuantity,
                security.getPrice()
            );
        }

        // Update total account value after transaction
        balanceService.updateTotalAccountValue(user.getUserId());

        return transaction;
    }

    public List<PortfolioHolding> getHoldingsByPortfolioWithValidation(Integer portfolioId, User user) {
        Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
            .orElseThrow(() -> new RuntimeException("Portfolio not found"));
        validatePortfolioOwnership(portfolio, user);
        return getHoldingsByPortfolioId(portfolioId);
    }

    public PortfolioHolding getHoldingByIdWithValidation(Integer id, User user) {
        PortfolioHolding holding = getHoldingById(id)
            .orElseThrow(() -> new RuntimeException("Holding not found"));
        validatePortfolioOwnership(holding.getPortfolio(), user);
        return holding;
    }
} 
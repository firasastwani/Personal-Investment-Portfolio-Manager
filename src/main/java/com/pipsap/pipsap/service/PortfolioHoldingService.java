package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.repository.PortfolioHoldingRepository;
import com.pipsap.pipsap.repository.SecurityRepository;

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

    @Autowired
    public PortfolioHoldingService(PortfolioHoldingRepository portfolioHoldingRepository,
                                 SecurityRepository securityRepository) {
        this.portfolioHoldingRepository = portfolioHoldingRepository;
        this.securityRepository = securityRepository;
    }

    @Autowired
    private PortfolioService portfolioService;

    @Autowired
    private SecurityService securityService;

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
        holding.setAveragePurchasePrice(security.getStaticPrice());
        holding.setCurrentValue(security.getStaticPrice().multiply(new BigDecimal(quantity)));
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
} 
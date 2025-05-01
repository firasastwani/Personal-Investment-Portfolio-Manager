package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.repository.PortfolioHoldingRepository;
import com.pipsap.pipsap.repository.SecurityRepository;
import org.springframework.beans.factory.annotation.Autowired;
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

    public List<PortfolioHolding> getHoldingsByPortfolio(Portfolio portfolio) {
        List<PortfolioHolding> holdings = portfolioHoldingRepository.findByPortfolio(portfolio);
        holdings.forEach(this::updateCurrentValue);
        return holdings;
    }

    public List<PortfolioHolding> getHoldingsByPortfolioId(Integer portfolioId) {
        List<PortfolioHolding> holdings = portfolioHoldingRepository.findByPortfolio_PortfolioId(portfolioId);
        holdings.forEach(this::updateCurrentValue);
        return holdings;
    }

    public Optional<PortfolioHolding> getHoldingByPortfolioAndSymbol(Portfolio portfolio, String symbol) {
        Optional<Security> security = securityRepository.findBySymbol(symbol);
        if (security.isEmpty()) {
            return Optional.empty();
        }
        Optional<PortfolioHolding> holding = portfolioHoldingRepository.findByPortfolioAndSecurity(portfolio, security.get());
        holding.ifPresent(this::updateCurrentValue);
        return holding;
    }

    @Transactional
    public PortfolioHolding addHolding(PortfolioHolding holding) {
        updateCurrentValue(holding);
        holding.setLastUpdated(LocalDateTime.now());
        return portfolioHoldingRepository.save(holding);
    }

    @Transactional
    public PortfolioHolding updateHolding(PortfolioHolding holding) {
        updateCurrentValue(holding);
        holding.setLastUpdated(LocalDateTime.now());
        return portfolioHoldingRepository.save(holding);
    }

    @Transactional
    public void deleteHolding(Integer holdingId) {
        portfolioHoldingRepository.deleteById(holdingId);
    }

    @Transactional
    public PortfolioHolding updateHoldingValue(Integer holdingId, BigDecimal newValue) {
        Optional<PortfolioHolding> holdingOpt = portfolioHoldingRepository.findById(holdingId);
        if (holdingOpt.isPresent()) {
            PortfolioHolding holding = holdingOpt.get();
            holding.setCurrentValue(newValue);
            holding.setLastUpdated(LocalDateTime.now());
            return portfolioHoldingRepository.save(holding);
        }
        return null;
    }

    private void updateCurrentValue(PortfolioHolding holding) {
        if (holding.getSecurity() != null && holding.getQuantity() != null) {
            BigDecimal currentValue = holding.getSecurity().getStaticPrice()
                .multiply(new BigDecimal(holding.getQuantity()));
            holding.setCurrentValue(currentValue);
        }
    }

    public boolean holdingExists(Portfolio portfolio, String symbol) {
        Optional<Security> security = securityRepository.findBySymbol(symbol);
        if (security.isEmpty()) {
            return false;
        }
        return portfolioHoldingRepository.existsByPortfolioAndSecurity(portfolio, security.get());
    }
} 
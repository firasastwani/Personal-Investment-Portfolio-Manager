package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Security;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface PortfolioHoldingRepository extends JpaRepository<PortfolioHolding, Integer> {
    
    // Find all holdings for a specific portfolio
    List<PortfolioHolding> findByPortfolio(Portfolio portfolio);
    
    // Find all holdings for a portfolio by portfolio ID
    List<PortfolioHolding> findByPortfolio_PortfolioId(Integer portfolioId);
    
    // Find all holdings for a specific security
    List<PortfolioHolding> findBySecurity(Security security);
    
    // Find a specific holding by portfolio and security
    Optional<PortfolioHolding> findByPortfolioAndSecurity(Portfolio portfolio, Security security);
    
    // Check if a holding exists for a portfolio and security
    boolean existsByPortfolioAndSecurity(Portfolio portfolio, Security security);

    // the amount of this symbol owned in portfolios
    long countBySecuritySymbol(String symbol);
    
    // Find all holdings for a specific security symbol
    List<PortfolioHolding> findBySecurity_Symbol(String symbol);

} 
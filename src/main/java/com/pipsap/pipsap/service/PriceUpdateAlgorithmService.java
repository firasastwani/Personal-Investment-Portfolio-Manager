package com.pipsap.pipsap.service;

import com.pipsap.pipsap.repository.PortfolioHoldingRepository;
import com.pipsap.pipsap.repository.SecurityRepository;
import com.pipsap.pipsap.repository.WatchlistRepository;
import com.pipsap.pipsap.service.PriceCacheService;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class PriceUpdateAlgorithmService {

    private final PortfolioHoldingRepository portfolioHoldingRepository;
    private final WatchlistRepository watchlistRepository;
    private final SecurityRepository securityRepository;
    private final PriceCacheService priceCacheService;

    @Autowired
    public PriceUpdateAlgorithmService(PortfolioHoldingRepository portfolioHoldingRepository, WatchlistRepository watchlistRepository, SecurityRepository securityRepository, PriceCacheService priceCacheService) {
        this.portfolioHoldingRepository = portfolioHoldingRepository;
        this.watchlistRepository = watchlistRepository;
        this.securityRepository = securityRepository;
        this.priceCacheService = priceCacheService;
    }

    @Value("${price-update.algorithm.portfolio-weight}")
    private double portfolioWeight; 

    @Value("${price-update.algorithm.watchlist-weight}")
    private double watchlistWeight; 

    @Value("${price-update.algorithm.time-weight}")
    private double timeWeight; 

    @Value("${price-update.algorithm.min-update-interval-minutes}")
    private int minUpdateIntervalMinutes; 

    @Value("${price-update.cache.max-batch-size}")
    private int maxBatchSize;

    public static class SecurityPriority {

        private final String symbol; 
        private final double priorityScore;
        private final String reason; 

        public SecurityPriority(String symbol, double priorityScore, String reason){
            this.symbol = symbol; 
            this.priorityScore = priorityScore;
            this.reason = reason; 
        }

        public String getSymbol(){
            return symbol;
        }
        
        public double getPriorityScore(){
            return priorityScore; 
        }

        public String getReason(){
            return reason; 
        }
    }

    // continue

}

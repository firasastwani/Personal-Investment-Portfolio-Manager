package com.pipsap.pipsap.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.List; 
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import com.pipsap.pipsap.service.PortfolioAnalyticsService;
import com.pipsap.pipsap.repository.UserRepository;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.service.PortfolioHoldingService;


/*
 * When kafka is disabled, fall back to using DB current prices to 
 * update the cache
 */

@Service
@ConditionalOnProperty(name = "price-update.kafka.enabled", havingValue = "false")
public class FallBackPriceUpdateService {

    private static final Logger logger = LoggerFactory.getLogger(FallBackPriceUpdateService.class);

    private final SecurityService securityService; 
    private final PriceCacheService priceCacheService;
    private final PortfolioAnalyticsService portfolioAnalyticsService;
    private final UserRepository userRepository;
    private final PortfolioHoldingService portfolioHoldingService;

    @Autowired
    public FallBackPriceUpdateService(SecurityService securityService, PriceCacheService priceCacheService, 
                                     PortfolioAnalyticsService portfolioAnalyticsService, UserRepository userRepository,
                                     PortfolioHoldingService portfolioHoldingService) {
        this.securityService = securityService;
        this.priceCacheService = priceCacheService;
        this.portfolioAnalyticsService = portfolioAnalyticsService;
        this.userRepository = userRepository;
        this.portfolioHoldingService = portfolioHoldingService;
    }

    public void simulateBatchPriceUpdate(List<String> symbols){

        logger.info("Simulating batch price update for {} symbols (Kafka disabled)", symbols.size());

        for(String symbol: symbols){

            try{

                BigDecimal currentPrice = securityService.getPriceBySymbol(symbol);
                
                // cache so less load on db
                priceCacheService.cachePrice(symbol, currentPrice);
                
                // Update portfolio holdings for this security
                portfolioHoldingService.updateAllHoldingsForSecurity(symbol, currentPrice);

                logger.debug("Cached price for {}: {}", symbol, currentPrice);

            } catch(Exception e){
                logger.error("Error processing symbol: {}: {}", symbol, e.getMessage()); 
            }

        }
        
        // Record TAV for all users after price updates
        recordTAVForAllUsers();
    }

    public void simulateSinglePriceUpdate(String symbol){

        logger.info("Simulating single price update for {}", symbol);

        try {
            BigDecimal currentPrice = securityService.getPriceBySymbol(symbol);
            priceCacheService.cachePrice(symbol, currentPrice);

            logger.debug("Cached price for {}: {}", symbol, currentPrice);
        } catch(Exception e){
            logger.error("Error processing price update for {}: {}", symbol, e.getMessage());
        }
    }


    // needs to make sure all are in the cache first, no?
    public Map<String, BigDecimal> getBatchPrices(List<String> symbols){

        logger.debug("Getting batch prices for {} symbols (Kafka disabled)", symbols);
        return priceCacheService.getBatchPrices(java.util.Set.copyOf(symbols));
    }

    // if kafka enabled is set to false in the config, this will be auto true 
    public boolean isFallbackActive(){
        return true;
    }
    
    /**
     * Record TAV for all users after price updates
     */
    private void recordTAVForAllUsers() {
        try {
            List<User> allUsers = userRepository.findAll();
            for (User user : allUsers) {
                try {
                    portfolioAnalyticsService.recordCurrentTAV(user);
                    logger.debug("Recorded TAV for user: {}", user.getUsername());
                } catch (Exception e) {
                    logger.error("Error recording TAV for user {}: {}", user.getUsername(), e.getMessage());
                }
            }
            logger.info("Recorded TAV for {} users after price updates", allUsers.size());
        } catch (Exception e) {
            logger.error("Error recording TAV for all users: {}", e.getMessage());
        }
    }

}

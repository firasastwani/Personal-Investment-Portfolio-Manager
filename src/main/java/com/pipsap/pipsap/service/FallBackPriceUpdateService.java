package com.pipsap.pipsap.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigDecimal;
import java.util.List; 
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;


/*
 * When kafka is disabled, fall back to using DB current prices to 
 * update the cache
 */

@Service
//@ConditionalOnProperty(name = "price-update.kafka.enabled", havingValue = "false")
public class FallBackPriceUpdateService {

    private static final Logger logger = LoggerFactory.getLogger(FallBackPriceUpdateService.class);

    private final SecurityService securityService; 
    private final PriceCacheService priceCacheService;

    @Autowired
    public FallBackPriceUpdateService(SecurityService securityService, PriceCacheService priceCacheService) {
        this.securityService = securityService;
        this.priceCacheService = priceCacheService;
    }

    public void simulateBatchPriceUpdate(List<String> symbols){

        logger.info("Simulating batch price update for {} symbols (Kafka disabled)", symbols.size());

        for(String symbol: symbols){

            try{

                BigDecimal currentPrice = securityService.getPriceBySymbol(symbol);
                
                // cache so less load on db
                priceCacheService.cachePrice(symbol, currentPrice);

                logger.debug("Cached price for {}: {}", symbol, currentPrice);

            } catch(Exception e){
                logger.error("Error processing symbol: {}: {}", symbol, e.getMessage()); 
            }

        }
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

}

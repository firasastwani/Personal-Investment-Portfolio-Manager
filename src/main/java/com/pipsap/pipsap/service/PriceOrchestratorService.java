package com.pipsap.pipsap.service;


import java.util.HashMap;
import java.util.Optional;
import org.slf4j.Logger; 
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.pipsap.pipsap.service.SecurityService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
public class PriceOrchestratorService {

    private static final Logger logger = LoggerFactory.getLogger(PriceOrchestratorService.class);

    private final PriceUpdateAlgorithmService algorithmService;
    private final FallBackPriceUpdateService fallBackPriceUpdateService;
    private final KafkaPriceUpdateService kafkaPriceUpdateService;
    private final PriceCacheService priceCacheService; 
    private final SecurityService securityService;

    @Value("${price-update.kafka.enabled:true}")
    private boolean kafkaEnabled;

    @Autowired
    public PriceOrchestratorService(PriceUpdateAlgorithmService algorithmService, 
                                   KafkaPriceUpdateService kafkaPriceUpdateService, 
                                   PriceCacheService priceCacheService, 
                                   SecurityService securityService,
                                   @Autowired(required = false) FallBackPriceUpdateService fallBackPriceUpdateService) {
        this.algorithmService = algorithmService;
        this.fallBackPriceUpdateService = fallBackPriceUpdateService;
        this.kafkaPriceUpdateService = kafkaPriceUpdateService;
        this.priceCacheService = priceCacheService;
        this.securityService = securityService;
    }
    
    @Scheduled(fixedRate = 300000) // 300,000 ms = 5 min - PAUSED FOR TESTING
    public void scheduledPriceUpdate(){

        logger.info("Running scheduled price update");

        try {

            List<String> symbolsToUpdate = algorithmService.getPrioritizedSymbolsForUpdate();

           if(symbolsToUpdate.isEmpty()){
                logger.info("No symbols need updates at this time");
                return;
           }

           logger.info("Updating symobls {}, from priority algo", symbolsToUpdate);

           // when would kafkaPriceUpdateService == nul?
           if(kafkaEnabled && kafkaPriceUpdateService != null){
                kafkaPriceUpdateService.requestBatchPriceUpdate(symbolsToUpdate);
           } else if(fallBackPriceUpdateService != null){
                fallBackPriceUpdateService.getBatchPrices(symbolsToUpdate);
           } else {
                logger.warn("No price update service available for scheduled update");
           }

        } catch(Exception e){

            logger.error("Error during scheduled price update: {}", e.getMessage());
        }
    }

    // manually triggers price update, for testing. 
    public void triggerPriceUpdate(){
        logger.info("Manual price update trigger");
        scheduledPriceUpdate();
    }


    public void updateSpecificSymbols(List<String> symbols){

        logger.info("Updating specified symbols: {}", symbols);

        for(String symbol: symbols){
            // Skip invalid symbols
            if (!isValidSymbol(symbol)) {
                logger.warn("Skipping invalid symbol: {}", symbol);
                continue;
            }

            try {

                if(kafkaEnabled && kafkaPriceUpdateService != null){
                    kafkaPriceUpdateService.requestSinglePriceUpdate(symbol);
                } else if(fallBackPriceUpdateService != null){
                    fallBackPriceUpdateService.simulateSinglePriceUpdate(symbol);
                } else {
                    logger.warn("No price update service available for symbol: {}", symbol);
                }

            } catch(Exception e){

                logger.error("Error updating symbol {}: {}", symbol, e.getMessage());
            }
        }
    }

    public java.math.BigDecimal getCurrPrice(String symbol){

        // check cache
        Optional<BigDecimal> cachePrice = priceCacheService.getCachedPrice(symbol);

        if(cachePrice.isPresent()){

            logger.info("Returning cached price for {}: {}", symbol, cachePrice.get());
            return cachePrice.get();
        }


        try {
            java.math.BigDecimal dbPrice = securityService.getPriceBySymbol(symbol);

            priceCacheService.cachePrice(symbol, dbPrice);

            logger.info("Returning database price for: {}: {}", symbol, dbPrice);

            return dbPrice;

        } catch(Exception e){
            logger.error("Error getting price for symbol: {} : {}", symbol, e.getMessage());

            throw new RuntimeException("Unable to get price for symbol: " + symbol,e);
        }
    }

    // TODO: if some of the symbols in the batch are not in the cache, handle this properly 
    public Map<String, java.math.BigDecimal> getBatchPrices(List<String> symbols){

        logger.debug("Getting batch prices for {} symbols", symbols.size());

        if(fallBackPriceUpdateService != null && !kafkaEnabled){
            fallBackPriceUpdateService.getBatchPrices(symbols);
        }

        return priceCacheService.getBatchPrices(java.util.Set.copyOf(symbols));
    }


    public void forceRefreshPrices(List<String> symbols){

        // Filter out invalid symbols
        List<String> validSymbols = symbols.stream()
            .filter(this::isValidSymbol)
            .collect(java.util.stream.Collectors.toList());
            
        if (validSymbols.size() != symbols.size()) {
            logger.warn("Filtered out {} invalid symbols from force refresh request", symbols.size() - validSymbols.size());
        }

        // invalidate cache for inputted symbols
        for(String symbol: validSymbols){
            priceCacheService.invalidatePrice(symbol);
        }

        // request price updates

        if(kafkaEnabled && kafkaPriceUpdateService != null){

            kafkaPriceUpdateService.requestBatchPriceUpdate(validSymbols);
        } else if(fallBackPriceUpdateService != null) {
            fallBackPriceUpdateService.getBatchPrices(validSymbols);
        } else {
            logger.warn("No price update service available for symbol a force refresh");
        }
    }

    // checks status of services    
    public Map<String, Object> serviceStatusCheck() {

        Map<String, Object> status = algorithmService.getUpddateStatistics(); 

        status.put("kafkaEnabled", kafkaEnabled);
        status.put("kafkaServiceAvailable", kafkaPriceUpdateService != null);
        status.put("fallBackPriceServiceAvailable", fallBackPriceUpdateService != null);

        
        return status;
    }

    // prio list for debugging
    public List<PriceUpdateAlgorithmService.SecurityPriority> getUpdatePriorities(){
        return algorithmService.calculateUpdatePriorities();
    }

    // clear cache prices
    public void clearAllCachedPrices() {

        logger.info("Clearing all cached prices");
        priceCacheService.clearAllPrices();
    }

    /**
     * Validates if a symbol is valid for price updates
     */
    private boolean isValidSymbol(String symbol) {
        if (symbol == null || symbol.trim().isEmpty()) {
            return false;
        }
        
        // Skip invalid symbols like "--"
        if (symbol.equals("--") || symbol.length() < 2) {
            return false;
        }
        
        // Skip symbols that contain only special characters
        if (symbol.matches("^[^a-zA-Z0-9]+$")) {
            return false;
        }
        
        return true;
    }

    // health check
    public Map<String, Object> healthCheck() {

        Map<String, Object> health = new HashMap<>();

        try {
            // Check if we can get update statistics
            Map<String, Object> stats = serviceStatusCheck();
            health.put("algorithmService", "OK");
            health.put("statistics", stats);
            
            // Check cache service
            health.put("cacheService", "OK");
            
            // Check price update services
            health.put("kafkaEnabled", kafkaEnabled);
            health.put("kafkaServiceAvailable", kafkaPriceUpdateService != null);
            health.put("fallbackServiceAvailable", fallBackPriceUpdateService != null);
            
            // Check if we can get some sample prices
            List<String> sampleSymbols = List.of("AAPL", "GOOGL", "MSFT");
            Map<String, java.math.BigDecimal> samplePrices = getBatchPrices(sampleSymbols);
            health.put("samplePrices", samplePrices);
            health.put("overall", "OK");

        } catch(Exception e){
            health.put("overall", "ERROR");
            health.put("error", e.getMessage());
            logger.error("Health check failed: {}", e.getMessage(), e);
        }

        return health;
    }
    
}

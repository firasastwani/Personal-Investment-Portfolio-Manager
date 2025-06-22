package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.repository.PortfolioHoldingRepository;
import com.pipsap.pipsap.repository.SecurityRepository;
import com.pipsap.pipsap.repository.WatchlistRepository;
import com.pipsap.pipsap.service.PriceCacheService;

import java.time.Duration;
import java.util.*;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

import java.util.stream.Collectors;
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

    // 
   public List<SecurityPriority> calculateUpdatePriorities(){

        List<Security> allSecurities = securityRepository.findAll();
        List<SecurityPriority> prorities = new ArrayList<>(); 

        for(Security security: allSecurities){

            double score = calculatePriorityScore(security.getSymbol());
            String reason = generateReason(security.getSymbol());

            prorities.add(new SecurityPriority(security.getSymbol(), score, reason));
        }

        // sorts those with higest priority first
        prorities.sort((a,b) -> Double.compare(b.priorityScore, a.priorityScore));

        return prorities;
   } 

   // batches the top k priority symbols
   public List<String> getPrioritizedSymbolsForUpdate(){

        List<SecurityPriority> priorities = calculateUpdatePriorities(); 

        List<String> symbolsToUpdate = priorities.stream()
        .filter(priority -> priceCacheService.isPriceStale(priority.getSymbol())) 
        .limit(maxBatchSize)
        .map(SecurityPriority::getSymbol)
        .collect(Collectors.toList());   

        return symbolsToUpdate;
   }


   private double calculatePriorityScore(String symbol){

        double score = 0.0; 

        // Current port holdings weight: 60%
        long portfolioCount = portfolioHoldingRepository.countBySecuritySymbol(symbol);
        score += portfolioWeight * portfolioCount;

        // Current watchlist weight: 30%
        long watchListCount = watchlistRepository.countBySecuritySymbol(symbol); 
        score += watchlistWeight * watchListCount;

        // Current time since last update weight: 10%        
        Optional<LocalDateTime> lastUpdate = priceCacheService.getLastUpdateTime(symbol);

        if(lastUpdate.isPresent()){

            long hoursSinceUpdate = ChronoUnit.HOURS.between(lastUpdate.get(), LocalDateTime.now());
            score += timeWeight * hoursSinceUpdate;
        } else {

            // no price present in cache, needs high priority

            score += timeWeight * 24;
        }

        return score;
   }

   private String generateReason(String symbol){

        List<String> reasons = new ArrayList<>();


        return "";
   } 

   // for debugging
   public Map<String, Object> getUpddateStatistics(){

        Map<String, Object> stats = new HashMap<>(); 

        List<SecurityPriority> priorities = calculateUpdatePriorities();
        
        stats.put("total_securities", priorities.size());
        stats.put("prioritizedForUpdate", getPrioritizedSymbolsForUpdate());

        double avgScore = priorities.stream()
        .mapToDouble(SecurityPriority::getPriorityScore)
        .average()
        .orElse(0.0);

        stats.put("avg_priority_score", avgScore);
        
        /* 
        // Top 5 symbols by priority
        List<Map<String, Object>> topSymbols = priorities.stream()
            .limit(5)
            .map(priority -> Map.of(
                "symbol", priority.getSymbol(),
                "score", priority.getPriorityScore(),
                "reason", priority.getReason()
            ))
            .collect(Collectors.toList());
        stats.put("topPrioritySymbols", topSymbols);
        */

        return stats;
   }

   





}

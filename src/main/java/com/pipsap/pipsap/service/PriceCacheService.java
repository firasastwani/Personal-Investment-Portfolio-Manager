package com.pipsap.pipsap.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.math.BigDecimal;
import java.time.Duration;
import java.util.HashMap; 
import java.util.Map; 
import java.util.Set;

import java.time.LocalDateTime;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.data.redis.core.RedisTemplate;


@Service
public class PriceCacheService {

    private final RedisTemplate<String, String> redisTemplate; 

    @Autowired
    public PriceCacheService(RedisTemplate<String, String> redisTemplate){
        this.redisTemplate = redisTemplate;
    }
    
    @Value("${price-update.cache.ttl-minutes}")
    private int cacheTTLMinutes;

    private final ObjectMapper objectMapper = new ObjectMapper().registerModule(new JavaTimeModule()); 

    // Have prefixs on keys for namespace seperation, keep related info together
    private static final String PRICE_CACHE_PREFIX = "security:price:";
    private static final String LAST_UPDATE_PREFIX = "security:last_update:";


    public void cachePrice(String symbol, BigDecimal price){

        try{

            // price
            String priceJson = objectMapper.writeValueAsString(price); 
            // symbol
            String cacheKey = PRICE_CACHE_PREFIX + symbol.toUpperCase();
            redisTemplate.opsForValue().set(cacheKey, priceJson, Duration.ofMinutes(cacheTTLMinutes));

            // Also caching the last update timestamp:

            String timeStampKey = LAST_UPDATE_PREFIX + symbol.toUpperCase(); 
            String timeStampJson = objectMapper.writeValueAsString(LocalDateTime.now());

            redisTemplate.opsForValue().set(timeStampKey, timeStampJson, Duration.ofMinutes(cacheTTLMinutes));

        } catch(JsonProcessingException e) {

            throw new RuntimeException("Error caching the price for symbol: " + symbol, e);
        }
    }

    // accessing the existing cache 
    public Optional<BigDecimal> getCachedPrice(String symbol){

        try{

            String cacheKey = PRICE_CACHE_PREFIX + symbol.toUpperCase(); 

            // how to query for the price in the cache
            String priceJson = redisTemplate.opsForValue().get(cacheKey);

            if(priceJson != null){

                // read the price from the json and store as bigdecimal 
                BigDecimal price = objectMapper.readValue(priceJson, BigDecimal.class);
                return Optional.of(price);
            }

            return Optional.empty();

        } catch(Exception e) {
    
            return Optional.empty();
        }
    }

    public Optional<LocalDateTime> getLastUpdateTime(String symbol){

        try{ 
            String timestampKey = LAST_UPDATE_PREFIX + symbol.toUpperCase();
            String timestampJson = redisTemplate.opsForValue().get(timestampKey);

            if(timestampJson != null){

                // parse the last updated time
                LocalDateTime timestamp = objectMapper.readValue(timestampJson, LocalDateTime.class);
                return Optional.of(timestamp);
            }
            return Optional.empty(); 

        } catch(Exception e){

            return Optional.empty(); 
        }
    }

    public boolean isPriceStale(String symbol){

        Optional<LocalDateTime> lastUpdate = getLastUpdateTime(symbol);

        if(lastUpdate.isEmpty()){
            return true;
        }

        LocalDateTime now = LocalDateTime.now(); 

        Duration timeSinceUpdate = Duration.between(lastUpdate.get(), now);
        
        return timeSinceUpdate.toMinutes() >= cacheTTLMinutes;
    }

    public void cacheBatchPrices(Map<String, BigDecimal> prices){

        for(Map.Entry<String, BigDecimal> entry: prices.entrySet()) {

            cachePrice(entry.getKey(), entry.getValue());
        }   
    }

    public Map<String, BigDecimal> getBatchPrices(Set<String> symbols){

        HashMap<String, BigDecimal> map = new HashMap<>();

        for(String symbol: symbols){

            Optional<BigDecimal> price = getCachedPrice(symbol);

            if(!price.isEmpty()){

                map.put(symbol, price.get()); 
            }
        }

        return map; 
    }


    // done when data is stale/ cachged data is no longer correct
    public void invalidatePrice(String symbol){

        String priceKey = PRICE_CACHE_PREFIX + symbol.toUpperCase();
        String timestampKey = LAST_UPDATE_PREFIX + symbol.toUpperCase(); 

        redisTemplate.delete(priceKey);
        redisTemplate.delete(timestampKey);
    }

    // done when making changes to prices/cached data is no longer correct    
    public void clearAllPrices(){

        Set<String> priceKeys = redisTemplate.keys(PRICE_CACHE_PREFIX + "*");
        Set<String> timestampKeys = redisTemplate.keys(LAST_UPDATE_PREFIX + "*");

        if(priceKeys != null && !priceKeys.isEmpty()){
            redisTemplate.delete(priceKeys); 
        }

        if(timestampKeys != null && !timestampKeys.isEmpty()){
            redisTemplate.delete(timestampKeys);
        }
    }

}

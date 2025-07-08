package com.pipsap.stockpriceservice.component; 

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.pipsap.stockpriceservice.service.PriceFetchService;
import com.pipsap.stockpriceservice.service.PricePublishService;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Arrays;

@Component
public class PriceRequestKafkaListner {
    private static final Logger logger = LoggerFactory.getLogger(PriceRequestKafkaListner.class);

    private final PriceFetchService priceFetchService;
    private final PricePublishService pricePublishService;

    public PriceRequestKafkaListner(PriceFetchService priceFetchService, PricePublishService pricePublishService) {
        this.priceFetchService = priceFetchService; 
        this.pricePublishService = pricePublishService;
    }

    @KafkaListener(topics = "price-update-requests", groupId = "stock-price-consumer-group")
    public void listen(String message) {
        try {
            logger.info("Received price update request: {}", message);
            List<String> symbols = Arrays.asList(message.split(","));
            
            Map<String, String> prices = new HashMap<>();
            for (String symbol : symbols) {
                // Skip invalid symbols
                if (symbol == null || symbol.trim().isEmpty() || symbol.equals("--")) {
                    logger.warn("Skipping invalid symbol: {}", symbol);
                    continue;
                }
                
                Double price = priceFetchService.fetchPrice(symbol);
                if (price != null && price > 0) {
                    prices.put(symbol, String.valueOf(price));
                    logger.info("Added price for {}: {}", symbol, price);
                } else {
                    logger.warn("Skipping invalid price for symbol: {}", symbol);
                }
            }

            if (!prices.isEmpty()) {
                pricePublishService.publishPrices(prices);
                logger.info("Successfully published prices for symbols: {}", prices.keySet());
            } else {
                logger.warn("No valid prices to publish for symbols: {}", symbols);
            }
        } catch (Exception e) {
            logger.error("Error processing price update request: {}", e.getMessage(), e);
        }
    }
}

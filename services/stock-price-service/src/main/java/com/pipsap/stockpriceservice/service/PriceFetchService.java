package com.pipsap.stockpriceservice.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.pipsap.stockpriceservice.model.FinnhubQuote;

@Service
public class PriceFetchService {
    private static final Logger logger = LoggerFactory.getLogger(PriceFetchService.class);

    @Value("${finnhub.api-key}")
    private String apiKey;
    
    private final RestTemplate restTemplate;
    private final String FINNHUB_BASE_URL = "https://finnhub.io/api/v1/quote";

    public PriceFetchService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
    public Double fetchPrice(String symbol) {
        try {
            String url = String.format("%s?symbol=%s&token=%s", FINNHUB_BASE_URL, symbol, apiKey);
            logger.info("Fetching price for symbol: {}", symbol);
            
            FinnhubQuote quote = restTemplate.getForObject(url, FinnhubQuote.class);
            
            if (quote == null) {
                logger.warn("Received null quote for symbol: {}", symbol);
                return null;
            }
            
            double price = quote.getCurrentPrice();
            
            // Validate the price
            if (price <= 0) {
                logger.warn("Invalid price received for symbol {}: {}", symbol, price);
                return null;
            }
            
            logger.info("Successfully fetched price for {}: {}", symbol, price);
            return price;
            
        } catch (Exception e) {
            logger.error("Error fetching price for symbol {}: {}", symbol, e.getMessage());
            return null;
        }
    }
}

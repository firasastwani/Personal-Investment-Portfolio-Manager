package com.pipsap.stockpriceservice.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.pipsap.stockpriceservice.model.FinnhubQuote;

@Service
public class PriceFetchService {

    private final String API_KEY = "d162ko1r01qhsocmb2g0d162ko1r01qhsocmb2gg";
    private final RestTemplate restTemplate;
    private final String FINNHUB_BASE_URL = "https://finnhub.io/api/v1/quote";

    public PriceFetchService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
    public double fetchPrice(String symbol) {
        try {
            String url = String.format("%s?symbol=%s&token=%s", FINNHUB_BASE_URL, symbol, API_KEY);
            FinnhubQuote quote = restTemplate.getForObject(url, FinnhubQuote.class);
            return quote != null ? quote.getCurrentPrice() : 0.0;
        } catch (Exception e) {
            return 0.0;
        }
    }
}

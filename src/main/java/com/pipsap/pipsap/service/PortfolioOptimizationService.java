package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class PortfolioOptimizationService {

    private static final Logger logger = LoggerFactory.getLogger(PortfolioOptimizationService.class);

    private final PortfolioService portfolioService;
    private final PortfolioHoldingService portfolioHoldingService;
    private final RestTemplate restTemplate;

    @Value("${optimization.api.url:http://localhost:8000}")
    private String optimizationApiUrl;

    @Autowired
    public PortfolioOptimizationService(PortfolioService portfolioService,
                                        PortfolioHoldingService portfolioHoldingService) {
        this.portfolioService = portfolioService;
        this.portfolioHoldingService = portfolioHoldingService;
        this.restTemplate = new RestTemplate();
    }

    /**
     * Run Black-Litterman portfolio optimization for a user's portfolio
     * 
     * @param portfolioId The portfolio to optimize
     * @param views List of investor views (each containing ticker, return, confidence)
     * @param user The authenticated user
     * @return Optimization results with recommended weights and metrics
     */
    public OptimizationResult optimizePortfolio(Integer portfolioId, List<ViewInput> views, User user) {
        logger.info("Starting Black-Litterman optimization for portfolio {}", portfolioId);

        // Get portfolio and validate ownership
        Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
            .orElseThrow(() -> new RuntimeException("Portfolio not found"));
        
        if (!portfolio.getUser().getUserId().equals(user.getUserId())) {
            throw new RuntimeException("Not authorized to optimize this portfolio");
        }

        // Get all tickers from portfolio holdings
        List<PortfolioHolding> holdings = portfolioHoldingService.getHoldingsByPortfolioId(portfolioId);
        
        if (holdings.isEmpty()) {
            throw new RuntimeException("Portfolio has no holdings to optimize");
        }

        List<String> tickers = holdings.stream()
            .map(h -> h.getSecurity().getSymbol())
            .distinct()
            .collect(Collectors.toList());

        logger.info("Portfolio {} has {} unique tickers: {}", portfolioId, tickers.size(), tickers);

        // Validate that views reference existing tickers in the portfolio
        for (ViewInput view : views) {
            if (!tickers.contains(view.getTicker())) {
                throw new RuntimeException("View ticker '" + view.getTicker() + "' is not in the portfolio");
            }
        }

        // Call the Python Black-Litterman API
        return callOptimizationApi(tickers, views);
    }

    /**
     * Run Black-Litterman optimization with custom tickers (not tied to a portfolio)
     * Useful for testing or hypothetical scenarios
     * 
     * @param tickers List of stock tickers
     * @param views List of investor views
     * @return Optimization results
     */
    public OptimizationResult optimizeCustomPortfolio(List<String> tickers, List<ViewInput> views) {
        logger.info("Starting Black-Litterman optimization for custom portfolio with {} tickers", tickers.size());
        
        if (tickers == null || tickers.isEmpty()) {
            throw new RuntimeException("Tickers list cannot be empty");
        }

        return callOptimizationApi(tickers, views);
    }

    /**
     * Call the Python Black-Litterman optimization API
     */
    private OptimizationResult callOptimizationApi(List<String> tickers, List<ViewInput> views) {
        String endpoint = optimizationApiUrl + "/api/optimization/black-litterman";
        
        // Build request body
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("tickers", tickers);
        
        // Convert views to the format expected by the API
        List<Map<String, Object>> viewsList = views.stream()
            .map(v -> {
                Map<String, Object> viewMap = new HashMap<>();
                viewMap.put("ticker", v.getTicker());
                viewMap.put("return", v.getExpectedReturn());
                viewMap.put("confidence", v.getConfidence());
                return viewMap;
            })
            .collect(Collectors.toList());
        requestBody.put("views", viewsList);

        logger.debug("Calling optimization API at {} with request: {}", endpoint, requestBody);

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(requestBody, headers);
            
            ResponseEntity<Map> response = restTemplate.exchange(
                endpoint,
                HttpMethod.POST,
                request,
                Map.class
            );

            if (response.getStatusCode().is2xxSuccessful() && response.getBody() != null) {
                return parseOptimizationResponse(response.getBody());
            } else {
                throw new RuntimeException("Optimization API returned non-success status: " + response.getStatusCode());
            }

        } catch (RestClientException e) {
            logger.error("Failed to call optimization API: {}", e.getMessage());
            throw new RuntimeException("Failed to connect to optimization service: " + e.getMessage());
        }
    }

    /**
     * Parse the API response into an OptimizationResult
     */
    @SuppressWarnings("unchecked")
    private OptimizationResult parseOptimizationResponse(Map<String, Object> responseBody) {
        OptimizationResult result = new OptimizationResult();
        
        result.setSuccess((Boolean) responseBody.get("success"));
        result.setExpectedReturn((Double) responseBody.get("expected_return"));
        result.setVolatility((Double) responseBody.get("volatility"));
        result.setSharpeRatio((Double) responseBody.get("sharpe_ratio"));
        result.setExpectedReturnPct((String) responseBody.get("expected_return_pct"));
        result.setVolatilityPct((String) responseBody.get("volatility_pct"));

        // Parse optimal weights
        List<Map<String, Object>> weightsData = (List<Map<String, Object>>) responseBody.get("optimal_weights");
        List<WeightResult> weights = new ArrayList<>();
        
        if (weightsData != null) {
            for (Map<String, Object> weightMap : weightsData) {
                WeightResult weight = new WeightResult();
                weight.setTicker((String) weightMap.get("ticker"));
                weight.setWeight(((Number) weightMap.get("weight")).doubleValue());
                weight.setPercentage((String) weightMap.get("percentage"));
                weights.add(weight);
            }
        }
        
        result.setOptimalWeights(weights);
        
        logger.info("Optimization completed successfully. Expected return: {}, Sharpe ratio: {}", 
            result.getExpectedReturnPct(), result.getSharpeRatio());
        
        return result;
    }

    // ============== DTOs ==============

    /**
     * Input view from investor/user
     */
    public static class ViewInput {
        private String ticker;
        private double expectedReturn;
        private double confidence;

        public ViewInput() {}

        public ViewInput(String ticker, double expectedReturn, double confidence) {
            this.ticker = ticker;
            this.expectedReturn = expectedReturn;
            this.confidence = confidence;
        }

        public String getTicker() {
            return ticker;
        }

        public void setTicker(String ticker) {
            this.ticker = ticker;
        }

        public double getExpectedReturn() {
            return expectedReturn;
        }

        public void setExpectedReturn(double expectedReturn) {
            this.expectedReturn = expectedReturn;
        }

        public double getConfidence() {
            return confidence;
        }

        public void setConfidence(double confidence) {
            this.confidence = confidence;
        }
    }

    /**
     * Weight result for a single ticker
     */
    public static class WeightResult {
        private String ticker;
        private double weight;
        private String percentage;

        public WeightResult() {}

        public String getTicker() {
            return ticker;
        }

        public void setTicker(String ticker) {
            this.ticker = ticker;
        }

        public double getWeight() {
            return weight;
        }

        public void setWeight(double weight) {
            this.weight = weight;
        }

        public String getPercentage() {
            return percentage;
        }

        public void setPercentage(String percentage) {
            this.percentage = percentage;
        }
    }

    /**
     * Complete optimization result
     */
    public static class OptimizationResult {
        private boolean success;
        private List<WeightResult> optimalWeights;
        private double expectedReturn;
        private double volatility;
        private double sharpeRatio;
        private String expectedReturnPct;
        private String volatilityPct;

        public OptimizationResult() {}

        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public List<WeightResult> getOptimalWeights() {
            return optimalWeights;
        }

        public void setOptimalWeights(List<WeightResult> optimalWeights) {
            this.optimalWeights = optimalWeights;
        }

        public double getExpectedReturn() {
            return expectedReturn;
        }

        public void setExpectedReturn(double expectedReturn) {
            this.expectedReturn = expectedReturn;
        }

        public double getVolatility() {
            return volatility;
        }

        public void setVolatility(double volatility) {
            this.volatility = volatility;
        }

        public double getSharpeRatio() {
            return sharpeRatio;
        }

        public void setSharpeRatio(double sharpeRatio) {
            this.sharpeRatio = sharpeRatio;
        }

        public String getExpectedReturnPct() {
            return expectedReturnPct;
        }

        public void setExpectedReturnPct(String expectedReturnPct) {
            this.expectedReturnPct = expectedReturnPct;
        }

        public String getVolatilityPct() {
            return volatilityPct;
        }

        public void setVolatilityPct(String volatilityPct) {
            this.volatilityPct = volatilityPct;
        }
    }
}

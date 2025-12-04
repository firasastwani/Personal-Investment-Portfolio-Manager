package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.service.PortfolioOptimizationService;
import com.pipsap.pipsap.service.PortfolioOptimizationService.OptimizationResult;
import com.pipsap.pipsap.service.PortfolioOptimizationService.ViewInput;
import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/optimization")
@CrossOrigin(origins = "*")
public class OptimizationController {

    private final PortfolioOptimizationService portfolioOptimizationService;
    private final UserService userService;

    @Autowired
    public OptimizationController(PortfolioOptimizationService portfolioOptimizationService,
                                  UserService userService) {
        this.portfolioOptimizationService = portfolioOptimizationService;
        this.userService = userService;
    }

    private User getCurrentUser() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userService.getUserByUsername(username);
        if (user == null) {
            throw new RuntimeException("User not found");
        }
        return user;
    }

    /**
     * Run Black-Litterman optimization on a user's portfolio
     * 
     * Request body example:
     * {
     *   "views": [
     *     {"ticker": "AAPL", "expectedReturn": 0.15, "confidence": 0.8},
     *     {"ticker": "MSFT", "expectedReturn": 0.12, "confidence": 0.7}
     *   ]
     * }
     */
    @PostMapping("/portfolio/{portfolioId}/black-litterman")
    public ResponseEntity<Map<String, Object>> optimizePortfolio(
            @PathVariable Integer portfolioId,
            @RequestBody OptimizationRequest request) {
        
        try {
            User user = getCurrentUser();
            
            OptimizationResult result = portfolioOptimizationService.optimizePortfolio(
                portfolioId,
                request.getViews(),
                user
            );

            return ResponseEntity.ok(Map.of(
                "success", result.isSuccess(),
                "optimalWeights", result.getOptimalWeights(),
                "expectedReturn", result.getExpectedReturn(),
                "volatility", result.getVolatility(),
                "sharpeRatio", result.getSharpeRatio(),
                "expectedReturnPct", result.getExpectedReturnPct(),
                "volatilityPct", result.getVolatilityPct()
            ));

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "error", e.getMessage()
            ));
        }
    }

    /**
     * Run Black-Litterman optimization on custom tickers (for testing/exploration)
     * 
     * Request body example:
     * {
     *   "tickers": ["AAPL", "MSFT", "GOOGL", "META", "AMZN"],
     *   "views": [
     *     {"ticker": "AAPL", "expectedReturn": 0.15, "confidence": 0.8},
     *     {"ticker": "MSFT", "expectedReturn": 0.12, "confidence": 0.7}
     *   ]
     * }
     */
    @PostMapping("/custom/black-litterman")
    public ResponseEntity<Map<String, Object>> optimizeCustomPortfolio(
            @RequestBody CustomOptimizationRequest request) {
        
        try {
            // Ensure user is authenticated
            getCurrentUser();
            
            OptimizationResult result = portfolioOptimizationService.optimizeCustomPortfolio(
                request.getTickers(),
                request.getViews()
            );

            return ResponseEntity.ok(Map.of(
                "success", result.isSuccess(),
                "optimalWeights", result.getOptimalWeights(),
                "expectedReturn", result.getExpectedReturn(),
                "volatility", result.getVolatility(),
                "sharpeRatio", result.getSharpeRatio(),
                "expectedReturnPct", result.getExpectedReturnPct(),
                "volatilityPct", result.getVolatilityPct()
            ));

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "error", e.getMessage()
            ));
        }
    }

    // ============== Request DTOs ==============

    public static class OptimizationRequest {
        private List<ViewInput> views;

        public List<ViewInput> getViews() {
            return views;
        }

        public void setViews(List<ViewInput> views) {
            this.views = views;
        }
    }

    public static class CustomOptimizationRequest {
        private List<String> tickers;
        private List<ViewInput> views;

        public List<String> getTickers() {
            return tickers;
        }

        public void setTickers(List<String> tickers) {
            this.tickers = tickers;
        }

        public List<ViewInput> getViews() {
            return views;
        }

        public void setViews(List<ViewInput> views) {
            this.views = views;
        }
    }
}


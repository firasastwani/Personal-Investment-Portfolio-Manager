package com.pipsap.pipsap.controller;


import com.pipsap.pipsap.service.PriceOrchestratorService;
import com.pipsap.pipsap.service.PriceUpdateAlgorithmService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

@RestController
@RequestMapping("/api/price-updates")
@CrossOrigin("*")
public class PriceUpdateController {

    private final PriceOrchestratorService priceOrchestratorService;
    private final PriceUpdateAlgorithmService priceUpdateAlgorithmService;

    @Autowired
    public PriceUpdateController(PriceOrchestratorService priceOrchestratorService, PriceUpdateAlgorithmService priceUpdateAlgorithmService) {
        this.priceOrchestratorService = priceOrchestratorService;
        this.priceUpdateAlgorithmService = priceUpdateAlgorithmService;
    }

    // try catch pattern, calling the needed service and returning ResponseEntity.ok()

    @PostMapping("/trigger")
    public ResponseEntity<Map<String,Object>> triggerPriceUpdate(){

        try {
            priceOrchestratorService.triggerPriceUpdate();
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Price update triggered successfully"
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "error", e.getMessage()
            ));
        }
    }

    @PostMapping("/symbols")
    public ResponseEntity<Map<String,Object>> updateSpecificSymbols(@RequestBody List<String> symbols){

        try {
            priceOrchestratorService.updateSpecificSymbols(symbols);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Price update requested for " + symbols.size() + " symbols",
                "symbols", symbols
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "error", e.getMessage()
            ));
        }

    }

    @GetMapping("/price/{symbol}")
    public ResponseEntity<Map<String,Object>> getCurrPrice(@PathVariable String symbol){

        try {
            BigDecimal price = priceOrchestratorService.getCurrPrice(symbol);
            return ResponseEntity.ok(Map.of(
                "symbol", symbol,
                "price", price,
                "timestamp", System.currentTimeMillis()
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", e.getMessage()
            ));
        }

    }

    @PostMapping("/batch-prices")
    public ResponseEntity<Map<String,Object>> getBatchPrices(@RequestBody List<String> symbols){

        try {
            Map<String, BigDecimal> prices = priceOrchestratorService.getBatchPrices(symbols);
            return ResponseEntity.ok(Map.of(
                "prices", prices,
                "timestamp", System.currentTimeMillis()
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", e.getMessage()
            ));
        }
    }

    @PostMapping("/refresh")
    public ResponseEntity<Map<String, Object>> forceRefreshPrices(@RequestBody List<String> symbols){

        try {
            priceOrchestratorService.forceRefreshPrices(symbols);
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Force refresh requested for " + symbols.size() + " symbols",
                "symbols", symbols
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "error", e.getMessage()
            ));
        }
    }

    @GetMapping
    public ResponseEntity<Map<String, Object>> getUpdateStatistics(){
        try {
            Map<String, Object> stats = priceOrchestratorService.serviceStatusCheck();
            return ResponseEntity.ok(stats);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "error", e.getMessage()
            ));
        }
    }

    @GetMapping("/priorities")
    public ResponseEntity<List<PriceUpdateAlgorithmService.SecurityPriority>> getUpdatePriorities() {

        try {
            List<PriceUpdateAlgorithmService.SecurityPriority> priorities = priceOrchestratorService.getUpdatePriorities();
            return ResponseEntity.ok(priorities);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/cache")
    public ResponseEntity<Map<String, Object>> clearCache(){

        try {
            priceOrchestratorService.clearAllCachedPrices();
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "All cached prices cleared"
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false,
                "error", e.getMessage()
            ));
        }
    }

    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> healthCheck(){

        try {
            Map<String, Object> health = priceOrchestratorService.healthCheck();
            return ResponseEntity.ok(health);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "overall", "ERROR",
                "error", e.getMessage()
            ));
        }
    }

}

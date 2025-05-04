package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.service.SecurityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/securities")
@CrossOrigin(origins = "*")
public class SecurityController {

    @Autowired  
    private SecurityService securityService;

    @GetMapping
    public ResponseEntity<List<Security>> getAllSecurities() {
        try {
            System.out.println("Attempting to get all securities");
            List<Security> securities = securityService.getAllSecurities();
            System.out.println("Successfully retrieved " + securities.size() + " securities");
            return ResponseEntity.ok(securities);
        } catch (Exception e) {
            System.err.println("Error in getAllSecurities: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Security> getSecurityById(@PathVariable Integer id) {
        try {
            return securityService.getSecurityById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping
    public ResponseEntity<Security> createSecurity(@RequestBody Security security) {
        try {
            Security created = securityService.createSecurity(security);
            return ResponseEntity.ok(created);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<Security> updateSecurity(@PathVariable Integer id, @RequestBody Security security) {
        try {
            security.setId(id);
            Security updated = securityService.updateSecurity(security);
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSecurity(@PathVariable Integer id) {
        try {
            securityService.deleteSecurity(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/searchByName")
    public ResponseEntity<List<Security>> searchSecuritiesByName(@RequestParam String name) {

        List<Security> securities = securityService.searchSecuritiesByName(name);
        return ResponseEntity.ok(securities);
    }

    @GetMapping("/searchBySymbol")
    public ResponseEntity<List<Security>> searchSecuritiesBySymbol(@RequestParam String symbol) {
        
        List<Security> securities = securityService.searchSecuritiesBySymbol(symbol);
        return ResponseEntity.ok(securities);
    }

    @GetMapping("/symbol/{symbol}")
    public ResponseEntity<Security> getSecurityBySymbol(@PathVariable String symbol) {
        try {
            return securityService.getSecurityBySymbol(symbol)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }
}

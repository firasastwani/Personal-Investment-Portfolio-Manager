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
@CrossOrigin(origins = "http://localhost:3000")
public class SecurityController {

    @Autowired
    private SecurityService securityService;

    @GetMapping
    public ResponseEntity<List<Security>> getAllSecurities() {
        List<Security> securities = securityService.getAllSecurities(); // return all if empty
        return ResponseEntity.ok(securities);
    }

    @GetMapping("/getSecurityById")
    public ResponseEntity<Security> getSecurityById(@PathVariable Long id) {
        Optional<Security> security = securityService.getSecurityById(id);
        return security.map(ResponseEntity::ok)
                       .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Security> createSecurity(@RequestBody Security security) {
        Security createdSecurity = securityService.createSecurity(security);
        return ResponseEntity.ok(createdSecurity);
    }

    @PutMapping("/updateSecurity")
    public ResponseEntity<Security> updateSecurity(@RequestBody Security security) {
        Optional<Security> existingSecurity = securityService.getSecurityById(security.getId());
        if (existingSecurity.isPresent()) {
            Security updated = existingSecurity.get();
            updated.setSymbol(security.getSymbol());
            updated.setName(security.getName());
            updated.setType(security.getType());
            updated.setExchange(security.getExchange());
            updated.setStaticPrice(security.getStaticPrice());
            Security savedSecurity = securityService.updateSecurity(updated);
            return ResponseEntity.ok(savedSecurity);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/deleteSecurity")
    public ResponseEntity<Void> deleteSecurity(@PathVariable Long id) {
        Optional<Security> existingSecurity = securityService.getSecurityById(id);
        if (existingSecurity.isPresent()) {
            securityService.deleteSecurity(id);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
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

    @GetMapping("/getSecurityBySymbol")
    public ResponseEntity<Security> getSecurityBySymbol(@PathVariable String symbol) {
        Optional<Security> security = securityService.getSecurityBySymbol(symbol);
        return security.map(ResponseEntity::ok)
                       .orElse(ResponseEntity.notFound().build());
    }
}

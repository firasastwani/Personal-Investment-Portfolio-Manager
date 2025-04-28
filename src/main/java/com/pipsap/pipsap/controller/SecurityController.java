package com.pipsap.pipsap.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/securities")
public class SecurityController {

    @GetMapping
    public ResponseEntity<?> getAllSecurities() {
        // TODO: Implement get all securities logic
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getSecurity(@PathVariable Long id) {
        // TODO: Implement get security by id logic
        return ResponseEntity.ok().build();
    }

    @GetMapping("/search")
    public ResponseEntity<?> searchSecurities(@RequestParam String query) {
        // TODO: Implement search securities logic
        return ResponseEntity.ok().build();
    }
} 
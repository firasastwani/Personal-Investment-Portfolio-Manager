package com.pipsap.pipsap.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/transactions")
public class TransactionController {

    @GetMapping
    public ResponseEntity<?> getAllTransactions() {
        // TODO: Implement get all transactions logic
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getTransaction(@PathVariable Long id) {
        // TODO: Implement get transaction by id logic
        return ResponseEntity.ok().build();
    }

    @PostMapping
    public ResponseEntity<?> createTransaction() {
        // TODO: Implement create transaction logic
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateTransaction(@PathVariable Long id) {
        // TODO: Implement update transaction logic
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteTransaction(@PathVariable Long id) {
        // TODO: Implement delete transaction logic
        return ResponseEntity.ok().build();
    }
} 
package com.pipsap.pipsap.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.pipsap.pipsap.service.UserService;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.service.BalanceService;
import java.math.BigDecimal;

@RestController
@RequestMapping("/api/balance")
public class BalanceController {

    private final UserService userService;
    private final BalanceService balanceService;

    @Autowired
    public BalanceController(UserService userService, BalanceService balanceService) {
        this.userService = userService;
        this.balanceService = balanceService; 
    }

    @GetMapping("/{id}")
    public ResponseEntity<BigDecimal> getBalance(@PathVariable Integer id) {
        BigDecimal balance = balanceService.getBalance(id);
        return ResponseEntity.ok(balance);
    }
    
    @PostMapping("/add")
    public ResponseEntity<Void> addBalance(@RequestParam Integer id, @RequestParam BigDecimal amount) {
        balanceService.addBalance(id, amount);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/subtract")
    public ResponseEntity<Void> subtractBalance(@RequestParam Integer id, @RequestParam BigDecimal amount) {
        balanceService.subtractBalance(id, amount); 
        return ResponseEntity.ok().build();
    }

    @PostMapping("/update")
    public ResponseEntity<Void> updateBalance(@RequestParam Integer id, @RequestParam BigDecimal amount) {
        balanceService.updateBalance(id, amount);
        return ResponseEntity.ok().build();
    }
}

package com.pipsap.pipsap.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @PostMapping("/login")
    public ResponseEntity<?> login() {
        // TODO: Implement login logic
        return ResponseEntity.ok().build();
    }

    @PostMapping("/register")
    public ResponseEntity<?> register() {
        // TODO: Implement registration logic
        return ResponseEntity.ok().build();
    }
} 
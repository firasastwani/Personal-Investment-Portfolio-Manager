package com.pipsap.pipsap.controller;

import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final UserService userService;

    @Autowired
    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Map<String, String> registrationData) {
        String username = registrationData.get("username");
        String password = registrationData.get("password");
        String passwordRepeat = registrationData.get("passwordRepeat");

        Map<String, Object> response = new HashMap<>();

        // Validate password length
        if (password.trim().length() < 3) {
            response.put("success", false);
            response.put("message", "Passwords should have at least 3 nonempty letters.");
            return ResponseEntity.badRequest().body(response);
        }

        // Validate password match
        if (!password.equals(passwordRepeat)) {
            response.put("success", false);
            response.put("message", "Passwords do not match.");
            return ResponseEntity.badRequest().body(response);
        }

        try {
            boolean registrationSuccess = userService.registerUser(username, password);
            
            if (registrationSuccess) {
                response.put("success", true);
                response.put("message", "Registration successful. Please login.");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Registration failed. Please try again.");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "An error occurred: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credentials) {
        String username = credentials.get("username");
        String password = credentials.get("password");

        try {
            boolean isAuthenticated = userService.authenticate(username, password);
            
            if (isAuthenticated) {
                Map<String, Object> response = new HashMap<>();
                response.put("success", true);
                response.put("message", "Login successful");
                return ResponseEntity.ok(response);
            } else {
                Map<String, Object> response = new HashMap<>();
                response.put("success", false);
                response.put("message", "Invalid username or password");
                return ResponseEntity.badRequest().body(response);
            }
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "Authentication failed. Please try again.");
            return ResponseEntity.internalServerError().body(response);
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout() {
        userService.unAuthenticate();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "Logged out successfully");
        return ResponseEntity.ok(response);
    }

    @GetMapping("/check")
    public ResponseEntity<?> checkAuth() {
        boolean isAuthenticated = userService.isAuthenticated();
        Map<String, Object> response = new HashMap<>();
        response.put("authenticated", isAuthenticated);
        if (isAuthenticated) {
            response.put("user", userService.getLoggedInUser());
        }
        return ResponseEntity.ok(response);
    }
} 
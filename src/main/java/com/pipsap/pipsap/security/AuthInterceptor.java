package com.pipsap.pipsap.security;

import com.pipsap.pipsap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    private final UserService userService;

    @Autowired
    public AuthInterceptor(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();
        
        // Handle logout endpoint
        if (requestURI.equals("/api/auth/logout")) {
            userService.unAuthenticate();
            response.setStatus(HttpServletResponse.SC_OK);
            return false;
        }
        
        // For all other endpoints, check authentication
        if (!userService.isAuthenticated()) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return false;
        }
        
        return true;
    }
} 
package com.pipsap.pipsap.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.pipsap.pipsap.repository.UserRepository;
import com.pipsap.pipsap.model.User;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import java.math.BigDecimal;
import java.util.List;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.service.PortfolioAnalyticsService;
import com.pipsap.pipsap.service.PortfolioService;



@Service
public class BalanceService {

    private final UserRepository userRepository;
    private final PortfolioAnalyticsService portfolioAnalyticsService;
    private final PortfolioService portfolioService;
   
    @Autowired
    public BalanceService(UserRepository userRepository, PortfolioAnalyticsService portfolioAnalyticsService, PortfolioService portfolioService) {
        this.userRepository = userRepository;
        this.portfolioAnalyticsService = portfolioAnalyticsService;
        this.portfolioService = portfolioService;
    }

    public BigDecimal getBalance(Integer id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        return user.getBalance();
    }
    
    // administrative purposes only, not used in frontend, must be admin to access
    public void updateBalance(Integer id, BigDecimal newBalance) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        if(user.getRole() != "admin") {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "User must be an admin to update balance"); 
        }

        user.setBalance(newBalance);
        userRepository.save(user);
    }

    public void addBalance(Integer id, BigDecimal amount) {
        //check if amount is positive
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new RuntimeException("Amount must be positive");
        }
    
        User user = userRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        user.setBalance(user.getBalance().add(amount));
        userRepository.save(user);
        
        // Update total account value after balance change
        updateTotalAccountValue(id);
    }

    public void subtractBalance(Integer id, BigDecimal amount) { 
        //check if amount is positive
        if (amount.compareTo(BigDecimal.ZERO) <= 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Amount must be positive");
        }
        //check if user has enough balance
        User user = userRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
        if (user.getBalance().compareTo(amount) < 0) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "User does not have enough balance");
        }   
        //update balance
        user.setBalance(user.getBalance().subtract(amount));
        userRepository.save(user);
        
        // Update total account value after balance change
        updateTotalAccountValue(id);
    }

    public void updateTotalAccountValue(Integer id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        // Get total value of all portfolios
        BigDecimal totalPortfoliosValue = portfolioAnalyticsService.getTotalPortfoliosValue(user);
        
        // Add user's balance to get total account value
        BigDecimal totalAccountValue = totalPortfoliosValue.add(user.getBalance()); 

        user.setTotalAccountValue(totalAccountValue);
        userRepository.save(user);
    }


    // future implementation
    /*
    public void transferBalance(Integer fromId, Integer toId, Long amount) {
        User fromUser = userRepository.findById(fromId)
            .orElseThrow(() -> new RuntimeException("User not found"));
        User toUser = userRepository.findById(toId)
            .orElseThrow(() -> new RuntimeException("User not found"));
        fromUser.setBalance(fromUser.getBalance() - amount);
        toUser.setBalance(toUser.getBalance() + amount);
        userRepository.save(fromUser);
        userRepository.save(toUser);
    }
    */

}
    
    
    
    


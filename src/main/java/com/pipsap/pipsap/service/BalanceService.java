package com.pipsap.pipsap.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.pipsap.pipsap.repository.UserRepository;
import com.pipsap.pipsap.model.User;


@Service
public class BalanceService {

    private final UserRepository userRepository;
   
    @Autowired
    public BalanceService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Long getBalance(Integer id) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));
        return user.getBalance();
    }
    

    // administrative purposes only, not used in frontend, must be admin to access
    public void updateBalance(Integer id, Long newBalance) {

        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));

        if(user.getRole() != "admin") {
            throw new RuntimeException("User must be an admin to update balance"); 
        }

        user.setBalance(newBalance);
        userRepository.save(user);
    }

    public void addBalance(Integer id, Long amount) {

        //check if amount is positive
        if (amount <= 0) {
            throw new RuntimeException("Amount must be positive");
        }
    
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));
        user.setBalance(user.getBalance() + amount);
        userRepository.save(user);
    }

    public void subtractBalance(Integer id, Long amount) { 

        //check if amount is positive
        if (amount <= 0) {
            throw new RuntimeException("Amount must be positive");
        }
        //check if user has enough balance
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));
        if (user.getBalance() < amount) {
            throw new RuntimeException("User does not have enough balance");
        }   
        //update balance
        user.setBalance(user.getBalance() - amount);
        userRepository.save(user);
    }


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
    
    
    
    


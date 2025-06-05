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
    
    public void updateBalance(Integer id, Long newBalance) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));
        user.setBalance(newBalance);
        userRepository.save(user);
    }

    public void addBalance(Integer id, Long amount) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));
        user.setBalance(user.getBalance() + amount);
        userRepository.save(user);
    }

    public void subtractBalance(Integer id, Long amount) {  
        User user = userRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("User not found"));
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
    
    
    
    


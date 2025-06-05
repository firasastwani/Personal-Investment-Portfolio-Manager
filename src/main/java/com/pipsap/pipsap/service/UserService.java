package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.context.annotation.SessionScope;

import java.util.Optional;

@Service
@SessionScope
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    private final DataSource dataSource;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private User loggedInUser = null; 

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, DataSource dataSource) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.dataSource = dataSource;
        this.bCryptPasswordEncoder = new BCryptPasswordEncoder();
    }

    public boolean authenticate(String username, String password) {
        final String sql = "Select * from users where username = ?"; 

        try (Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (bCryptPasswordEncoder.matches(password, storedPassword)) {
                    loggedInUser = new User();
                    loggedInUser.setUserId(rs.getInt("user_id"));
                    loggedInUser.setUsername(rs.getString("username"));
                    loggedInUser.setPassword(rs.getString("password"));
                    return true;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error authenticating user", e);
        }

        return false;
    }

    public void unAuthenticate() {
        
        System.out.println("Unauthenticating user");

        loggedInUser = null;
    }

    public boolean isAuthenticated() {
        System.out.println("loggedInUser: " + loggedInUser);
        return loggedInUser != null;
    }

    public User getLoggedInUser() {
        return loggedInUser;
    }

    @Transactional
    public boolean registerUser(String username, String password) {
        if (userRepository.findByUsername(username).isPresent()) {
            return false;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole("ROLE_USER");
        user.setBalance(0L); // Initialize balance to 0

        userRepository.save(user);
        return true;
    }

    public User getUserByUsername(String username) {
        return userRepository.findByUsername(username)
                .orElse(null);
    }

    public Integer getUserIdByUsername(String username) {
        User user = getUserByUsername(username);
        return user != null ? user.getUserId() : null;
    }
} 
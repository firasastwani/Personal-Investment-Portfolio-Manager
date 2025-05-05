package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.repository.UserRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import java.util.Optional;

@Service
@SessionScope
public class UserService {
    @Autowired
    private UserRepository userRepository;

    private final DataSource dataSource;

    private final BCryptPasswordEncoder passwordEncoder;

    private User loggedInUser = null; 

    @Autowired
    public UserService(DataSource dataSource) {
        this.dataSource = dataSource;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public boolean authenticate(String username, String password) {
        final String sql = "Select * from users where username = ?"; 

        try (Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (passwordEncoder.matches(password, storedPassword)) {
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

    public boolean registerUser(String username, String password) {
        final String sql = "Insert into users (username, password) values (?, ?)";

        try (Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, passwordEncoder.encode(password));

            int rowsEffected = stmt.executeUpdate();

            return rowsEffected > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error registering user", e);
        }
    }

    public User getUserByUsername(String username) {

        final String sql = "Select * from users where username = ?";
        User user = null; 

        try (Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting user by username", e);
        }

        return user;
    }

    //Get user id from username
    public Integer getUserIdByUsername(String username) {

        final String sql = "SELECT user_id FROM users WHERE username = ?";
        Integer userId = null;
    
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
    
            if (rs.next()) {
                userId = rs.getInt("user_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error getting user ID by username", e);
        }
    
        return userId;
    }
    

    
} 
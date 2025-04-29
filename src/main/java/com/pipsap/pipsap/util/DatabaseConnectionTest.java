/*
package com.pipsap.pipsap.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnectionTest {
    private static final String URL = "jdbc:mysql://localhost:33306/pipsap_db";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "mysqlpass";

    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Attempt to establish connection
            System.out.println("Connecting to database...");
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            
            if (connection != null) {
                System.out.println("Successfully connected to the database!");
                connection.close();
            }
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Connection failed! Check output console");
            e.printStackTrace();
        }
    }
} 
*/
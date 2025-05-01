-- Create the database
CREATE DATABASE IF NOT EXISTS pipsap_db;

USE pipsap_db;

-- Users Table
CREATE TABLE if not exists users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Portfolios Table
CREATE TABLE if not exists portfolios (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Transactions Table
CREATE TABLE if not exists transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    portfolio_id INT NOT NULL,
    symbol VARCHAR(10) NOT NULL,
    transaction_type ENUM('BUY', 'SELL') NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    transaction_date DATETIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id) ON DELETE CASCADE
);

-- Watchlist Table
CREATE TABLE if not exists watchlist (
    watchlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    symbol VARCHAR(10) NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);
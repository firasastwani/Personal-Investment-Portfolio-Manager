-- Create the database
CREATE DATABASE IF NOT EXISTS pipsap_db;

USE pipsap_db;

-- Users Table
CREATE TABLE if not exists users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    balance FLOAT NOT NULL DEFAULT 0.0,
    role VARCHAR(20) NOT NULL DEFAULT 'ROLE_USER',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Securities Table (moved up to be referenced by other tables)
CREATE TABLE IF NOT EXISTS securities (
    security_id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100),
    exchange VARCHAR(50),
    sector VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'USD'
);

-- Run this after creating database to boost securities performance
CREATE INDEX idx_symbol ON securities(symbol);
CREATE INDEX idx_name ON securities(name);


-- Portfolios Table
CREATE TABLE if not exists portfolios (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Portfolio Holdings Table
CREATE TABLE if not exists portfolio_holdings (
    holding_id INT AUTO_INCREMENT PRIMARY KEY,
    portfolio_id INT NOT NULL,
    security_id INT NOT NULL,
    quantity INT NOT NULL,
    average_purchase_price DECIMAL(10,2) NOT NULL,
    current_value DECIMAL(10,2) NOT NULL,
    last_updated DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (security_id) REFERENCES securities(security_id) ON DELETE CASCADE,
    UNIQUE KEY unique_portfolio_security (portfolio_id, security_id)
);

-- Transactions Table
CREATE TABLE if not exists transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    portfolio_id INT NOT NULL,
    security_id INT NOT NULL,
    transaction_type ENUM('BUY', 'SELL') NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    transaction_date DATETIME NOT NULL,
    notes TEXT,
    FOREIGN KEY (portfolio_id) REFERENCES portfolios(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (security_id) REFERENCES securities(security_id) ON DELETE CASCADE
);

-- Add index for transaction_date to optimize date-based queries
CREATE INDEX idx_transaction_date ON transactions(transaction_date);

-- Watchlist Table
CREATE TABLE if not exists watchlist (
    watchlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    security_id INT NOT NULL,
    added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (security_id) REFERENCES securities(security_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_security (user_id, security_id)
);

-- Historical TAV Table
CREATE TABLE if not exists historical_tav (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    tav_value DECIMAL(15,2) NOT NULL,
    recorded_at DATETIME NOT NULL,
    date_key VARCHAR(10) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_date (user_id, date_key)
);

-- Add indexes for historical TAV queries
CREATE INDEX idx_historical_tav_user_date ON historical_tav(user_id, date_key);
CREATE INDEX idx_historical_tav_date_key ON historical_tav(date_key);

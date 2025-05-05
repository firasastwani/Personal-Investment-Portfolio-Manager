-- Portfolio Management Queries
-- Used in: /portfolio/{portfolio_id}

-- Get portfolio diversification by sector
-- Shows the distribution of investments across different sectors in a portfolio
SELECT 
    p.portfolio_id,
    p.name as portfolio_name,
    s.sector,
    COUNT(ph.security_id) as number_of_securities,
    SUM(ph.quantity * ph.current_value) as total_value,
    ROUND(SUM(ph.quantity * ph.current_value) / 
        (SELECT SUM(ph2.quantity * ph2.current_value) 
         FROM portfolio_holdings ph2 
         WHERE ph2.portfolio_id = p.portfolio_id) * 100, 2) as percentage_of_portfolio
FROM portfolios p
JOIN portfolio_holdings ph ON p.portfolio_id = ph.portfolio_id
JOIN securities s ON ph.security_id = s.security_id
WHERE p.portfolio_id = ?
GROUP BY p.portfolio_id, p.name, s.sector
ORDER BY total_value DESC;

-- Get portfolio holdings
-- Shows all securities held in a portfolio with their current values
SELECT 
    s.symbol,
    s.name,
    s.sector,
    ph.quantity,
    ph.average_purchase_price,
    ph.current_value,
    (ph.current_value - (ph.quantity * ph.average_purchase_price)) as unrealized_gain_loss
FROM portfolio_holdings ph
JOIN securities s ON ph.security_id = s.security_id
WHERE ph.portfolio_id = ?
ORDER BY ph.current_value DESC;

-- Transaction Management Queries
-- Used in: /portfolio/{portfolio_id}/transactions

-- Get portfolio transaction history
-- Shows all buy/sell transactions for a portfolio
SELECT 
    t.transaction_id,
    t.transaction_date,
    s.symbol,
    s.name as security_name,
    t.transaction_type,
    t.quantity,
    t.price,
    (t.quantity * t.price) as transaction_value,
    t.notes
FROM transactions t
JOIN securities s ON t.security_id = s.security_id
WHERE t.portfolio_id = ?
ORDER BY t.transaction_date DESC
LIMIT ?;

-- Add new transaction
-- Records a new buy/sell transaction
INSERT INTO transactions (
    portfolio_id,
    security_id,
    transaction_type,
    quantity,
    price,
    transaction_date,
    notes
) VALUES (?, ?, ?, ?, ?, ?, ?);

-- Update portfolio holdings after transaction
-- Updates the quantity and average purchase price of a security in a portfolio
INSERT INTO portfolio_holdings (
    portfolio_id,
    security_id,
    quantity,
    average_purchase_price,
    current_value
) VALUES (?, ?, ?, ?, ?)
ON DUPLICATE KEY UPDATE
    quantity = quantity + ?,
    average_purchase_price = ?,
    current_value = ?;

-- Security Management Queries
-- Used in: /securities and /watchlist

-- Get top performing securities
-- Shows the most valuable securities across all portfolios
SELECT 
    s.symbol,
    s.name,
    s.sector,
    COUNT(DISTINCT ph.portfolio_id) as number_of_portfolios,
    SUM(ph.quantity * ph.current_value) as total_value,
    AVG(ph.quantity) as average_quantity
FROM securities s
JOIN portfolio_holdings ph ON s.security_id = ph.security_id
GROUP BY s.security_id, s.symbol, s.name, s.sector
HAVING COUNT(DISTINCT ph.portfolio_id) >= ?
ORDER BY total_value DESC
LIMIT ?;

-- Search securities
-- Used in: /securities/search
SELECT 
    security_id,
    symbol,
    name,
    exchange,
    sector,
    static_price,
    currency
FROM securities
WHERE symbol LIKE ? OR name LIKE ?
ORDER BY symbol
LIMIT ?;

-- Watchlist Management
-- Used in: /watchlist

-- Add security to watchlist
INSERT INTO watchlist (user_id, security_id)
VALUES (?, ?);

-- Remove security from watchlist
DELETE FROM watchlist
WHERE user_id = ? AND security_id = ?;

-- Get user's watchlist
SELECT 
    s.symbol,
    s.name,
    s.sector,
    s.static_price,
    w.added_at
FROM watchlist w
JOIN securities s ON w.security_id = s.security_id
WHERE w.user_id = ?
ORDER BY w.added_at DESC;

-- User Management Queries
-- Used in: /auth/*

-- Create new user
INSERT INTO users (username, password)
VALUES (?, ?);

-- Get user by username
SELECT user_id, username, password
FROM users
WHERE username = ?;

-- Portfolio Creation/Management
-- Used in: /portfolio/create and /portfolio/{portfolio_id}/edit

-- Create new portfolio
INSERT INTO portfolios (user_id, name, description)
VALUES (?, ?, ?);

-- Update portfolio details
UPDATE portfolios
SET name = ?, description = ?
WHERE portfolio_id = ? AND user_id = ?;

-- Delete portfolio
DELETE FROM portfolios
WHERE portfolio_id = ? AND user_id = ?;

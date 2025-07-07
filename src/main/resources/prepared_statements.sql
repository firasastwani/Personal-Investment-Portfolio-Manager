-- Query 1: Get portfolio diversification by sector
-- Direct query version (for testing):
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
WHERE p.portfolio_id = ?  -- Replace 1 with actual portfolio_id for testing
GROUP BY p.portfolio_id, p.name, s.sector
ORDER BY total_value DESC;

-- Prepared statement version (for application):
PREPARE portfolio_sector_diversification FROM '
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
WHERE p.portfolio_id = 23
GROUP BY p.portfolio_id, p.name, s.sector
ORDER BY total_value DESC';

-- Query 2: Get top performing securities across all portfolios
-- Direct query version (for testing):
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
HAVING COUNT(DISTINCT ph.portfolio_id) >= 1  -- Replace 1 with minimum number of portfolios
ORDER BY total_value DESC
LIMIT 10;  -- Replace 10 with desired limit

-- Prepared statement version (for application):
PREPARE top_performing_securities FROM '
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
LIMIT ?';

-- Query 3: Get portfolio transaction history with security details
-- Direct query version (for testing):
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
WHERE t.portfolio_id = 23  -- Replace 1 with actual portfolio_id for testing
ORDER BY t.transaction_date DESC
LIMIT 10;  -- Replace 10 with desired limit

-- Prepared statement version (for application):
PREPARE portfolio_transaction_history FROM '
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
LIMIT ?'; 
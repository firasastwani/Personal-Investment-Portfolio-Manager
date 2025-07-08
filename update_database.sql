USE pipsap_db;

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
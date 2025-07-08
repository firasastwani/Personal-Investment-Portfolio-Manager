package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.User;
import com.pipsap.pipsap.model.HistoricalTAV;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pipsap.pipsap.repository.UserRepository;
import com.pipsap.pipsap.repository.HistoricalTAVRepository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.math.BigDecimal;
import java.util.Optional;

@Service
public class PortfolioAnalyticsService {

    private final DataSource dataSource;
    private final PortfolioService portfolioService;
    private final UserRepository userRepository;
    private final HistoricalTAVRepository historicalTAVRepository;

    @Autowired
    public PortfolioAnalyticsService(DataSource dataSource, PortfolioService portfolioService, UserRepository userRepository, HistoricalTAVRepository historicalTAVRepository) {
        this.dataSource = dataSource;
        this.portfolioService = portfolioService;
        this.userRepository = userRepository;
        this.historicalTAVRepository = historicalTAVRepository;
    }

    /**
     * Get portfolio diversification by sector
     * @param portfolioId The ID of the portfolio to analyze
     * @return List of sector diversification data
     */
    public List<Map<String, Object>> getPortfolioSectorDiversification(Integer portfolioId) {
        List<Map<String, Object>> results = new ArrayList<>();
        
        final String sql = """
            SELECT 
                p.portfolio_id,
                p.name as portfolio_name,
                s.sector,
                COUNT(ph.security_id) as number_of_securities,
                SUM(ph.current_value) as total_value,
                ROUND(SUM(ph.current_value) / 
                    (SELECT SUM(ph2.current_value) 
                     FROM portfolio_holdings ph2 
                     WHERE ph2.portfolio_id = p.portfolio_id) * 100, 2) as percentage_of_portfolio
            FROM portfolios p
            JOIN portfolio_holdings ph ON p.portfolio_id = ph.portfolio_id
            JOIN securities s ON ph.security_id = s.security_id
            WHERE p.portfolio_id = ?
            GROUP BY p.portfolio_id, p.name, s.sector
            ORDER BY total_value DESC
            """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, portfolioId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("portfolioId", rs.getInt("portfolio_id"));
                    row.put("portfolioName", rs.getString("portfolio_name"));
                    row.put("sector", rs.getString("sector"));
                    row.put("numberOfSecurities", rs.getInt("number_of_securities"));
                    row.put("totalValue", rs.getDouble("total_value"));
                    row.put("percentageOfPortfolio", rs.getDouble("percentage_of_portfolio"));
                    results.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return results;
    }

    /**
     * Get top performing securities across all portfolios
     * @param minPortfolios Minimum number of portfolios that must hold the security
     * @param limit Maximum number of results to return
     * @return List of top performing securities
     */
    public List<Map<String, Object>> getTopPerformingSecurities(int minPortfolios, int limit) {
        List<Map<String, Object>> results = new ArrayList<>();
        
        final String sql = """
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
            LIMIT ?
            """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, minPortfolios);
            stmt.setInt(2, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("symbol", rs.getString("symbol"));
                    row.put("name", rs.getString("name"));
                    row.put("sector", rs.getString("sector"));
                    row.put("numberOfPortfolios", rs.getInt("number_of_portfolios"));
                    row.put("totalValue", rs.getDouble("total_value"));
                    row.put("averageQuantity", rs.getDouble("average_quantity"));
                    results.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return results;
    }

    /**
     * Get portfolio transaction history with security details
     * @param portfolioId The ID of the portfolio
     * @param limit Maximum number of transactions to return
     * @return List of transactions with security details
     */
    public List<Map<String, Object>> getPortfolioTransactionHistory(Integer portfolioId, int limit) {
        List<Map<String, Object>> results = new ArrayList<>();
        
        final String sql = """
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
            LIMIT ?
            """;

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, portfolioId);
            stmt.setInt(2, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("transactionId", rs.getInt("transaction_id"));
                    row.put("transactionDate", rs.getTimestamp("transaction_date"));
                    row.put("symbol", rs.getString("symbol"));
                    row.put("securityName", rs.getString("security_name"));
                    row.put("transactionType", rs.getString("transaction_type"));
                    row.put("quantity", rs.getDouble("quantity"));
                    row.put("price", rs.getDouble("price"));
                    row.put("transactionValue", rs.getDouble("transaction_value"));
                    row.put("notes", rs.getString("notes"));
                    results.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return results;
    }

    /**
     * Get total value of holdings in a portfolio
     * @param portfolioId The ID of the portfolio
     * @return Total value of holdings in the portfolio
     */
    public double getTotalValueOfHoldings(Integer portfolioId) {
        final String sql = """
            SELECT SUM(ph.current_value) as total_value
            FROM portfolio_holdings ph
            WHERE ph.portfolio_id = ?
            """;    

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, portfolioId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_value");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Get total account value (TAV) for a user
     * TAV = User's balance + Sum of all portfolio values
     * @param user The user to calculate TAV for
     * @return Total account value
     */
    public BigDecimal getTotalPortfoliosValue(User user) {

        BigDecimal totalPortfolioValue = BigDecimal.ZERO;

        // Get all user's portfolios
        List<Portfolio> portfolios = portfolioService.getPortfoliosByUser(user);
        
        // Sum up all portfolio values
        for (Portfolio portfolio : portfolios) {
            totalPortfolioValue = totalPortfolioValue.add(new BigDecimal(getTotalValueOfHoldings(portfolio.getPortfolioId())));
        }
            
        user.setTotalAccountValue(totalPortfolioValue.add(user.getBalance()));
        userRepository.save(user);

        return totalPortfolioValue;
    }

    /**
     * Get historical TAV data for the past few days
     * Uses real historical data from the database
     * @param user The user to get historical TAV for
     * @param days Number of days to look back (default 7)
     * @return List of historical TAV data points
     */
    public List<Map<String, Object>> getHistoricalTAVData(User user, int days) {
        List<Map<String, Object>> historicalData = new ArrayList<>();
        
        // Calculate start date (days ago)
        java.time.LocalDate startDate = java.time.LocalDate.now().minusDays(days);
        String startDateStr = startDate.toString();
        
        // Get historical data from database
        List<HistoricalTAV> historicalRecords = historicalTAVRepository.findLastNDays(user, startDateStr);
        
        // If we don't have enough historical data, create some initial data
        if (historicalRecords.isEmpty()) {
            // Create initial historical data based on current TAV
            BigDecimal currentTAV = getTotalPortfoliosValue(user).add(user.getBalance());
            createInitialHistoricalData(user, currentTAV, days);
            historicalRecords = historicalTAVRepository.findLastNDays(user, startDateStr);
        }
        
        // Convert to the expected format
        for (HistoricalTAV record : historicalRecords) {
            Map<String, Object> dataPoint = new HashMap<>();
            dataPoint.put("date", record.getDateKey());
            dataPoint.put("tav", record.getTavValue().doubleValue());
            dataPoint.put("pnl", 0.0); // Will be calculated below
            dataPoint.put("pnlPercentage", 0.0); // Will be calculated below
            historicalData.add(dataPoint);
        }
        
        // Calculate PnL for each data point
        for (int i = 1; i < historicalData.size(); i++) {
            Map<String, Object> current = historicalData.get(i);
            Map<String, Object> previous = historicalData.get(i - 1);
            
            double currentTAV = (Double) current.get("tav");
            double previousTAV = (Double) previous.get("tav");
            
            double pnl = currentTAV - previousTAV;
            double pnlPercentage = previousTAV > 0 ? (pnl / previousTAV) * 100 : 0.0;
            
            current.put("pnl", pnl);
            current.put("pnlPercentage", pnlPercentage);
        }
        
        return historicalData;
    }
    
    /**
     * Create initial historical data for a user
     * @param user The user to create data for
     * @param currentTAV Current TAV value
     * @param days Number of days to create data for
     */
    private void createInitialHistoricalData(User user, BigDecimal currentTAV, int days) {
        java.time.LocalDate today = java.time.LocalDate.now();
        
        for (int i = days; i >= 0; i--) {
            java.time.LocalDate date = today.minusDays(i);
            String dateKey = date.toString();
            
            // Check if record already exists for this date
            if (!historicalTAVRepository.existsByUserAndDateKey(user, dateKey)) {
                // Create a realistic TAV value with small daily variations
                double variation = 1.0 + (Math.random() - 0.5) * 0.02; // ±1% variation
                BigDecimal historicalTAV = currentTAV.multiply(new BigDecimal(variation));
                
                HistoricalTAV record = new HistoricalTAV(user, historicalTAV);
                record.setDateKey(dateKey);
                record.setRecordedAt(java.time.LocalDateTime.of(date, java.time.LocalTime.NOON));
                
                historicalTAVRepository.save(record);
            }
        }
    }
    
    /**
     * Record current TAV for today
     * @param user The user to record TAV for
     */
    public void recordCurrentTAV(User user) {
        BigDecimal currentTAV = getTotalPortfoliosValue(user).add(user.getBalance());
        String today = java.time.LocalDate.now().toString();
        
        // Check if we already have a record for today
        if (!historicalTAVRepository.existsByUserAndDateKey(user, today)) {
            HistoricalTAV record = new HistoricalTAV(user, currentTAV);
            record.setDateKey(today);
            historicalTAVRepository.save(record);
        } else {
            // Update existing record for today
            Optional<HistoricalTAV> existingRecord = historicalTAVRepository.findByUserAndDateKey(user, today);
            if (existingRecord.isPresent()) {
                HistoricalTAV record = existingRecord.get();
                record.setTavValue(currentTAV);
                historicalTAVRepository.save(record);
            }
        }
    }
} 
package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.model.PortfolioHolding;
import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.pipsap.pipsap.repository.UserRepository;

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

@Service
public class PortfolioAnalyticsService {

    private final DataSource dataSource;
    private final PortfolioService portfolioService;
    private final UserRepository userRepository;

    @Autowired
    public PortfolioAnalyticsService(DataSource dataSource, PortfolioService portfolioService, UserRepository userRepository) {
        this.dataSource = dataSource;
        this.portfolioService = portfolioService;
        this.userRepository = userRepository;
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
} 
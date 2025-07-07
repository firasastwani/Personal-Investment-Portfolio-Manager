package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.repository.SecurityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class SecurityService {


    private final SecurityRepository securityRepository;
    private final DataSource dataSource;

    @Autowired
    public SecurityService(SecurityRepository securityRepository, DataSource dataSource) {
        this.securityRepository = securityRepository;
        this.dataSource = dataSource;
    }


    public List<Security> getAllSecurities() {
        List<Security> securities = new ArrayList<>();
        final String sql = "SELECT security_id, symbol, name, exchange, sector, price, currency FROM securities";

        try (Connection conn = dataSource.getConnection()) {
            System.out.println("SecurityService: Successfully connected to database");
            
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                System.out.println("SecurityService: Prepared statement: " + sql);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    System.out.println("SecurityService: Executing query");
                    
                    while (rs.next()) {
                        Security security = new Security();
                        security.setId(rs.getInt("security_id"));
                        security.setSymbol(rs.getString("symbol"));
                        security.setName(rs.getString("name"));
                        security.setExchange(rs.getString("exchange"));
                        security.setSector(rs.getString("sector"));
                        security.setPrice(rs.getBigDecimal("price"));
                        security.setCurrency(rs.getString("currency"));
                        securities.add(security);
                    }
                }
            }
            
            System.out.println("SecurityService: Successfully retrieved " + securities.size() + " securities");
            return securities;
            
        } catch (SQLException e) {
            System.err.println("SecurityService SQL Error: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            throw new RuntimeException("Error retrieving securities", e);
        }
    }

    public java.math.BigDecimal getPriceBySymbol(String symbol) {
        Security security = getSecurityBySymbol(symbol)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Security not found"));
        return security.getPrice();
    }

    public Security createSecurity(Security security) {
        return securityRepository.save(security);
    }

    public Optional<Security> getSecurityById(Integer id) {
        return securityRepository.findById(id);
    }

    public Optional<Security> getSecurityBySymbol(String symbol) {
        return securityRepository.findBySymbol(symbol);
    }

    public List<Security> searchSecuritiesByName(String name) {
        return securityRepository.findByNameContainingIgnoreCase(name);
    }

    public List<Security> searchSecuritiesBySymbol(String symbol) {
        return securityRepository.findBySymbolContainingIgnoreCase(symbol);
    }

    public Security updateSecurity(Security security) {
        return securityRepository.save(security);
    }

    public void deleteSecurity(Integer id) {
        securityRepository.deleteById(id);
    }
    
    public void updateSecurityPrice(String symbol, java.math.BigDecimal newPrice){

        Optional<Security> securityOpt = getSecurityBySymbol(symbol);

        if(securityOpt.isPresent()){

            Security security = securityOpt.get();

            security.setPrice(newPrice);
            securityRepository.save(security);
        } else {

            throw new RuntimeException("Security not found: " + symbol);
        }

    }
} 
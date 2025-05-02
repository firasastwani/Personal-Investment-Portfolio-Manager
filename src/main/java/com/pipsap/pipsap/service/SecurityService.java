package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.repository.SecurityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SecurityService {
    @Autowired
    private SecurityRepository securityRepository;

    public List<Security> getAllSecurities() {
        return securityRepository.findAll();
    }

    public Security createSecurity(Security security) {
        return securityRepository.save(security);
    }

    public Optional<Security> getSecurityById(Long id) {
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

    public void deleteSecurity(Long id) {
        securityRepository.deleteById(id);
    }
} 
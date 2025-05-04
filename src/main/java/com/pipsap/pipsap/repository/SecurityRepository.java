package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.Security;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SecurityRepository extends JpaRepository<Security, Integer> {
    Optional<Security> findBySymbol(String symbol);
    List<Security> findByNameContainingIgnoreCase(String name);
    List<Security> findBySymbolContainingIgnoreCase(String symbol);
} 
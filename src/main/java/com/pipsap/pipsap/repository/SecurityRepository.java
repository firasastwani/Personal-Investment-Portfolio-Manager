package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.Security;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface SecurityRepository extends JpaRepository<Security, Long> {
    Optional<Security> findBySymbol(String symbol);
    List<Security> findByNameContainingIgnoreCase(String name);
    List<Security> findBySymbolContainingIgnoreCase(String symbol);
} 
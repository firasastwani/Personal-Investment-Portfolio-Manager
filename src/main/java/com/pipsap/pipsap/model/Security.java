package com.pipsap.pipsap.model;

import jakarta.persistence.*;
import java.util.Set;

@Entity
@Table(name = "securities")
public class Security {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String symbol;

    @Column(nullable = false)
    private String name;

    @Column
    private String type; // e.g., STOCK, ETF, BOND

    @Column
    private String exchange;

    @OneToMany(mappedBy = "security", cascade = CascadeType.ALL)
    private Set<Transaction> transactions;

    @OneToMany(mappedBy = "security", cascade = CascadeType.ALL)
    private Set<WatchlistItem> watchlistItems;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getExchange() {
        return exchange;
    }

    public void setExchange(String exchange) {
        this.exchange = exchange;
    }

    public Set<Transaction> getTransactions() {
        return transactions;
    }

    public void setTransactions(Set<Transaction> transactions) {
        this.transactions = transactions;
    }

    public Set<WatchlistItem> getWatchlistItems() {
        return watchlistItems;
    }

    public void setWatchlistItems(Set<WatchlistItem> watchlistItems) {
        this.watchlistItems = watchlistItems;
    }
} 
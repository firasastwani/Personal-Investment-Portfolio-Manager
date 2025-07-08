package com.pipsap.pipsap.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "historical_tav")
public class HistoricalTAV {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "tav_value", nullable = false, precision = 15, scale = 2)
    private BigDecimal tavValue;

    @Column(name = "recorded_at", nullable = false)
    private LocalDateTime recordedAt;

    @Column(name = "date_key", nullable = false)
    private String dateKey; // Format: YYYY-MM-DD for easy querying

    @PrePersist
    protected void onCreate() {
        if (recordedAt == null) {
            recordedAt = LocalDateTime.now();
        }
        if (dateKey == null) {
            dateKey = recordedAt.toLocalDate().toString();
        }
    }

    // Constructors
    public HistoricalTAV() {}

    public HistoricalTAV(User user, BigDecimal tavValue) {
        this.user = user;
        this.tavValue = tavValue;
        this.recordedAt = LocalDateTime.now();
        this.dateKey = this.recordedAt.toLocalDate().toString();
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public BigDecimal getTavValue() {
        return tavValue;
    }

    public void setTavValue(BigDecimal tavValue) {
        this.tavValue = tavValue;
    }

    public LocalDateTime getRecordedAt() {
        return recordedAt;
    }

    public void setRecordedAt(LocalDateTime recordedAt) {
        this.recordedAt = recordedAt;
    }

    public String getDateKey() {
        return dateKey;
    }

    public void setDateKey(String dateKey) {
        this.dateKey = dateKey;
    }
} 
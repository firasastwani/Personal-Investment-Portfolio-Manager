package com.pipsap.pipsap.repository;

import com.pipsap.pipsap.model.HistoricalTAV;
import com.pipsap.pipsap.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface HistoricalTAVRepository extends JpaRepository<HistoricalTAV, Integer> {
    
    // Find all historical TAV records for a user, ordered by date
    List<HistoricalTAV> findByUserOrderByRecordedAtDesc(User user);
    
    // Find historical TAV records for a user within a date range
    List<HistoricalTAV> findByUserAndDateKeyBetweenOrderByDateKeyDesc(
        User user, String startDate, String endDate);
    
    // Find the most recent TAV record for a user
    Optional<HistoricalTAV> findFirstByUserOrderByRecordedAtDesc(User user);
    
    // Find TAV record for a specific date
    Optional<HistoricalTAV> findByUserAndDateKey(User user, String dateKey);
    
    // Find TAV records for the last N days
    @Query("SELECT h FROM HistoricalTAV h WHERE h.user = :user AND h.dateKey >= :startDate ORDER BY h.dateKey DESC")
    List<HistoricalTAV> findLastNDays(@Param("user") User user, @Param("startDate") String startDate);
    
    // Check if a record exists for today
    boolean existsByUserAndDateKey(User user, String dateKey);
} 
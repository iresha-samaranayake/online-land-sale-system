package com.landselling.Online_land_sales_portal.Repository;

import com.landselling.Online_land_sales_portal.entity.Land;
import com.landselling.Online_land_sales_portal.entity.Promotion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PromotionRepository extends JpaRepository<Promotion, Long> {
    Promotion findByListing(Land listing);

    @Query("SELECT DISTINCT p FROM Promotion p JOIN FETCH p.listing l JOIN FETCH l.images WHERE p.isActive = true AND p.startDate <= :currentDate AND p.endDate >= :currentDate AND l.status = 'AVAILABLE'")
    List<Promotion> findActivePromotions(@Param("currentDate") LocalDate currentDate);

    @Query("SELECT p FROM Promotion p WHERE p.isActive = true AND p.endDate < :currentDate")
    List<Promotion> findExpiredPromotions(@Param("currentDate") LocalDate currentDate);
}
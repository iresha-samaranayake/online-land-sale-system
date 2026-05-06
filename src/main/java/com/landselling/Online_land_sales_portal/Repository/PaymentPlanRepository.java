package com.landselling.Online_land_sales_portal.Repository;

import com.landselling.Online_land_sales_portal.entity.PaymentPlan;
import com.landselling.Online_land_sales_portal.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PaymentPlanRepository extends JpaRepository<PaymentPlan, Long> {

    @Query("SELECT p FROM PaymentPlan p " +
            "LEFT JOIN FETCH p.land l " +
            "LEFT JOIN FETCH l.seller " +
            "ORDER BY p.createdAt DESC")
    List<PaymentPlan> findAllPaymentPlansWithLand();

    @Query("SELECT p FROM PaymentPlan p " +
            "LEFT JOIN FETCH p.land l " +
            "LEFT JOIN FETCH l.seller " +
            "WHERE p.id = :id")
    Optional<PaymentPlan> findPaymentPlanByIdWithLand(@Param("id") Long id);


    @Query("SELECT p FROM PaymentPlan p " +
            "LEFT JOIN FETCH p.land l " +
            "LEFT JOIN FETCH l.seller " +
            "WHERE p.id = :id AND l.seller.id = :sellerId")
    Optional<PaymentPlan> findByIdAndSellerId(@Param("id") Long id, @Param("sellerId") Long sellerId);

    @Query("SELECT p FROM PaymentPlan p " +
            "LEFT JOIN FETCH p.land l " +
            "LEFT JOIN FETCH l.seller " +
            "WHERE p.id = :id")
    Optional<PaymentPlan> findByIdWithLand(@Param("id") Long id);

    List<PaymentPlan> findByLandSellerIdOrderByCreatedAtDesc(Long sellerId);

    @Query("SELECT p FROM PaymentPlan p LEFT JOIN FETCH p.land l LEFT JOIN FETCH l.seller WHERE p.land.id = :landId")
    List<PaymentPlan> findByLandIdWithDetails(@Param("landId") Long landId);


    long countPaymentPlanByLand_SellerId(Long landSellerId);
}
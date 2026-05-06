package com.landselling.Online_land_sales_portal.Repository;

import com.landselling.Online_land_sales_portal.entity.Review;
import com.landselling.Online_land_sales_portal.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    
    // Find all reviews for a specific seller
    List<Review> findBySellerOrderByCreatedAtDesc(User seller);
    
    // Find all reviews for a specific seller with reviewer eagerly loaded
    @Query("SELECT r FROM Review r JOIN FETCH r.reviewer WHERE r.seller = :seller ORDER BY r.createdAt DESC")
    List<Review> findBySellerWithReviewerOrderByCreatedAtDesc(@Param("seller") User seller);
    
    // Find all reviews written by a specific reviewer and fetch the seller to avoid lazy init problems in views
    @Query("SELECT r FROM Review r JOIN FETCH r.seller WHERE r.reviewer = :reviewer ORDER BY r.createdAt DESC")
    List<Review> findByReviewerOrderByCreatedAtDesc(@Param("reviewer") User reviewer);
    
    // Calculate average rating for a seller
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.seller = :seller")
    Double getAverageRatingForSeller(@Param("seller") User seller);
    
    // Check if a user has already reviewed a seller
    boolean existsByReviewerAndSeller(User reviewer, User seller);
    
    // Delete review by ID and reviewer (for security)
    void deleteByIdAndReviewer(Long id, User reviewer);

    // Fetch a review by id and join fetch seller and reviewer to avoid lazy init in views
    @Query("SELECT r FROM Review r JOIN FETCH r.seller JOIN FETCH r.reviewer WHERE r.id = :id")
    java.util.Optional<Review> findByIdWithSellerAndReviewer(@Param("id") Long id);
}
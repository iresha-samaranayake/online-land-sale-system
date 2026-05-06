package com.landselling.Online_land_sales_portal.Repository;

import com.landselling.Online_land_sales_portal.entity.Land;
import com.landselling.Online_land_sales_portal.entity.LandImage;
import com.landselling.Online_land_sales_portal.entity.LandStatus;
import com.landselling.Online_land_sales_portal.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LandRepository extends JpaRepository<Land, Long> {

    List<Land> findBySeller(User seller);
    List<Land> findBySellerId(Long sellerId);


    Optional<Land> findByIdAndSeller(Long id, User seller); // Changed from user to seller

    @Query("SELECT l FROM Land l JOIN FETCH l.seller WHERE l.status = :status")
    List<Land> findByStatusWithSeller(@Param("status") LandStatus status);

    List<Land> findByStatus(LandStatus status);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status")
    List<Land> findByStatusWithImages(@Param("status") LandStatus status);

    List<Land> findByStatusOrderByCreatedAtDesc(LandStatus status);

    List<Land> findBySellerOrderByCreatedAtDesc(User seller);

    List<Land> findByStatusOrderByCreatedAtAsc(LandStatus status);

    List<Land> findByLocationContainingIgnoreCase(String location);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status AND LOWER(l.location) LIKE LOWER(CONCAT('%', :location, '%'))")
    List<Land> findAvailableByLocationWithImages(@Param("status") LandStatus status, @Param("location") String location);

    @Query("SELECT l FROM Land l WHERE l.status = :status AND l.price BETWEEN :minPrice AND :maxPrice ORDER BY l.price ASC")
    List<Land> findByPriceRange(@Param("status") LandStatus status, @Param("minPrice") java.math.BigDecimal minPrice, @Param("maxPrice") java.math.BigDecimal maxPrice);

    long countByStatus(LandStatus status);

    long countBySeller(User seller);

    @Query("SELECT l FROM Land l WHERE l.seller = :seller AND l.status = :status ORDER BY l.createdAt DESC")
    List<Land> findBySellerAndStatusOrderByCreatedAtDesc(@Param("seller") User seller, @Param("status") LandStatus status);

    @Query("SELECT li FROM LandImage li JOIN li.land l WHERE li.id = :imageId AND l.seller = :seller")
    Optional<LandImage> findImageByIdAndSeller(@Param("imageId") Long imageId, @Param("seller") User seller);

    //For payement plans


    List<Land> findBySellerIdOrderByCreatedAtDesc(Long sellerId);

    List<Land> findBySellerIdAndStatusOrderByCreatedAtDesc(Long sellerId, LandStatus status);

    @Query("SELECT l FROM Land l LEFT JOIN FETCH l.seller WHERE l.id = :id")
    Optional<Land> findByIdWithSeller(@Param("id") Long id);

    // Sorting methods for available lands
    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status ORDER BY l.price ASC")
    List<Land> findAvailableLandsSortedByPriceAsc(@Param("status") LandStatus status, @Param("location") String location);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status ORDER BY l.price DESC")
    List<Land> findAvailableLandsSortedByPriceDesc(@Param("status") LandStatus status, @Param("location") String location);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status ORDER BY l.createdAt DESC")
    List<Land> findAvailableLandsSortedByNewest(@Param("status") LandStatus status, @Param("location") String location);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status ORDER BY l.createdAt ASC")
    List<Land> findAvailableLandsSortedByOldest(@Param("status") LandStatus status, @Param("location") String location);

    // Sorting methods with location filter
    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status AND (:location IS NULL OR LOWER(l.location) LIKE LOWER(CONCAT('%', :location, '%'))) ORDER BY l.price ASC")
    List<Land> findAvailableLandsSortedByPriceAscWithLocation(@Param("status") LandStatus status, @Param("location") String location);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status AND (:location IS NULL OR LOWER(l.location) LIKE LOWER(CONCAT('%', :location, '%'))) ORDER BY l.price DESC")
    List<Land> findAvailableLandsSortedByPriceDescWithLocation(@Param("status") LandStatus status, @Param("location") String location);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status AND (:location IS NULL OR LOWER(l.location) LIKE LOWER(CONCAT('%', :location, '%'))) ORDER BY l.createdAt DESC")
    List<Land> findAvailableLandsSortedByNewestWithLocation(@Param("status") LandStatus status, @Param("location") String location);

    @Query("SELECT l FROM Land l JOIN FETCH l.images WHERE l.status = :status AND (:location IS NULL OR LOWER(l.location) LIKE LOWER(CONCAT('%', :location, '%'))) ORDER BY l.createdAt ASC")
    List<Land> findAvailableLandsSortedByOldestWithLocation(@Param("status") LandStatus status, @Param("location") String location);

}
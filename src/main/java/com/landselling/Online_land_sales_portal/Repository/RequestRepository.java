package com.landselling.Online_land_sales_portal.Repository;

import com.landselling.Online_land_sales_portal.entity.Land;
import com.landselling.Online_land_sales_portal.entity.Request;
import com.landselling.Online_land_sales_portal.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RequestRepository extends JpaRepository<Request, Long> {

    // Find all requests for a specific land
    List<Request> findByLand(Land land);

    // Find all requests made by a specific user (with eager fetching)
    @Query("SELECT r FROM Request r " +
           "JOIN FETCH r.land l " +
           "JOIN FETCH l.seller " +
           "JOIN FETCH r.requester " +
           "LEFT JOIN FETCH r.processedBy " +
           "WHERE r.requester = :requester " +
           "ORDER BY r.createdAt DESC")
    List<Request> findByRequester(@Param("requester") User requester);

    // Find all requests for lands owned by a specific seller (with eager fetching)
    @Query("SELECT r FROM Request r " +
           "JOIN FETCH r.land l " +
           "JOIN FETCH l.seller " +
           "JOIN FETCH r.requester " +
           "LEFT JOIN FETCH r.processedBy " +
           "WHERE l.seller = :seller " +
           "ORDER BY r.createdAt DESC")
    List<Request> findByLandSeller(@Param("seller") User seller);

    // Find all pending requests for a seller's lands
    @Query("SELECT r FROM Request r WHERE r.land.seller = :seller AND r.status = 'PENDING' ORDER BY r.createdAt DESC")
    List<Request> findPendingRequestsByLandSeller(@Param("seller") User seller);

    // Find all requests ordered by creation date (with eager fetching for admin)
    @Query("SELECT r FROM Request r " +
           "JOIN FETCH r.land l " +
           "JOIN FETCH l.seller " +
           "JOIN FETCH r.requester " +
           "LEFT JOIN FETCH r.processedBy " +
           "ORDER BY r.createdAt DESC")
    List<Request> findAllByOrderByCreatedAtDesc();
}


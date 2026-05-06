package com.landselling.Online_land_sales_portal.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;
import java.time.LocalDate;

@Entity
@Table(name = "booking_requests")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookingRequest {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    // Foreign Key to Land
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "land_id", nullable = false, foreignKey = @ForeignKey(name = "FK_booking_land"))
    private Land land;
    
    // Foreign Key to User (Buyer)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "buyer_id", nullable = false, foreignKey = @ForeignKey(name = "FK_booking_buyer"))
    private User buyer;
    
    @Column(name = "preferred_date")
    private LocalDate preferredDate;
    
    @Column(name = "preferred_time")
    private String preferredTime;
    
    @Column(columnDefinition = "TEXT")
    private String message;
    
    @Column(name = "contact_phone", length = 20)
    private String contactPhone;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private BookingStatus status = BookingStatus.PENDING;
    
    @Column(name = "seller_response", columnDefinition = "TEXT")
    private String sellerResponse;
    
    @Column(name = "confirmed_date")
    private LocalDate confirmedDate;
    
    @Column(name = "confirmed_time")
    private String confirmedTime;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
}

enum BookingStatus {
    PENDING("Pending"),
    CONFIRMED("Confirmed"),
    REJECTED("Rejected"),
    COMPLETED("Completed"),
    CANCELLED("Cancelled");
    
    private final String displayName;
    
    BookingStatus(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}

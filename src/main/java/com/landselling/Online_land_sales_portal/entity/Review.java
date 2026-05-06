package com.landselling.Online_land_sales_portal.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import java.time.LocalDateTime;
import com.landselling.Online_land_sales_portal.validation.NoProfanity;

@Entity
@Table(name = "reviews")
@Data
public class Review {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seller_id", nullable = false)
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private User seller;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "land_id")
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private Land land;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reviewer_id", nullable = false)
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private User reviewer;
    
    @NotNull
    @Min(1)
    @Max(5)
    @Column(nullable = false)
    private Integer rating;
    
    @Size(max = 100)
    @Column(length = 100)
    @NoProfanity
    private String title;
    
    @Size(max = 1000)
    @Column(columnDefinition = "TEXT")
    @NoProfanity
    private String comment;
    
    @Column(name = "is_verified")
    private Boolean isVerified = false;
    
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}

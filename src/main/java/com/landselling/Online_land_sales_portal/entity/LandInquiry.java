package com.landselling.Online_land_sales_portal.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.time.LocalDateTime;

@Entity
@Table(name = "land_inquiries")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LandInquiry {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    // Foreign Key to Land
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "land_id", nullable = false, foreignKey = @ForeignKey(name = "FK_inquiry_land"))
    private Land land;
    
    // Foreign Key to User (Inquirer)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inquirer_id", nullable = false, foreignKey = @ForeignKey(name = "FK_inquiry_inquirer"))
    private User inquirer;
    
    @Column(nullable = false, length = 100)
    private String subject;
    
    @Column(nullable = false, columnDefinition = "TEXT")
    private String message;
    
    @Column(name = "contact_phone", length = 20)
    private String contactPhone;
    
    @Column(name = "contact_email")
    private String contactEmail;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private InquiryStatus status = InquiryStatus.PENDING;
    
    @Column(name = "seller_response", columnDefinition = "TEXT")
    private String sellerResponse;
    
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

enum InquiryStatus {
    PENDING("Pending"),
    RESPONDED("Responded"),
    CLOSED("Closed");
    
    private final String displayName;
    
    InquiryStatus(String displayName) {
        this.displayName = displayName;
    }
    
    public String getDisplayName() {
        return displayName;
    }
}
package com.landselling.Online_land_sales_portal.entity; // Standardized lowercase; adjust to match project

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.time.LocalDateTime;

@Entity
@Table(name = "land_images")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LandImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "land_id", nullable = false, foreignKey = @ForeignKey(name = "FK_image_land"))
    @EqualsAndHashCode.Exclude  // Prevent recursion in equals/hashCode
    @ToString.Exclude  // Prevent recursion in toString
    private Land land;

    @Column(nullable = false, length = 255)  // Increased length for safety (e.g., long paths/URLs)
    private String imageUrl;

    @Column(length = 100)
    private String imageName;

    @Column(name = "is_primary")
    private Boolean isPrimary = false;

    @Column(name = "upload_date", updatable = false)  // Make immutable after creation
    private LocalDateTime uploadDate;

    @PrePersist
    protected void onCreate() {
        uploadDate = LocalDateTime.now();
    }
}
package com.landselling.Online_land_sales_portal.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "promotions")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Promotion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "listing_id", nullable = true)
    private Land listing;

    @Enumerated(EnumType.STRING)
    @Column(name = "banner_type", nullable = false)
    private BannerType bannerType;

    @Column(name = "discount_percentage", nullable = false)
    private BigDecimal discountPercentage;

    @Column(name = "duration", nullable = false)
    private int duration;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;

    @Column(name = "cost", nullable = false, precision = 10, scale = 2)
    private BigDecimal cost;

    @ManyToOne
    @JoinColumn(name = "seller_id", nullable = false)
    private User seller;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = Boolean.TRUE;

    @Override
    public String toString() {
        return "Promotion{" +
                "id=" + id +
                ", bannerType=" + bannerType +
                ", discountPercentage=" + discountPercentage +
                ", duration=" + duration +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", cost=" + cost +
                ", isActive=" + isActive +
                '}';
    }

    public Promotion(Land listing, User seller, BannerType bannerType, int discount, int duration, LocalDate startDate, LocalDate endDate, BigDecimal cost) {
        this.listing = listing;
        this.seller = seller;
        this.bannerType = bannerType;
        this.discountPercentage = BigDecimal.valueOf(discount);
        this.duration = duration;
        this.startDate = startDate;
        this.endDate = endDate;
        this.cost = cost;
        this.isActive = Boolean.TRUE;
    }
}
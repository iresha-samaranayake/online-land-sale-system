package com.landselling.Online_land_sales_portal.dto;

import com.landselling.Online_land_sales_portal.entity.LandStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class PayemtLandDto {
    private Long id;
    private String title;
    private String description;
    private BigDecimal price;
    private BigDecimal size;
    private String location;
    private LandStatus status;
    private String sellerName;
    private LocalDateTime createdAt;
    private List<String> imageUrls;

    public PayemtLandDto(Long id, String title, String description, BigDecimal price,
                   BigDecimal size, String location, LandStatus status,
                   String sellerName, LocalDateTime createdAt, List<String> imageUrls) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.price = price;
        this.size = size;
        this.location = location;
        this.status = status;
        this.sellerName = sellerName;
        this.createdAt = createdAt;
        this.imageUrls = imageUrls;

    }
}

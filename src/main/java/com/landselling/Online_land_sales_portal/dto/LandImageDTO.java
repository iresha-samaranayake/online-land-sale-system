package com.landselling.Online_land_sales_portal.dto;

import lombok.Data;

@Data
public class LandImageDTO {
    private Long id;
    private String imageUrl;
    private String imageName;
    private Boolean isPrimary;
}


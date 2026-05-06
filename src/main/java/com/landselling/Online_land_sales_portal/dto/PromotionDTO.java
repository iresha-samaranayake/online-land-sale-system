package com.landselling.Online_land_sales_portal.dto;

import jakarta.validation.constraints.*;

public class PromotionDTO {

    @NotNull(message = "Listing ID is required")
    private Long listingId;

    @NotNull(message = "Banner type is required")
    @Pattern(regexp = "GOLD|SILVER|BRONZE", message = "Invalid banner type")
    private String bannerType;

    @Min(value = 0, message = "Discount must be at least 0")
    @Max(value = 50, message = "Discount cannot exceed 50")
    private int discount;

    @Positive(message = "Duration must be positive")
    private int duration;

    // Getters and Setters
    public Long getListingId() {
        return listingId;
    }

    public void setListingId(Long listingId) {
        this.listingId = listingId;
    }

    public String getBannerType() {
        return bannerType;
    }

    public void setBannerType(String bannerType) {
        this.bannerType = bannerType;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }
}
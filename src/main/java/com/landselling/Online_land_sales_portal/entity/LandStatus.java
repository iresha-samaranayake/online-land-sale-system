package com.landselling.Online_land_sales_portal.entity;

public enum LandStatus {
    PENDING("Pending"),
    AVAILABLE("Available"),
    REJECTED("Rejected");

    private final String displayName;

    LandStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}

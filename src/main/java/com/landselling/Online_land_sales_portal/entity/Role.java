package com.landselling.Online_land_sales_portal.entity;

public enum Role {
    ADMIN("Admin"),
    BUYER("Buyer"),
    SELLER("Seller"),
    STAFF("Staff");

    private final String displayName;

    Role(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
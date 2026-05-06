package com.landselling.Online_land_sales_portal.entity;

public enum RequestType {
    RESERVE("Reserve"),
    PURCHASE("Purchase");

    private final String displayName;

    RequestType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}


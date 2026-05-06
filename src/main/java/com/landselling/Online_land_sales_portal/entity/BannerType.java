package com.landselling.Online_land_sales_portal.entity;

public enum BannerType {
    GOLD(1, new java.math.BigDecimal("5000")),
    SILVER(2, new java.math.BigDecimal("3000")),
    BRONZE(3, new java.math.BigDecimal("1000"));

    private final int priority;
    private final java.math.BigDecimal baseCost;

    BannerType(int priority, java.math.BigDecimal baseCost) {
        this.priority = priority;
        this.baseCost = baseCost;
    }

    public int getPriority() {
        return priority;
    }

    public java.math.BigDecimal getBaseCost() {
        return baseCost;
    }
}
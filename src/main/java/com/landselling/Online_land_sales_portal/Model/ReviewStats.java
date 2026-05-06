package com.landselling.Online_land_sales_portal.Model;

/**
 * Represents statistics about reviews for display in the dashboard
 */
public class ReviewStats {
    private int totalReviews;
    private double averageRating;

    public ReviewStats() {
        this.totalReviews = 0;
        this.averageRating = 0.0;
    }

    public int getTotalReviews() {
        return totalReviews;
    }

    public void setTotalReviews(int totalReviews) {
        this.totalReviews = totalReviews;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public String getFormattedAverageRating() {
        if (totalReviews == 0) {
            return "N/A";
        }
        return String.format("%.1f", averageRating);
    }
}
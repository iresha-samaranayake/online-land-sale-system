
package com.landselling.Online_land_sales_portal.Service;

import com.landselling.Online_land_sales_portal.entity.BannerType;
import com.landselling.Online_land_sales_portal.entity.Land;
import com.landselling.Online_land_sales_portal.entity.Promotion;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.entity.LandStatus;
import com.landselling.Online_land_sales_portal.Repository.LandRepository;
import com.landselling.Online_land_sales_portal.Repository.PromotionRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jakarta.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for managing promotions in the online land sales portal.
 */
@Service
public class PromotionService {

    private static final Logger logger = LoggerFactory.getLogger(PromotionService.class);

    @Autowired
    private LandRepository landRepository;

    @Autowired
    private PromotionRepository promotionRepository;

    /**
     * Retrieves approved listings for the logged-in seller.
     *
     * @param session HTTP session containing the logged-in user
     * @return List of approved lands owned by the seller
     * @throws IllegalStateException if no user is logged in
     */
    @Transactional(readOnly = true)
    public List<Land> getApprovedListingsForSeller(HttpSession session) {
        User seller = (User) session.getAttribute("loggedInUser");
        if (seller == null) {
            logger.error("No logged-in user found in session for getApprovedListingsForSeller");
            throw new IllegalStateException("No logged-in user found in session");
        }
        return landRepository.findBySellerAndStatusOrderByCreatedAtDesc(seller, LandStatus.AVAILABLE);
    }

    /**
     * Retrieves a land listing by its ID.
     *
     * @param id The ID of the listing
     * @return The land entity
     * @throws IllegalArgumentException if the listing is not found
     */
    @Transactional(readOnly = true)
    public Land getListingById(Long id) {
        return landRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Listing not found"));
    }

    /**
     * Retrieves the promotion associated with a listing.
     *
     * @param listing The land listing
     * @return The promotion, or null if none exists
     */
    @Transactional(readOnly = true)
    public Promotion getPromotionByListing(Land listing) {
        return promotionRepository.findByListing(listing);
    }

    /**
     * Saves or updates a promotion for a listing.
     *
     * @param listingId  The ID of the listing to promote
     * @param bannerType The type of banner (GOLD, SILVER, BRONZE)
     * @param discount   The discount percentage (0-50)
     * @param duration   The duration of the promotion in days
     * @param session    HTTP session containing the logged-in user
     * @throws IllegalStateException if no user is logged in or listing is not approved
     * @throws SecurityException if the user does not own the listing
     * @throws IllegalArgumentException if inputs are invalid
     */
    @Transactional
    public void savePromotion(Long listingId, String bannerType, int discount, int duration, HttpSession session) {
        Land listing = getListingById(listingId);
        User seller = (User) session.getAttribute("loggedInUser");
        if (seller == null) {
            logger.error("No logged-in user found in session for savePromotion");
            throw new IllegalStateException("No logged-in user found in session");
        }
        if (!listing.getSeller().getId().equals(seller.getId())) {
            logger.warn("Unauthorized access attempt to listing ID {} by user ID {}", listingId, seller.getId());
            throw new SecurityException("Unauthorized access to listing");
        }
        if (listing.getStatus() != LandStatus.AVAILABLE) {
            logger.error("Listing ID {} is not approved for promotion", listingId);
            throw new IllegalStateException("Listing is not approved");
        }

        if (discount < 0 || discount > 50) {
            logger.error("Invalid discount {} for listing ID {}", discount, listingId);
            throw new IllegalArgumentException("Discount must be between 0 and 50");
        }

        BannerType banner;
        try {
            banner = BannerType.valueOf(bannerType);
        } catch (IllegalArgumentException e) {
            logger.error("Invalid banner type {} for listing ID {}", bannerType, listingId);
            throw new IllegalArgumentException("Invalid banner type");
        }

        Promotion promotion = promotionRepository.findByListing(listing);
        LocalDate startDate = LocalDate.now();
        LocalDate endDate = startDate.plusDays(duration);
        BigDecimal cost = calculateCost(banner, duration, discount);

        if (promotion == null) {
            promotion = new Promotion(listing, seller, banner, discount, duration, startDate, endDate, cost);
        } else {
            promotion.setBannerType(banner);
            promotion.setDiscountPercentage(BigDecimal.valueOf(discount));
            promotion.setDuration(duration);
            promotion.setStartDate(startDate);
            promotion.setEndDate(endDate);
            promotion.setCost(cost);
        }

        listing.setPromoted(Boolean.TRUE);
        landRepository.save(listing);
        promotionRepository.save(promotion);
        logger.info("Saved promotion for listing ID {} with banner type {}, duration {}, cost {}", listingId, banner, duration, cost);
    }

    /**
     * Deletes a promotion for a listing.
     *
     * @param listingId The ID of the listing
     * @param seller    The logged-in user
     * @throws IllegalStateException if no user is provided
     * @throws SecurityException if the user does not own the listing
     */
    @Transactional
    public void deletePromotion(Long listingId, User seller) {
        Land listing = getListingById(listingId);
        if (seller == null) {
            logger.error("No user provided for deletePromotion of listing ID {}", listingId);
            throw new IllegalStateException("No user provided");
        }
        if (!listing.getSeller().getId().equals(seller.getId())) {
            logger.warn("Unauthorized delete attempt for listing ID {} by user ID {}", listingId, seller.getId());
            throw new SecurityException("Unauthorized access to listing");
        }
        Promotion promotion = promotionRepository.findByListing(listing);
        if (promotion != null) {
            listing.setPromoted(Boolean.FALSE);
            landRepository.save(listing);
            promotionRepository.delete(promotion);
            logger.info("Deleted promotion for listing ID {}", listingId);
        }
    }

    /**
     * Calculates the cost of a promotion based on banner type, duration, and discount.
     *
     * @param bannerType The type of banner
     * @param duration   The duration in days
     * @param discount   The discount percentage
     * @return The calculated cost
     */
    private BigDecimal calculateCost(BannerType bannerType, int duration, int discount) {
        BigDecimal baseCost = bannerType.getBaseCost();
        BigDecimal durationFactor = new BigDecimal(duration).divide(new BigDecimal("7"), 2, RoundingMode.HALF_UP);
        BigDecimal discountFactor = BigDecimal.ONE.subtract(new BigDecimal(discount).divide(new BigDecimal("100")));
        return baseCost.multiply(durationFactor).multiply(discountFactor);
    }

    /**
     * Retrieves all active promotions valid for the current date.
     *
     * @return List of active promotions
     */
    @Transactional(readOnly = true)
    public List<Promotion> getActivePromotions() {
        LocalDate current = LocalDate.now();
        logger.debug("Fetching active promotions for date: {}", current);
        List<Promotion> promotions = promotionRepository.findActivePromotions(current);
        promotions.forEach(p -> logger.debug("Found promotion ID: {}, start: {}, end: {}, active: {}, land status: {}",
                p.getId(), p.getStartDate(), p.getEndDate(), p.getIsActive(), p.getListing() != null ? p.getListing().getStatus() : "null"));
        logger.info("Total active promotions found: {}", promotions.size());
        return promotions;
    }

    /**
     * Retrieves active promotions with a limit.
     *
     * @param limit Maximum number of promotions to return
     * @return List of active promotions
     */
    @Transactional(readOnly = true)
    public List<Promotion> getActivePromotions(int limit) {
        List<Promotion> allActive = getActivePromotions();
        if (limit > 0 && allActive.size() > limit) {
            return allActive.stream().limit(limit).collect(Collectors.toList());
        }
        return allActive;
    }

    /**
     * Scheduled task to deactivate expired promotions daily at midnight.
     */
    @Scheduled(cron = "0 0 0 * * ?")
    @Transactional
    public void deactivateExpiredPromotions() {
        LocalDate current = LocalDate.now();
        logger.info("Running scheduled task to deactivate expired promotions for date: {}", current);
        List<Promotion> expiredPromotions = promotionRepository.findExpiredPromotions(current);
        for (Promotion promotion : expiredPromotions) {
            promotion.setIsActive(Boolean.FALSE);
            Land listing = promotion.getListing();
            if (listing != null) {
                listing.setPromoted(Boolean.FALSE);
                landRepository.save(listing);
            }
            promotionRepository.save(promotion);
            logger.info("Deactivated promotion ID {} for listing ID {}", promotion.getId(), listing != null ? listing.getId() : "null");
        }
        logger.info("Deactivated {} expired promotions", expiredPromotions.size());
    }
}

package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.LandService;
import com.landselling.Online_land_sales_portal.Service.PaymentPlanService;
import com.landselling.Online_land_sales_portal.Service.PromotionService;
import com.landselling.Online_land_sales_portal.entity.Promotion;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.entity.Role;
import com.landselling.Online_land_sales_portal.entity.Land;
import org.hibernate.Hibernate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.util.Comparator;
import java.util.List;

@Controller
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired
    private LandService landService;

    @Autowired
    private PaymentPlanService paymentPlanService;

    @Autowired
    private PromotionService promotionService;

    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        logger.info("Home controller accessed");
        model.addAttribute("title", "Online Land Sales System");
        model.addAttribute("message", "Welcome to our Land Sales Portal");

        // Add logged in user to model
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        model.addAttribute("loggedInUser", loggedInUser);

        return "index";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            logger.error("No logged-in user found in session");
            return "redirect:/login";
        }

        // Fetch real-time total available lands
        long totalAvailableLands = landService.getTotalAvailableLands();
        model.addAttribute("totalLands", totalAvailableLands);

        // Fetch featured promotions for all roles
        List<Promotion> featuredPromotions = promotionService.getActivePromotions();
        // Initialize images and log details
        for (Promotion promo : featuredPromotions) {
            if (promo != null && promo.getListing() != null) {
                Hibernate.initialize(promo.getListing().getImages());
                logger.info("Promotion ID: {}, Listing ID: {}, Title: {}, Banner: {}, Active: {}, Start: {}, End: {}, Land Status: {}",
                        promo.getId(),
                        promo.getListing().getId(),
                        promo.getListing().getTitle(),
                        promo.getBannerType(),
                        promo.getIsActive(),
                        promo.getStartDate(),
                        promo.getEndDate(),
                        promo.getListing().getStatus());
            } else {
                logger.warn("Null promotion or listing detected in featuredPromotions");
            }
        }
        model.addAttribute("featuredPromotions", featuredPromotions);
        logger.info("Fetched {} active promotions for user role: {}",
                featuredPromotions.size(), loggedInUser.getRole());
        logger.info("DEBUG: featuredPromotions is null? {}", featuredPromotions == null);
        if (featuredPromotions != null) {
            logger.info("DEBUG: featuredPromotions size: {}", featuredPromotions.size());
        }

        // Role-based dashboard data
        if (loggedInUser.getRole() == Role.ADMIN) {
            model.addAttribute("myBookings", 89);
            model.addAttribute("pendingPayments", paymentPlanService.getPayementPlanCount(loggedInUser.getId()));
            model.addAttribute("totalReviews", 423);
            BigDecimal totalRevenue = BigDecimal.ZERO;
            if (featuredPromotions != null && !featuredPromotions.isEmpty()) {
                totalRevenue = featuredPromotions.stream()
                        .filter(p -> p != null)
                        .map(Promotion::getCost)
                        .reduce(BigDecimal.ZERO, BigDecimal::add);
            }
            model.addAttribute("totalRevenue", totalRevenue);
        } else if (loggedInUser.getRole() == Role.SELLER) {
            model.addAttribute("myBookings", 23);
            model.addAttribute("pendingPayments", paymentPlanService.getPayementPlanCount(loggedInUser.getId()));
            model.addAttribute("totalReviews", 45);
            // Fetch latest approved land for seller
            Land latestApprovedLand = landService.getLatestApprovedLandBySeller(loggedInUser);
            model.addAttribute("latestApprovedLand", latestApprovedLand);
        } else if (loggedInUser.getRole() == Role.BUYER) {
            model.addAttribute("myBookings", 3);
            model.addAttribute("pendingPayments", 2);
            model.addAttribute("totalReviews", 8);
            // Sort promotions by BannerType priority (GOLD first)
            if (featuredPromotions != null && !featuredPromotions.isEmpty()) {
                featuredPromotions.sort(Comparator.comparingInt(promo -> promo.getBannerType().getPriority()));
            }
        } else {
            model.addAttribute("myBookings", 45);
            model.addAttribute("pendingPayments", paymentPlanService.getPayementPlanCount(loggedInUser.getId()));
            model.addAttribute("totalReviews", 123);
            BigDecimal totalRevenue = BigDecimal.ZERO;
            if (featuredPromotions != null && !featuredPromotions.isEmpty()) {
                totalRevenue = featuredPromotions.stream()
                        .filter(p -> p != null)
                        .map(Promotion::getCost)
                        .reduce(BigDecimal.ZERO, BigDecimal::add);
            }
            model.addAttribute("totalRevenue", totalRevenue);
        }

        model.addAttribute("loggedInUser", loggedInUser);
        return "dashboard";
    }

    @GetMapping("/about")
    public String about(Model model) {
        return "about";
    }

    @GetMapping("/contact")
    public String contact(Model model) {
        return "contact";
    }

    @GetMapping("/test")
    public String test() {
        return "Test endpoint works!";
    }
}
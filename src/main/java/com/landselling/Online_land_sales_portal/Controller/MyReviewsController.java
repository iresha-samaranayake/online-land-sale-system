package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.ReviewService;
import com.landselling.Online_land_sales_portal.entity.Review;
import com.landselling.Online_land_sales_portal.entity.Role;
import com.landselling.Online_land_sales_portal.entity.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/my-reviews")
public class MyReviewsController {

    @Autowired
    private ReviewService reviewService;

    @GetMapping
    public String showMyReviews(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to view your reviews");
            return "redirect:/login";
        }
        
        if (currentUser.getRole() != Role.BUYER) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Only buyers can view their reviews.");
            return "redirect:/dashboard";
        }

        List<Review> reviews = reviewService.getReviewsByReviewer(currentUser);
        model.addAttribute("reviews", reviews);
        model.addAttribute("loggedInUser", currentUser); // Add this for role-based UI controls
        
        return "my-reviews";
    }
}
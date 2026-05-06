package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.ReviewService;
import com.landselling.Online_land_sales_portal.entity.Review;
import com.landselling.Online_land_sales_portal.entity.Role;
import com.landselling.Online_land_sales_portal.entity.User;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    // NOTE: `MyReviewsController` serves GET /my-reviews. Keep ReviewController focused on POST actions.

    @PostMapping("/create/{sellerId}")
    public String createReview(@PathVariable Long sellerId,
                          @ModelAttribute @Valid Review review,
                          BindingResult bindingResult,
                          @RequestParam(name = "landId", required = false) Long landId,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        System.out.println("Creating review - sellerId: " + sellerId + ", rating: " + review.getRating() + ", title: " + review.getTitle());
        
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to submit a review");
            return "redirect:/login";
        }
        
        if (currentUser.getRole() != Role.BUYER) {
            redirectAttributes.addFlashAttribute("error", "Only buyers can submit reviews");
            return "redirect:/lands";
        }

        if (bindingResult.hasErrors()) {
            // Keep the form data
            redirectAttributes.addFlashAttribute("review", review);
            // Add validation error message
            redirectAttributes.addFlashAttribute("error", "Harassment or inappropriate language is not allowed.");
            // Return to the land details page
            return "redirect:/lands/details/" + landId;
        }

        try {
            if (sellerId == null) {
                throw new IllegalArgumentException("Invalid seller ID");
            }

            System.out.println("Current user ID: " + currentUser.getId() + ", seller ID: " + sellerId);

            Review savedReview = reviewService.createReview(review, sellerId, currentUser, landId);
            System.out.println("Review saved successfully with ID: " + savedReview.getId());
            redirectAttributes.addFlashAttribute("success", "Review submitted successfully");
            return "redirect:/lands/details/" + landId;
            
        } catch (Exception e) {
            System.out.println("Error creating review: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Error submitting review: " + e.getMessage());
            return "redirect:/my-reviews";
        }
    }

    @PostMapping("/edit/{id}")
    public String editReview(@PathVariable Long id,
                           @RequestParam("rating") int rating,
                           @RequestParam("title") String title,
                           @RequestParam("comment") String comment,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            System.out.println("[ReviewController] editReview - no logged in user in session");
            redirectAttributes.addFlashAttribute("error", "Please log in to update review");
            return "redirect:/login";
        }

        if (currentUser.getRole() != Role.BUYER) {
            System.out.println("[ReviewController] editReview - unauthorized role: " + currentUser.getRole());
            redirectAttributes.addFlashAttribute("error", "Only buyers can edit reviews");
            return "redirect:/lands";
        }

        try {
            System.out.println("[ReviewController] editReview - userId=" + currentUser.getId() + ", reviewId=" + id + ", rating=" + rating);
            Review updatedReview = new Review();
            updatedReview.setRating(rating);
            updatedReview.setTitle(title);
            updatedReview.setComment(comment);

            reviewService.updateReview(id, updatedReview, currentUser);
            redirectAttributes.addFlashAttribute("success", "Review updated successfully");
            return "redirect:/my-reviews";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error updating review: " + e.getMessage());
            return "redirect:/my-reviews";
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteReview(@PathVariable Long id,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            System.out.println("[ReviewController] deleteReview - no logged in user in session");
            redirectAttributes.addFlashAttribute("error", "Please log in to delete review");
            return "redirect:/login";
        }

        if (currentUser.getRole() != Role.BUYER && currentUser.getRole() != Role.ADMIN) {
            System.out.println("[ReviewController] deleteReview - unauthorized role: " + currentUser.getRole());
            redirectAttributes.addFlashAttribute("error", "Only buyers and admins can delete reviews");
            return "redirect:/lands";
        }

        try {
            Review review = reviewService.findById(id);
            if (review == null) {
                System.out.println("[ReviewController] deleteReview - review not found id=" + id);
                redirectAttributes.addFlashAttribute("error", "Review not found");
                return "redirect:/dashboard";
            }

            Long sellerId = review.getSeller().getId();
            
            // Only allow delete if user is the reviewer or an admin
            if (!review.getReviewer().getId().equals(currentUser.getId()) && currentUser.getRole() != Role.ADMIN) {
                System.out.println("[ReviewController] deleteReview - unauthorized. userId=" + currentUser.getId() + ", reviewerId=" + review.getReviewer().getId());
                redirectAttributes.addFlashAttribute("error", "You can only delete your own reviews");
                return "redirect:/profile/" + sellerId;
            }

            System.out.println("[ReviewController] deleteReview - userId=" + currentUser.getId() + ", reviewId=" + id);
            reviewService.deleteReview(id, currentUser);
            redirectAttributes.addFlashAttribute("success", "Review deleted successfully");
            return "redirect:/my-reviews";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting review: " + e.getMessage());
            return "redirect:/my-reviews";
        }
    }
}
package com.landselling.Online_land_sales_portal.Service;

import com.landselling.Online_land_sales_portal.Repository.ReviewRepository;
import com.landselling.Online_land_sales_portal.Repository.UserRepository;
import com.landselling.Online_land_sales_portal.entity.Review;
import com.landselling.Online_land_sales_portal.entity.Role;
import com.landselling.Online_land_sales_portal.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private com.landselling.Online_land_sales_portal.Repository.LandRepository landRepository;

    @Transactional(readOnly = true)
    public List<Review> getReviewsByReviewer(User reviewer) {
        return reviewRepository.findByReviewerOrderByCreatedAtDesc(reviewer);
    }

    @Transactional(readOnly = true)
    public List<Review> getReviewsForSeller(User seller) {
        return reviewRepository.findBySellerWithReviewerOrderByCreatedAtDesc(seller);
    }

    @Transactional(readOnly = true)
    public Double getAverageRatingForSeller(User seller) {
        return reviewRepository.getAverageRatingForSeller(seller);
    }

    @Transactional
    public Review createReview(Review review, Long sellerId, User reviewer, Long landId) {
        if (reviewer == null) {
            throw new IllegalStateException("You must be logged in to write a review");
        }

        if (reviewer.getRole() != Role.BUYER) {
            throw new IllegalStateException("Only buyers can write reviews");
        }

        User seller = userRepository.findById(sellerId)
                .orElseThrow(() -> new IllegalArgumentException("Seller not found"));

        if (seller.getRole() != Role.SELLER) {
            throw new IllegalStateException("Reviews can only be written for sellers");
        }

        if (reviewer.equals(seller)) {
            throw new IllegalStateException("Sellers cannot review themselves");
        }

        if (reviewRepository.existsByReviewerAndSeller(reviewer, seller)) {
            throw new IllegalStateException("You have already reviewed this seller");
        }

        review.setSeller(seller);
        if (landId != null) {
            com.landselling.Online_land_sales_portal.entity.Land land =
                    landRepository.findById(landId).orElse(null);
            review.setLand(land);
        }
        review.setReviewer(reviewer);
        try {
            System.out.println("[ReviewService] Saving review: reviewerId=" + reviewer.getId()
                    + ", sellerId=" + seller.getId() + ", rating=" + review.getRating()
                    + ", title=" + review.getTitle());

            review = reviewRepository.save(review);
            // force flush to execute SQL immediately and surface DB errors
            reviewRepository.flush();

            System.out.println("[ReviewService] Review saved with id=" + review.getId());
        } catch (Exception ex) {
            System.out.println("[ReviewService] Error saving review: " + ex.getMessage());
            ex.printStackTrace();
            throw ex;
        }

        // Update seller's average rating
        updateSellerRating(seller);

        return review;
    }

    @Transactional
    public Review updateReview(Long id, Review updatedReview, User reviewer) {
        // Load review with seller and reviewer to avoid lazy-init and to check ownership safely
        Review existingReview = reviewRepository.findByIdWithSellerAndReviewer(id)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        if (existingReview.getReviewer() == null) {
            throw new IllegalStateException("Review has no reviewer assigned");
        }

        if (reviewer.getRole() != Role.BUYER) {
            throw new IllegalStateException("Only buyers can update reviews");
        }

        // Compare by id to avoid potential equals() issues from detached/proxy objects
        if (!existingReview.getReviewer().getId().equals(reviewer.getId())) {
            throw new IllegalStateException("You can only update your own reviews");
        }

        existingReview.setRating(updatedReview.getRating());
        existingReview.setTitle(updatedReview.getTitle());
        existingReview.setComment(updatedReview.getComment());

        try {
            System.out.println("[ReviewService] Updating review id=" + id + ", reviewerId=" + reviewer.getId()
                    + ", newRating=" + updatedReview.getRating());

            Review saved = reviewRepository.save(existingReview);
            // force flush to execute SQL immediately and surface DB errors
            reviewRepository.flush();

            System.out.println("[ReviewService] Review updated id=" + saved.getId());

            // Update seller's average rating
            updateSellerRating(existingReview.getSeller());

            return saved;
        } catch (Exception ex) {
            System.out.println("[ReviewService] Error updating review: " + ex.getMessage());
            ex.printStackTrace();
            throw ex;
        }
    }

    @Transactional
    public void deleteReview(Long id, User reviewer) {
        // Load with seller and reviewer to check ownership and update rating
        Review review = reviewRepository.findByIdWithSellerAndReviewer(id)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        if (review.getReviewer() == null) {
            throw new IllegalStateException("Review has no reviewer assigned");
        }

        // Allow deletion if user is a buyer (owns the review) or admin
        if (reviewer.getRole() != Role.BUYER && reviewer.getRole() != Role.ADMIN) {
            throw new IllegalStateException("Only buyers and admins can delete reviews");
        }

        // If user is not an admin, verify they own the review
        if (reviewer.getRole() != Role.ADMIN && !review.getReviewer().getId().equals(reviewer.getId())) {
            throw new IllegalStateException("You can only delete your own reviews");
        }

        User seller = review.getSeller();

        try {
            System.out.println("[ReviewService] Deleting review id=" + id + ", requestedBy=" + reviewer.getId());

            // Allow deletion if the requester is the reviewer or an admin
            if (review.getReviewer().getId().equals(reviewer.getId())) {
                reviewRepository.deleteByIdAndReviewer(id, reviewer);
            } else if (reviewer.getRole() == Role.ADMIN) {
                // Admin can delete any review
                reviewRepository.deleteById(id);
            } else {
                throw new IllegalStateException("You can only delete your own reviews");
            }

            // force flush to execute SQL immediately and surface DB errors
            reviewRepository.flush();
            System.out.println("[ReviewService] Deleted review id=" + id);

            // Update seller's average rating
            updateSellerRating(seller);
        } catch (Exception ex) {
            System.out.println("[ReviewService] Error deleting review: " + ex.getMessage());
            ex.printStackTrace();
            throw ex;
        }
    }

    @Transactional
    public void updateSellerRating(User seller) {
        Double avgRating = reviewRepository.getAverageRatingForSeller(seller);
        seller.setAverageRating(avgRating);
        userRepository.save(seller);
    }

    @Transactional(readOnly = true)
    public boolean hasUserReviewedSeller(User reviewer, User seller) {
        return reviewRepository.existsByReviewerAndSeller(reviewer, seller);
    }

    @Transactional(readOnly = true)
    public Review findById(Long id) {
        // Use a fetch-join to ensure related entities (seller/reviewer) are available outside the
        // transactional boundary, avoiding LazyInitializationException in controllers/views.
        return reviewRepository.findByIdWithSellerAndReviewer(id)
                .orElseThrow(() -> new RuntimeException("Review not found"));
    }
}
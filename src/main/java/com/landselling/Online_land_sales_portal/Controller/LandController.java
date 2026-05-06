package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.dto.LandDTO;
import com.landselling.Online_land_sales_portal.entity.Land;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.entity.Role;
import com.landselling.Online_land_sales_portal.entity.Review;
import com.landselling.Online_land_sales_portal.Service.LandService;
import com.landselling.Online_land_sales_portal.Service.UserService;
import com.landselling.Online_land_sales_portal.Service.ReviewService;
import com.landselling.Online_land_sales_portal.Util.ValidationUtil;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.http.ResponseEntity;
import jakarta.servlet.http.HttpSession;

import java.util.List;

@Controller
@RequestMapping("/lands")
public class LandController {

    @Autowired
    private LandService landService;

    @Autowired
    private UserService userService;

    @Autowired
    private ReviewService reviewService;

    @GetMapping
    public String listLands(@RequestParam(value = "location", required = false) String location,
                           @RequestParam(value = "sortBy", required = false) String sortBy,
                           Model model) {
        List<Land> lands = landService.searchAvailableLandsByLocationAndSort(location, sortBy);
        model.addAttribute("lands", lands);
        model.addAttribute("message", "Browse Available Lands");
        model.addAttribute("location", location);
        model.addAttribute("sortBy", sortBy);
        return "lands";
    }

    @GetMapping("/post")
    public String showPostForm(Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Sellers only.");
            return "redirect:/login";
        }
        model.addAttribute("landDTO", new LandDTO());
        return "post-land";
    }

    @PostMapping("/post")
    public String postLand(@Valid @ModelAttribute("landDTO") LandDTO landDTO, BindingResult bindingResult,
            HttpSession session, RedirectAttributes redirectAttributes, Model model) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null || currentUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        System.out.println("Received POST request with landDTO: " + landDTO); // Add logging
        System.out.println("Price received: " + landDTO.getPrice()); // Specific price log
        if (bindingResult.hasErrors() || !ValidationUtil.isValidImages(landDTO.getImages())) {
            System.out.println("Validation failed: " + bindingResult.getAllErrors());
            redirectAttributes.addFlashAttribute("error", "Invalid input or images");
            return "redirect:/lands/post";
        }
        try {
            landService.saveLand(landDTO, currentUser);
            redirectAttributes.addFlashAttribute("successMessage", "Land Listing Submitted Successfully!");
            return "redirect:/lands/my-posts";
        } catch (Exception e) {
            System.out.println("Error saving post: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Failed to save post: " + e.getMessage());
            return "redirect:/lands/post";
        }
    }

    @GetMapping("/my-posts")
    public String myPosts(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null || currentUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        List<Land> lands = landService.getLandsByUser(currentUser);
        System.out.println("Fetched lands for user " + currentUser.getEmail() + ": " + lands); // Debug log
        model.addAttribute("lands", lands);
        return "my-posts";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, HttpSession session, Model model,
            RedirectAttributes redirectAttributes) {
        Object sessionUser = session.getAttribute("loggedInUser");
        System.out.println("Session attribute 'loggedInUser': " + sessionUser);
        User currentUser = (User) sessionUser;
        if (currentUser == null) {
            System.out.println("No logged-in user found in session for edit");
            redirectAttributes.addFlashAttribute("errorMessage", "Session expired. Please log in.");
            return "redirect:/login";
        }
        System.out.println("Current user: " + currentUser.getEmail() + ", Role: " + currentUser.getRole() + ", ID: "
                + currentUser.getId());
        if (currentUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        try {
            System.out.println("Attempting to fetch land with ID: " + id + " for user ID: " + currentUser.getId());
            Land land = landService.getLandByIdAndUser(id, currentUser);
            System.out.println("Land fetched: " + (land != null ? land.getId() + ", " + land.getTitle() : "null"));
            LandDTO landDTO = landService.toDTO(land);
            System.out.println("Converted to DTO: " + (landDTO != null ? landDTO.getTitle() : "null"));
            model.addAttribute("landDTO", landDTO);
            model.addAttribute("loggedInUser", currentUser);
            return "edit-land";
        } catch (Exception e) {
            System.out.println("Error fetching land for edit: " + e.getMessage());
            e.printStackTrace(System.out); // Force stack trace to console
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to load land for editing: " + e.getMessage());
            return "redirect:/lands/my-posts";
        }
    }

    @PostMapping("/update/{id}")
    public String updateLand(@PathVariable Long id, @Valid @ModelAttribute("landDTO") LandDTO landDTO,
            BindingResult bindingResult,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null || currentUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        System.out.println("Received update request for ID: " + id + ", DTO: " + landDTO);
        if (bindingResult.hasErrors()) {
            System.out.println("Validation failed: " + bindingResult.getAllErrors());
            redirectAttributes.addFlashAttribute("error", "Invalid input");
            return "redirect:/lands/edit/" + id;
        }
        // Only validate images if they contain non-empty files
        if (landDTO.getImages() != null && !landDTO.getImages().isEmpty()) {
            // Check if any files are provided and validate them
            boolean hasNonEmptyFiles = landDTO.getImages().stream().anyMatch(file -> !file.isEmpty());
            if (hasNonEmptyFiles && !ValidationUtil.isValidImages(landDTO.getImages())) {
                System.out.println("Invalid images detected, preventing update");
                redirectAttributes.addFlashAttribute("error", "Invalid images provided");
                return "redirect:/lands/edit/" + id;
            }
        }
        try {
            landService.updateLand(id, landDTO, currentUser);
            redirectAttributes.addFlashAttribute("successMessage", "Your post updated successfully!");
            return "redirect:/lands/my-posts";
        } catch (Exception e) {
            System.out.println("Exception during update: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update land: " + e.getMessage());
            return "redirect:/lands/edit/" + id;
        }
    }

    @PostMapping("/delete/{id}")
    public String deleteLand(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null || currentUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        landService.deleteLand(id, currentUser);
        redirectAttributes.addFlashAttribute("successMessage", "Land deleted successfully!");
        return "redirect:/lands/my-posts";
    }

    @GetMapping("/history")
    public String history(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null || currentUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        List<Land> history = landService.getLandsByUser(currentUser);
        model.addAttribute("history", history);
        return "my-lands-history";
    }

    @GetMapping("/details/{id}")
    public String viewDetails(@PathVariable Long id, Model model, HttpSession session) {
        Land land = landService.getLandById(id);
        model.addAttribute("land", land);
        
        // Calculate seller rating
        User seller = land.getSeller();
        Double sellerRating = reviewService.getAverageRatingForSeller(seller);
        model.addAttribute("sellerRating", sellerRating != null ? sellerRating : 0.0);
        
        // Get reviews for this seller
        List<Review> reviews = reviewService.getReviewsForSeller(seller);
        model.addAttribute("reviews", reviews);
        
        // Check if current user has already reviewed this seller
        User currentUser = (User) session.getAttribute("loggedInUser");
        boolean hasReviewed = false;
        if (currentUser != null && currentUser.getRole() == Role.BUYER) {
            hasReviewed = reviewService.hasUserReviewedSeller(currentUser, seller);
        }
        model.addAttribute("hasReviewed", hasReviewed);
        
        return "land-details"; // Maps to land-details.jsp
    }

    @DeleteMapping("/delete-image/{imageId}")
    @ResponseBody
    public ResponseEntity<String> deleteImage(@PathVariable Long imageId, HttpSession session) {
        System.out.println("=== DELETE IMAGE CONTROLLER START ===");
        System.out.println("Received delete request for image ID: " + imageId);
        System.out.println("Session ID: " + session.getId());
        
        User currentUser = (User) session.getAttribute("loggedInUser");
        if (currentUser == null) {
            System.out.println("Access denied - no user in session");
            return ResponseEntity.status(403).body("Access denied - no user in session");
        }
        
        if (currentUser.getRole() != Role.SELLER) {
            System.out.println("Access denied - user is not a seller. Role: " + currentUser.getRole());
            return ResponseEntity.status(403).body("Access denied - user is not a seller");
        }
        
        System.out.println("User authorized: " + currentUser.getEmail() + ", Role: " + currentUser.getRole());
        
        try {
            System.out.println("Attempting to delete image ID: " + imageId + " for user: " + currentUser.getEmail());
            landService.deleteImage(imageId, currentUser);
            System.out.println("Image deletion successful for ID: " + imageId);
            return ResponseEntity.ok("Image deleted successfully");
        } catch (Exception e) {
            System.out.println("Error deleting image ID " + imageId + ": " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to delete image: " + e.getMessage());
        }
    }
}
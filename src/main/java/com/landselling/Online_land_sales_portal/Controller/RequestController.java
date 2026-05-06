package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.LandService;
import com.landselling.Online_land_sales_portal.Service.RequestService;
import com.landselling.Online_land_sales_portal.Service.UserService;
import com.landselling.Online_land_sales_portal.Util.ValidationUtil;
import com.landselling.Online_land_sales_portal.entity.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/requests")
public class RequestController {

    @Autowired
    private RequestService requestService;

    @Autowired
    private LandService landService;

    @Autowired
    private UserService userService;

    /**
     * Submit a new request
     */
    @PostMapping("/submit")
    public String submitRequest(
            @RequestParam Long landId,
            @RequestParam RequestType requestType,
            @RequestParam(required = false) String message,
            @RequestParam String contactPhone,
            @RequestParam String contactEmail,
            @RequestParam(required = false) String preferredContactTime,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login to make a request");
            return "redirect:/login";
        }

        try {
            // 1. Validate landId is not null
            if (landId == null || landId <= 0) {
                redirectAttributes.addFlashAttribute("error", "Invalid land ID");
                return "redirect:/lands";
            }

            // 2. Validate requestType is not null
            if (requestType == null) {
                redirectAttributes.addFlashAttribute("error", "Request type is required");
                return "redirect:/lands/details/" + landId;
            }

            // 3. Validate contact phone (required, format and length)
            if (!ValidationUtil.isNotEmpty(contactPhone)) {
                redirectAttributes.addFlashAttribute("error", "Contact phone number is required");
                return "redirect:/lands/details/" + landId;
            }

            if (!ValidationUtil.isValidPhone(contactPhone)) {
                redirectAttributes.addFlashAttribute("error", "Invalid phone number format. Phone must contain 10-15 digits and can include +, -, spaces, and parentheses");
                return "redirect:/lands/details/" + landId;
            }

            if (!ValidationUtil.isValidLength(contactPhone, 10, 20)) {
                redirectAttributes.addFlashAttribute("error", "Phone number must be between 10 and 20 characters");
                return "redirect:/lands/details/" + landId;
            }

            // 4. Validate contact email (required, format and length)
            if (!ValidationUtil.isNotEmpty(contactEmail)) {
                redirectAttributes.addFlashAttribute("error", "Contact email is required");
                return "redirect:/lands/details/" + landId;
            }

            if (!ValidationUtil.isValidEmail(contactEmail)) {
                redirectAttributes.addFlashAttribute("error", "Invalid email format. Please provide a valid email address");
                return "redirect:/lands/details/" + landId;
            }

            if (!ValidationUtil.isValidLength(contactEmail, 5, 100)) {
                redirectAttributes.addFlashAttribute("error", "Email must be between 5 and 100 characters");
                return "redirect:/lands/details/" + landId;
            }

            // 5. Validate message length (optional field)
            if (message != null && !ValidationUtil.isWithinMaxLength(message, 1000)) {
                redirectAttributes.addFlashAttribute("error", "Message must not exceed 1000 characters");
                return "redirect:/lands/details/" + landId;
            }

            // 6. Validate preferredContactTime length (optional field)
            if (preferredContactTime != null && !ValidationUtil.isWithinMaxLength(preferredContactTime, 50)) {
                redirectAttributes.addFlashAttribute("error", "Preferred contact time must not exceed 50 characters");
                return "redirect:/lands/details/" + landId;
            }

            // 7. Sanitize all inputs to prevent XSS attacks
            String sanitizedContactPhone = ValidationUtil.sanitizeInput(contactPhone);
            String sanitizedContactEmail = ValidationUtil.sanitizeInput(contactEmail);
            String sanitizedMessage = ValidationUtil.sanitizeInput(message);
            String sanitizedPreferredContactTime = ValidationUtil.sanitizeInput(preferredContactTime);

            // 8. Check if land exists
            Land land = landService.getLandById(landId);
            if (land == null) {
                redirectAttributes.addFlashAttribute("error", "Land not found");
                return "redirect:/lands";
            }

            // 9. Check if land is available
            if (land.getStatus() != LandStatus.AVAILABLE) {
                redirectAttributes.addFlashAttribute("error", "This land is not available for requests");
                return "redirect:/lands/details/" + landId;
            }

            // 10. Check if user is not the seller (users shouldn't request their own land)
            if (land.getSeller().getId().equals(loggedInUser.getId())) {
                redirectAttributes.addFlashAttribute("error", "You cannot make a request for your own land");
                return "redirect:/lands/details/" + landId;
            }

            // 11. Create the request with sanitized inputs
            requestService.createRequest(
                loggedInUser, 
                land, 
                requestType, 
                sanitizedMessage, 
                sanitizedContactPhone, 
                sanitizedContactEmail, 
                sanitizedPreferredContactTime
            );

            redirectAttributes.addFlashAttribute("success", 
                "Your " + requestType.getDisplayName() + " request has been submitted successfully!");

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", "Validation error: " + e.getMessage());
            return "redirect:/lands/details/" + landId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to submit request: " + e.getMessage());
            return "redirect:/lands/details/" + landId;
        }

        return "redirect:/lands/details/" + landId;
    }

    /**
     * View requests - unified page for both admin and seller
     * Admin sees all requests, Seller sees only their land requests
     */
    @GetMapping("/manage")
    public String manageRequests(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login first");
            return "redirect:/login";
        }

        try {
            List<Request> requests;
            
            // Admin sees all requests, Seller sees only their land requests
            if (loggedInUser.getRole() == Role.ADMIN) {
                requests = requestService.getAllRequests();
            } else if (loggedInUser.getRole() == Role.SELLER) {
                requests = requestService.getRequestsForSeller(loggedInUser);
            } else {
                redirectAttributes.addFlashAttribute("error", "Access denied. Only admins and sellers can manage requests.");
                return "redirect:/dashboard";
            }
            
            model.addAttribute("requests", requests);
            model.addAttribute("user", loggedInUser);
            model.addAttribute("isAdmin", loggedInUser.getRole() == Role.ADMIN);
            return "manage-requests";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading requests: " + e.getMessage());
            return "redirect:/dashboard";
        }
    }

    /**
     * View all requests made by the logged-in user
     */
    @GetMapping("/my-submitted-requests")
    public String viewMySubmittedRequests(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login first");
            return "redirect:/login";
        }

        try {
            User user = loggedInUser;
            List<Request> requests = requestService.getRequestsByUser(user);
            model.addAttribute("requests", requests);
            model.addAttribute("user", user);
            return "my-submitted-requests";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error loading requests: " + e.getMessage());
            return "redirect:/dashboard";
        }
    }

    /**
     * Approve a request (seller/admin only)
     */
    @PostMapping("/approve/{id}")
    public String approveRequest(
            @PathVariable Long id,
            @RequestParam(required = false) String responseMessage,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login first");
            return "redirect:/login";
        }

        try {
            User user = loggedInUser;
            requestService.approveRequest(id, user, responseMessage);
            redirectAttributes.addFlashAttribute("success", "Request approved successfully!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to approve request: " + e.getMessage());
        }

        // Redirect back to unified manage requests page
        return "redirect:/requests/manage";
    }

    /**
     * Reject a request (seller/admin only)
     */
    @PostMapping("/reject/{id}")
    public String rejectRequest(
            @PathVariable Long id,
            @RequestParam(required = false) String responseMessage,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login first");
            return "redirect:/login";
        }

        try {
            User user = loggedInUser;
            requestService.rejectRequest(id, user, responseMessage);
            redirectAttributes.addFlashAttribute("success", "Request rejected successfully!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to reject request: " + e.getMessage());
        }

        // Redirect back to unified manage requests page
        return "redirect:/requests/manage";
    }

    /**
     * Delete a request (buyer only, only for pending requests)
     */
    @PostMapping("/delete/{id}")
    public String deleteRequest(
            @PathVariable Long id,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            redirectAttributes.addFlashAttribute("error", "Please login first");
            return "redirect:/login";
        }

        try {
            requestService.deleteRequest(id, loggedInUser);
            redirectAttributes.addFlashAttribute("success", "Request deleted successfully!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete request: " + e.getMessage());
        }

        return "redirect:/requests/my-submitted-requests";
    }
}


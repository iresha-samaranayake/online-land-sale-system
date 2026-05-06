package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.LandService;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.entity.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private LandService landService;

    @GetMapping("/admin/pending-ads")
    public String pendingLands(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.ADMIN) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        model.addAttribute("pendingLands", landService.getPendingLands());
        return "admin-pending-lands";
    }

    @PostMapping("/admin/approve/{id}")
    public String approveLand(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.ADMIN) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
            return "redirect:/login";
        }
        try {
            landService.approveLand(id, loggedInUser); // Pass the admin user
            redirectAttributes.addFlashAttribute("success", "Land approved successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to approve land: " + e.getMessage());
        }
        return "redirect:/admin/pending-ads";
    }

@PostMapping("/admin/reject/{id}")
public String rejectLand(@PathVariable Long id, @RequestParam String reason, HttpSession session, RedirectAttributes redirectAttributes) {
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null || loggedInUser.getRole() != Role.ADMIN) {
        redirectAttributes.addFlashAttribute("errorMessage", "Access denied.");
        return "redirect:/login";
    }
    try {
        landService.rejectLand(id, reason);
        redirectAttributes.addFlashAttribute("success", "Land rejected successfully.");
    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("errorMessage", "Failed to reject land: " + e.getMessage());
    }
    return "redirect:/admin/pending-ads";
}
}
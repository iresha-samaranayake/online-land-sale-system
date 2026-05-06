package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.PromotionService;
import com.landselling.Online_land_sales_portal.dto.PromotionDTO;
import com.landselling.Online_land_sales_portal.entity.Land;
import com.landselling.Online_land_sales_portal.entity.Promotion;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.entity.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/promote/listing")
public class PromotionController {

    @Autowired
    private PromotionService promotionService;

    @GetMapping
    public String showPromotionPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Sellers only.");
            return "redirect:/login";
        }
        model.addAttribute("approvedListings", promotionService.getApprovedListingsForSeller(session));
        model.addAttribute("promotionDTO", new PromotionDTO());
        return "promoteListing";
    }

    @GetMapping("/select/{id}")
    public String selectListing(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Sellers only.");
            return "redirect:/login";
        }
        try {
            Land listing = promotionService.getListingById(id);
            if (!listing.getSeller().getId().equals(loggedInUser.getId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Unauthorized access to listing");
                return "redirect:/promote/listing";
            }
            Promotion promotion = promotionService.getPromotionByListing(listing);
            PromotionDTO promotionDTO = new PromotionDTO();
            if (promotion != null) {
                promotionDTO.setListingId(id);
                promotionDTO.setBannerType(promotion.getBannerType().name());
                promotionDTO.setDiscount(promotion.getDiscountPercentage().intValue());
                promotionDTO.setDuration(promotion.getDuration());
            } else {
                promotionDTO.setListingId(id);
            }
            model.addAttribute("selectedListing", listing);
            model.addAttribute("promotionDTO", promotionDTO);
            model.addAttribute("approvedListings", promotionService.getApprovedListingsForSeller(session));
            return "promoteListing";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Listing not found");
            return "redirect:/promote/listing";
        }
    }

    @PostMapping("/save")
    public String savePromotion(@Valid @ModelAttribute("promotionDTO") PromotionDTO promotionDTO, BindingResult bindingResult,
                                HttpSession session, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Sellers only.");
            return "redirect:/login";
        }
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Invalid promotion details");
            return "redirect:/promote/listing/select/" + promotionDTO.getListingId();
        }
        try {
            promotionService.savePromotion(promotionDTO.getListingId(), promotionDTO.getBannerType(),
                    promotionDTO.getDiscount(), promotionDTO.getDuration(), session);
            redirectAttributes.addFlashAttribute("successMessage", "Promotion applied successfully");
        } catch (IllegalArgumentException | IllegalStateException | SecurityException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/promote/listing";
    }

    @GetMapping("/edit/{id}")
    public String editPromotion(@PathVariable Long id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Sellers only.");
            return "redirect:/login";
        }
        try {
            Land listing = promotionService.getListingById(id);
            if (!listing.getSeller().getId().equals(loggedInUser.getId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Unauthorized access to listing");
                return "redirect:/promote/listing";
            }
            Promotion promotion = promotionService.getPromotionByListing(listing);
            if (promotion == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "No promotion found for this listing");
                return "redirect:/promote/listing";
            }
            PromotionDTO promotionDTO = new PromotionDTO();
            promotionDTO.setListingId(id);
            promotionDTO.setBannerType(promotion.getBannerType().name());
            promotionDTO.setDiscount(promotion.getDiscountPercentage().intValue());
            promotionDTO.setDuration(promotion.getDuration());
            model.addAttribute("selectedListing", listing);
            model.addAttribute("promotionDTO", promotionDTO);
            model.addAttribute("approvedListings", promotionService.getApprovedListingsForSeller(session));
            return "promoteListing";
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Listing not found");
            return "redirect:/promote/listing";
        }
    }

    @GetMapping("/delete/{id}")
    public String deletePromotion(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null || loggedInUser.getRole() != Role.SELLER) {
            redirectAttributes.addFlashAttribute("errorMessage", "Access denied. Sellers only.");
            return "redirect:/login";
        }
        try {
            promotionService.deletePromotion(id, loggedInUser);
            redirectAttributes.addFlashAttribute("successMessage", "Promotion removed successfully");
        } catch (IllegalArgumentException | SecurityException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/promote/listing";
    }
}

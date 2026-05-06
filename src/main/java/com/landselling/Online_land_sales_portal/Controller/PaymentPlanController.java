package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.LandService;
import com.landselling.Online_land_sales_portal.Service.PaymentPlanService;
import com.landselling.Online_land_sales_portal.Service.UserService;
import com.landselling.Online_land_sales_portal.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PaymentPlanController {

    @Autowired
    private PaymentPlanService paymentPlanService;

    @Autowired
    private LandService landService;

    @Autowired
    private UserService userService;

    // ✅ ADMIN: View all payment plans
    @GetMapping("/admin/payment-plans")
    public String adminPayementPlan(Model model) {
        List<PaymentPlan> payments = paymentPlanService.getAllPaymentPlans();
        model.addAttribute("payments", payments);
        model.addAttribute("paymentStatuses", PayementStatus.values());
        return "payment-plans/admin-list";
    }

    // ✅ SELLER: View all payment plans
    @GetMapping("/seller/{userId}/payment-plans")
    public String sellerPayementPlan(@PathVariable Long userId, Model model) {
        List<PaymentPlan> payments = paymentPlanService.getAllPaymentPlans();
        model.addAttribute("userId", userId);
        model.addAttribute("payments", payments);
        model.addAttribute("paymentStatuses", PayementStatus.values());
        model.addAttribute("pageTitle", "All Payment Plans");
        return "payment-plans/seller-list";
    }

    // ✅ CREATE payment plan form
    @GetMapping("/seller/{userId}/payment-plans/create")
    public String showCreatePaymentPlanForm(@PathVariable Long userId, Model model) {
        try {
            User user = userService.getUserById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

            List<Land> userLands = landService.getLandsBySellerAndStatus(userId);

            model.addAttribute("userId", userId);
            model.addAttribute("userLands", userLands);
            model.addAttribute("paymentPlan", new PaymentPlan());
            model.addAttribute("paymentFrequencies", getPaymentFrequencies());
            return "payment-plans/create";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading form: " + e.getMessage());
            return "redirect:/seller/" + userId + "/payment-plans";
        }
    }

    // ✅ CREATE payment plan submit
    @PostMapping("/seller/{userId}/payment-plans/create")
    public String createPaymentPlan(@PathVariable Long userId,
                                    @ModelAttribute PaymentPlan paymentPlan,
                                    @RequestParam Long landId,
                                    BindingResult result,
                                    Model model) {
        try {
            paymentPlanService.createPaymentPlanForSeller(userId, landId, paymentPlan);
            return "redirect:/seller/" + userId + "/payment-plans?success=Payment+plan+created+successfully";
        } catch (Exception e) {
            List<Land> userLands = landService.getLandsBySellerAndStatus(userId);
            model.addAttribute("userId", userId);
            model.addAttribute("userLands", userLands);
            model.addAttribute("paymentFrequencies", getPaymentFrequencies());
            model.addAttribute("error", "Error creating payment plan: " + e.getMessage());
            return "payment-plans/seller-list";
        }
    }

    // ✅ EDIT form
    @GetMapping("/seller/{userId}/payment-plans/{paymentPlanId}/edit")
    public String showEditPaymentPlanForm(@PathVariable Long userId,
                                          @PathVariable Long paymentPlanId,
                                          Model model) {
        try {
            User user = userService.getUserById(userId)
                    .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

            PaymentPlan paymentPlan = paymentPlanService.getPaymentPlanByIdAndSellerId(paymentPlanId, userId);
            List<Land> userLands = landService.getLandsBySellerAndStatus(userId);

            model.addAttribute("userId", userId);
            model.addAttribute("userLands", userLands);
            model.addAttribute("paymentPlan", paymentPlan);
            model.addAttribute("paymentFrequencies", getPaymentFrequencies());
            model.addAttribute("isEdit", true);
            model.addAttribute("paymentPlanId", paymentPlanId);
            return "payment-plans/update";
        } catch (Exception e) {
            model.addAttribute("error", "Error loading payment plan: " + e.getMessage());
            return "redirect:/seller/" + userId + "/payment-plans";
        }
    }

    // ✅ UPDATE payment plan
    @PostMapping("/seller/{userId}/payment-plans/{paymentPlanId}/edit")
    public String updatePaymentPlan(@PathVariable Long userId,
                                    @PathVariable Long paymentPlanId,
                                    @ModelAttribute PaymentPlan paymentPlan,
                                    BindingResult result,
                                    Model model) {
        try {
            paymentPlanService.updatePaymentPlan(paymentPlanId, paymentPlan);
            return "redirect:/seller/" + userId + "/payment-plans?success=Payment+plan+updated+successfully";
        } catch (Exception e) {
            model.addAttribute("error", "Error updating payment plan: " + e.getMessage());
            return "payment-plans/seller-list";
        }
    }

    // ✅ NEW FEATURE: MANUALLY UPDATE STATUS (Admin/Staff)
    @PostMapping("/admin/payment-plans/{id}/status")
    public String updatePaymentPlanStatus(@PathVariable Long id,
                                          @RequestParam("status") String newStatus,
                                          Model model) {
        try {
            paymentPlanService.updatePaymentPlanStatus(id, PayementStatus.valueOf(newStatus));
            return "redirect:/admin/payment-plans?success=Status+updated+to+" + newStatus;
        } catch (Exception e) {
            model.addAttribute("error", "Error updating status: " + e.getMessage());
            return "redirect:/admin/payment-plans?error=Could+not+update+status";
        }
    }

    // ✅ DELETE
    @DeleteMapping("/{paymentPlanId}")
    @ResponseBody
    public ResponseEntity<?> deletePaymentPlanRest(@PathVariable Long paymentPlanId) {
        try {
            paymentPlanService.deletePaymentPlan(paymentPlanId);
            return ResponseEntity.ok().body("Payment plan deleted successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // ✅ STAFF DASHBOARD
    @GetMapping("/staff/payment-plans")
    public String staffPaymentPlans(Model model) {
        List<PaymentPlan> payments = paymentPlanService.getAllPaymentPlans();
        model.addAttribute("payments", payments);
        model.addAttribute("paymentStatuses", PayementStatus.values());
        model.addAttribute("pageTitle", "Staff Dashboard - Payment Plans");
        return "payment-plans/staff-list";
    }

    // ✅ UTILITY: Payment frequencies
    private Map<Integer, String> getPaymentFrequencies() {
        Map<Integer, String> frequencies = new LinkedHashMap<>();
        frequencies.put(30, "Monthly (30 days)");
        frequencies.put(60, "Bi-monthly (60 days)");
        frequencies.put(90, "Quarterly (90 days)");
        frequencies.put(180, "Semi-annual (180 days)");
        frequencies.put(365, "Annual (365 days)");
        return frequencies;
    }
}

package com.landselling.Online_land_sales_portal.Service;

import com.landselling.Online_land_sales_portal.Repository.LandRepository;
import com.landselling.Online_land_sales_portal.Repository.PaymentPlanRepository;
import com.landselling.Online_land_sales_portal.dto.PayemtLandDto;
import com.landselling.Online_land_sales_portal.dto.PaymentPlanDTO;
import com.landselling.Online_land_sales_portal.entity.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PaymentPlanService {

    @Autowired
    private LandRepository landRepository;

    @Autowired
    private PaymentPlanRepository paymentPlanRepository;

    public List<Land> getLandsBySeller(User seller) {
        return landRepository.findBySeller(seller);
    }

    public List<PaymentPlan> getAllPaymentPlans() {
        return paymentPlanRepository.findAllPaymentPlansWithLand();
    }

    @Transactional
    public List<PayemtLandDto> getLandsBySellerId(Long sellerId) {
        List<Land> lands = landRepository.findBySellerId(sellerId);

        if (lands.isEmpty()) {
            return List.of();
        }

        return lands.stream().map(land -> {
            String sellerName = land.getSeller() != null ?
                    land.getSeller().getName() : "Unknown";

            List<String> imageUrls = land.getImages().stream()
                    .map(image -> "/images/lands/" + image.getImageName())
                    .collect(Collectors.toList());

            return new PayemtLandDto(
                    land.getId(),
                    land.getTitle(),
                    land.getDescription(),
                    land.getPrice(),
                    land.getSize(),
                    land.getLocation(),
                    land.getStatus(),
                    sellerName,
                    land.getCreatedAt(),
                    imageUrls
            );
        }).collect(Collectors.toList());
    }

    @Transactional
    public PaymentPlan createPaymentPlan(PaymentPlanDTO paymentPlanDTO) {
        // Validate land exists
        Land land = landRepository.findById(paymentPlanDTO.getLandId())
                .orElseThrow(() -> new IllegalArgumentException("Land not found with id: " + paymentPlanDTO.getLandId()));

        // Validate business logic
        validatePaymentPlan(paymentPlanDTO);

        // Create new PaymentPlan
        PaymentPlan paymentPlan = new PaymentPlan();
        paymentPlan.setLand(land);
        paymentPlan.setPlanName(paymentPlanDTO.getPlanName());
        paymentPlan.setTotalAmount(paymentPlanDTO.getTotalAmount());
        paymentPlan.setDownPayment(paymentPlanDTO.getDownPayment());
        paymentPlan.setInstallmentCount(paymentPlanDTO.getInstallmentCount());
        paymentPlan.setInstallmentAmount(paymentPlanDTO.getInstallmentAmount());
        paymentPlan.setPaymentFrequency(paymentPlanDTO.getPaymentFrequency());
        paymentPlan.setTerms(paymentPlanDTO.getTerms());
        paymentPlan.setInterestRate(paymentPlanDTO.getInterestRate());
        paymentPlan.setStatus(PayementStatus.PROPOSED);

        return paymentPlanRepository.save(paymentPlan);
    }

    private void validatePaymentPlan(PaymentPlanDTO paymentPlanDTO) {
        // Validate that down payment is not greater than total amount
        if (paymentPlanDTO.getDownPayment().compareTo(paymentPlanDTO.getTotalAmount()) > 0) {
            throw new IllegalArgumentException("Down payment cannot be greater than total amount");
        }

        // Validate that installment calculation matches
        BigDecimal calculatedInstallmentTotal = paymentPlanDTO.getInstallmentAmount()
                .multiply(BigDecimal.valueOf(paymentPlanDTO.getInstallmentCount()));

        BigDecimal remainingAmount = paymentPlanDTO.getTotalAmount()
                .subtract(paymentPlanDTO.getDownPayment());

        if (calculatedInstallmentTotal.compareTo(remainingAmount) != 0) {
            throw new IllegalArgumentException("Installment amount x count must equal total amount minus down payment. " +
                    "Expected: " + remainingAmount + ", Calculated: " + calculatedInstallmentTotal);
        }
    }

    @Transactional
    public List<Land> getAvailableLands() {
        return landRepository.findByStatus(LandStatus.AVAILABLE);
    }

    @Transactional
    public PaymentPlan createPaymentPlanForSeller(Long sellerId, Long landId, PaymentPlan paymentPlan) {
        // Validate land exists and belongs to seller
        Land land = landRepository.findById(landId)
                .orElseThrow(() -> new IllegalArgumentException("Land not found with id: " + landId));

        if (!land.getSeller().getId().equals(sellerId)) {
            throw new IllegalArgumentException("Land does not belong to seller with id: " + sellerId);
        }

        // Set the land and save the payment plan
        paymentPlan.setLand(land);
        paymentPlan.setStatus(PayementStatus.PROPOSED);

        return paymentPlanRepository.save(paymentPlan);
    }

    @Transactional
    public PaymentPlan getPaymentPlanById(Long id) {
        return paymentPlanRepository.findByIdWithLand(id)
                .orElseThrow(() -> new RuntimeException("Payment plan not found with id: " + id));
    }

    @Transactional
    public PaymentPlan getPaymentPlanByIdAndSellerId(Long id, Long sellerId) {
        return paymentPlanRepository.findByIdAndSellerId(id, sellerId)
                .orElseThrow(() -> new RuntimeException("Payment plan not found or you don't have permission to access it"));
    }

    public PaymentPlan updatePaymentPlan(Long paymentPlanId, PaymentPlan paymentPlanDetails) {
        PaymentPlan existingPaymentPlan = getPaymentPlanById(paymentPlanId);

        // Update only editable fields
        existingPaymentPlan.setPlanName(paymentPlanDetails.getPlanName());
        existingPaymentPlan.setTotalAmount(paymentPlanDetails.getTotalAmount());
        existingPaymentPlan.setDownPayment(paymentPlanDetails.getDownPayment());
        existingPaymentPlan.setInstallmentCount(paymentPlanDetails.getInstallmentCount());
        existingPaymentPlan.setInstallmentAmount(paymentPlanDetails.getInstallmentAmount());
        existingPaymentPlan.setPaymentFrequency(paymentPlanDetails.getPaymentFrequency());
        existingPaymentPlan.setInterestRate(paymentPlanDetails.getInterestRate());
        existingPaymentPlan.setTerms(paymentPlanDetails.getTerms());

        // Reset status to PROPOSED if amounts are changed (for admin re-approval)
        if (amountsChanged(existingPaymentPlan, paymentPlanDetails)) {
            existingPaymentPlan.setStatus(PayementStatus.PROPOSED);
        }

        return paymentPlanRepository.save(existingPaymentPlan);
    }

    public void updatePaymentPlanStatus(Long id, PayementStatus newStatus) {
        PaymentPlan plan = paymentPlanRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment plan not found"));
        plan.setStatus(newStatus);
        paymentPlanRepository.save(plan);
    }


    private boolean amountsChanged(PaymentPlan existing, PaymentPlan updated) {
        return !existing.getTotalAmount().equals(updated.getTotalAmount()) ||
                !existing.getDownPayment().equals(updated.getDownPayment()) ||
                !existing.getInstallmentCount().equals(updated.getInstallmentCount()) ||
                !existing.getInstallmentAmount().equals(updated.getInstallmentAmount());

    }

    @Transactional
    public void deletePaymentPlan(Long id) {
        PaymentPlan paymentPlan = paymentPlanRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment plan not found with id: " + id));

        // Check if payment plan can be deleted (only if it's in PROPOSED or REJECTED status)
        if (paymentPlan.getStatus() != PayementStatus.PROPOSED &&
                paymentPlan.getStatus() != PayementStatus.REJECTED) {
            throw new RuntimeException("Cannot delete payment plan with status: " + paymentPlan.getStatus() +
                    ". Only PROPOSED or REJECTED payment plans can be deleted.");
        }

        paymentPlanRepository.delete(paymentPlan);
    }

    public long getPayementPlanCount(long sellerId){
        return paymentPlanRepository.countPaymentPlanByLand_SellerId(sellerId);
    }


}











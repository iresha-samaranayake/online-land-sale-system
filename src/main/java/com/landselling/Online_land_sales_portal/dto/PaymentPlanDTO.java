package com.landselling.Online_land_sales_portal.dto;

import jakarta.validation.constraints.*;

import java.math.BigDecimal;

public class PaymentPlanDTO {
    private Long id;

    @NotNull(message = "Land is required")
    private Long landId;

    @NotBlank(message = "Plan name is required")
    @Size(max = 100, message = "Plan name must not exceed 100 characters")
    private String planName;

    @NotNull(message = "Total amount is required")
    @DecimalMin(value = "0.01", message = "Total amount must be greater than 0")
    private BigDecimal totalAmount;

    @NotNull(message = "Down payment is required")
    @DecimalMin(value = "0.00", message = "Down payment cannot be negative")
    private BigDecimal downPayment;

    @NotNull(message = "Installment count is required")
    @Min(value = 1, message = "At least 1 installment is required")
    private Integer installmentCount;

    @NotNull(message = "Installment amount is required")
    @DecimalMin(value = "0.01", message = "Installment amount must be greater than 0")
    private BigDecimal installmentAmount;

    @NotNull(message = "Payment frequency is required")
    @Min(value = 1, message = "Payment frequency must be at least 1 day")
    private Integer paymentFrequency;

    private String terms;

    @DecimalMin(value = "0.00", message = "Interest rate cannot be negative")
    @DecimalMax(value = "100.00", message = "Interest rate cannot exceed 100%")
    private BigDecimal interestRate;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getLandId() { return landId; }
    public void setLandId(Long landId) { this.landId = landId; }

    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }

    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }

    public BigDecimal getDownPayment() { return downPayment; }
    public void setDownPayment(BigDecimal downPayment) { this.downPayment = downPayment; }

    public Integer getInstallmentCount() { return installmentCount; }
    public void setInstallmentCount(Integer installmentCount) { this.installmentCount = installmentCount; }

    public BigDecimal getInstallmentAmount() { return installmentAmount; }
    public void setInstallmentAmount(BigDecimal installmentAmount) { this.installmentAmount = installmentAmount; }

    public Integer getPaymentFrequency() { return paymentFrequency; }
    public void setPaymentFrequency(Integer paymentFrequency) { this.paymentFrequency = paymentFrequency; }

    public String getTerms() { return terms; }
    public void setTerms(String terms) { this.terms = terms; }

    public BigDecimal getInterestRate() { return interestRate; }
    public void setInterestRate(BigDecimal interestRate) { this.interestRate = interestRate; }
}
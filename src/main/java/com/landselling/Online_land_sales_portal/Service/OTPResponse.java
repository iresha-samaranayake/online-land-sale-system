package com.landselling.Online_land_sales_portal.Service;

public class OTPResponse {
    private final String otp;
    private final String status;

    public OTPResponse(String otp, String status) {
        this.otp = otp;
        this.status = status;
    }

    public String getOtp() {
        return otp;
    }

    public String getStatus() {
        return status;
    }
    
}

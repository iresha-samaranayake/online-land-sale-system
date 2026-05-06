package com.landselling.Online_land_sales_portal.Util;

import java.util.List;
import java.util.regex.Pattern;
import org.springframework.web.multipart.MultipartFile; 

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    
    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9+\\-\\s()]+$");

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 8;
    }

    public static boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }
    
    /**
     * Validates phone number format and length
     * Phone must contain 10-15 digits and can include +, -, spaces, and parentheses
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        
        // Check format (allows digits, +, -, spaces, parentheses)
        if (!PHONE_PATTERN.matcher(phone).matches()) {
            return false;
        }
        
        // Extract only digits to check length
        String digitsOnly = phone.replaceAll("[^0-9]", "");
        int digitCount = digitsOnly.length();
        
        // Must have between 10 and 15 digits
        return digitCount >= 10 && digitCount <= 15;
    }
    
    /**
     * Validates string length is within specified range
     */
    public static boolean isValidLength(String str, int minLength, int maxLength) {
        if (str == null) {
            return false;
        }
        int length = str.trim().length();
        return length >= minLength && length <= maxLength;
    }
    
    /**
     * Validates string does not exceed maximum length
     */
    public static boolean isWithinMaxLength(String str, int maxLength) {
        if (str == null) {
            return true; // null is acceptable for optional fields
        }
        return str.length() <= maxLength;
    }
    
    /**
     * Sanitizes input string to prevent XSS and injection attacks
     */
    public static String sanitizeInput(String input) {
        if (input == null) {
            return null;
        }
        // Remove potential XSS characters and trim
        return input.trim()
                .replaceAll("<", "&lt;")
                .replaceAll(">", "&gt;")
                .replaceAll("\"", "&quot;")
                .replaceAll("'", "&#x27;")
                .replaceAll("/", "&#x2F;");
    }


    public static boolean isValidImages(List<MultipartFile> files) {
        if (files == null || files.isEmpty()) return false;
        for (MultipartFile file : files) {
            if (file.isEmpty() || !List.of("image/jpeg", "image/png").contains(file.getContentType())) {
                return false;
            }
        }
        return true;
    }
}
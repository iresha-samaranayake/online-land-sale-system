package com.landselling.Online_land_sales_portal.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Value("${app.email.demo-mode:false}")
    private boolean demoMode;

    @Value("${spring.mail.username:}")
    private String configuredMailUsername;

    @Autowired
    private JavaMailSender mailSender;

    public String sendOTPEmail(String email, String name, String otp) {
        System.out.println("Demo mode enabled: " + demoMode);

        if (demoMode || !isMailConfigured()) {
            printDemoOtp(email, name, otp);
            return "EMAIL_SENT_DEMO";
        }

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(email);
            helper.setFrom(configuredMailUsername);
            helper.setSubject("LandSales Portal - Email Verification");
            helper.setText(
                "Dear " + name + ",\n\n" +
                "Your verification code is: " + otp + "\n\n" +
                "This code expires in 5 minutes.\n\n" +
                "Best regards,\n" +
                "LandSales Portal Team"
            );
            mailSender.send(message);
            return "EMAIL_SENT_REAL";
        } catch (MessagingException e) {
            System.err.println("Failed to prepare OTP email: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Failed to send OTP email: " + e.getMessage());
        }

        printDemoOtp(email, name, otp);
        return "EMAIL_SENT_DEMO";
    }

    private boolean isMailConfigured() {
        return configuredMailUsername != null
            && !configuredMailUsername.isBlank()
            && !configuredMailUsername.contains("${");
    }

    private void printDemoOtp(String email, String name, String otp) {
        System.out.println("========================================");
        System.out.println("           EMAIL SIMULATION             ");
        System.out.println("========================================");
        System.out.println("To: " + email);
        System.out.println("Subject: LandSales Portal - Email Verification");
        System.out.println();
        System.out.println("Dear " + name + ",");
        System.out.println();
        System.out.println("Your verification code is: " + otp);
        System.out.println();
        System.out.println("This code expires in 5 minutes.");
        System.out.println();
        System.out.println("Best regards,");
        System.out.println("LandSales Portal Team");
        System.out.println("========================================");
    }
}

package com.landselling.Online_land_sales_portal.Service;

import com.landselling.Online_land_sales_portal.entity.RolePasscode;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.Repository.RolePasscodeRepository;
import com.landselling.Online_land_sales_portal.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Random;
import org.springframework.security.crypto.password.PasswordEncoder;
import java.util.Optional;


@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private EmailService emailService;

    @Autowired
    private RolePasscodeRepository rolePasscodeRepository;


    @Autowired
    private PasswordEncoder passwordEncoder;

    

    public boolean validateRolePasscode(String role, String enteredPasscode) {
    RolePasscode rolePasscode = rolePasscodeRepository.findByRole(role);
    if (rolePasscode == null) return false;
    // Use passwordEncoder to compare plain text with hash
    return passwordEncoder.matches(enteredPasscode, rolePasscode.getPasscode());
}


    public User saveUser(User user) {
    // hash password only if it’s a new one or changed
    if (user.getPassword() != null && !user.getPassword().startsWith("$2a$")) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
    }
    return userRepository.save(user);
}

    
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }
    
    public void deleteUser(Long userId) {
        userRepository.deleteById(userId);
    }

    public User updateUser(User user) {
        return userRepository.save(user);
    }

    public OTPResponse generateAndSendOTP(String email, String name) {
    String otp = String.format("%06d", new Random().nextInt(1000000));
    try {
        String result = emailService.sendOTPEmail(email, name, otp);
        if ("EMAIL_SENT_DEMO".equals(result)) {
            System.out.println("✅ OTP displayed in console (Demo Mode)");
        } else if ("EMAIL_SENT_REAL".equals(result)) {
            System.out.println("✅ OTP sent successfully to " + email);
        } else {
            System.out.println("❌ Failed to send OTP to " + email);
        }
        return new OTPResponse(otp, result);
    } catch (Exception e) {
        System.out.println("❌ Email service error: " + e.getMessage());
        return new OTPResponse(otp, "EMAIL_SENT_FAILED");
    }
}
    //For payement plans
    public Optional<User> getUserById(Long id){
        return userRepository.findUserById(id);
    }

}
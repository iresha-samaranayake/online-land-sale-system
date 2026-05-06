package com.landselling.Online_land_sales_portal.Controller;

import com.landselling.Online_land_sales_portal.Service.AuthenticationContext;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.Service.UserService;
import com.landselling.Online_land_sales_portal.Service.OTPResponse;
import com.landselling.Online_land_sales_portal.strategy.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.security.crypto.password.PasswordEncoder;


@Controller
public class UserController {

    @Autowired
    private PasswordEncoder passwordEncoder;


    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, @RequestParam("passcode") String rolePasscode, RedirectAttributes redirectAttributes) {
        try {
            // Validate password strength
            if (!isPasswordStrong(user.getPassword())) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Password must contain at least 8 characters with uppercase, lowercase, number and special character.");
                return "redirect:/register";
            }

            // Check if user already exists
            if (userService.existsByEmail(user.getEmail())) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Email already exists. Please use a different email.");
                return "redirect:/register";
            }


            // Convert role enum to string
           String roleString = user.getRole().name(); // or user.getRole().toString()

            // Check passcode for Admin/Staff
            // Apply Strategy Pattern for role-based authentication
            AuthenticationContext context = new AuthenticationContext();

            switch (roleString.toUpperCase()) {
                case "ADMIN":
                    context.setStrategy(new AdminAuthenticationStrategy());
                    break;
                case "STAFF":
                    context.setStrategy(new StaffAuthenticationStrategy());
                    break;
                case "BUYER":
                    context.setStrategy(new BuyerAuthenticationStrategy());
                    break;
                case "SELLER":
                    context.setStrategy(new SellerAuthenticationStrategy());
                    break;
                default:
                    throw new IllegalArgumentException("Invalid role type");
            }

            if (!context.executeAuthentication(user, rolePasscode)) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Invalid role passcode or authentication failed for " + roleString);
                return "redirect:/register";
            }
                
            
            // Generate OTP and send email
            OTPResponse response = userService.generateAndSendOTP(user.getEmail(), user.getName());
            String otp = response.getOtp();
            String status = response.getStatus();
            
            // Store user data, OTP, and status in session
            HttpSession session = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest().getSession();
            session.setAttribute("pendingUser", user);
            session.setAttribute("generatedOTP", otp);
            session.setAttribute("otpStatus", status); // Store status for JSP
            session.setAttribute("otpTimestamp", System.currentTimeMillis());
            
            // Set UI message
            if ("EMAIL_SENT_DEMO".equals(status)) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Registration initiated! OTP sent in demo mode (check console).");
            } else if ("EMAIL_SENT_REAL".equals(status)) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Registration initiated! Please check your email (" + user.getEmail() + ") for the OTP. (Check spam if not in inbox.)");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Failed to send OTP. Please try again.");
                return "redirect:/register";
            }
            
            redirectAttributes.addFlashAttribute("userEmail", user.getEmail());
            return "redirect:/verify-otp";
            
            } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Registration failed. Please try again. Error: " + e.getMessage());
            return "redirect:/register";
            }
        }

    @GetMapping("/verify-otp")
    public String showOTPVerification(Model model, HttpSession session) {
        User pendingUser = (User) session.getAttribute("pendingUser");
        String otpStatus = (String) session.getAttribute("otpStatus");
        if (pendingUser == null) {
            return "redirect:/register";
        }
        model.addAttribute("userEmail", pendingUser.getEmail());
        model.addAttribute("otpStatus", otpStatus); // Pass to JSP
        return "verify-otp";
    }

    @PostMapping("/verify-otp")
    public String verifyOTP(@RequestParam String otp, 
                           HttpSession session, 
                           RedirectAttributes redirectAttributes) {
        try {
            User pendingUser = (User) session.getAttribute("pendingUser");
            String generatedOTP = (String) session.getAttribute("generatedOTP");
            Long otpTimestamp = (Long) session.getAttribute("otpTimestamp");
            
            if (pendingUser == null || generatedOTP == null || otpTimestamp == null) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Session expired. Please register again.");
                return "redirect:/register";
            }
            
            // Check OTP expiry (5 minutes = 300000 milliseconds)
            long currentTime = System.currentTimeMillis();
            long timeElapsed = currentTime - otpTimestamp;
            
            System.out.println("Current time: " + currentTime);
            System.out.println("OTP timestamp: " + otpTimestamp);
            System.out.println("Time elapsed: " + timeElapsed + " ms");
            System.out.println("Expected OTP: " + generatedOTP + ", Entered OTP: " + otp);
            
            if (timeElapsed > 300000) { // 5 minutes
                session.removeAttribute("pendingUser");
                session.removeAttribute("generatedOTP");
                session.removeAttribute("otpStatus");
                session.removeAttribute("otpTimestamp");
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "OTP expired after 5 minutes. Please register again.");
                return "redirect:/register";
            }
            
            // Verify OTP
            if (otp.trim().equals(generatedOTP)) {
                // Save user to database
                userService.saveUser(pendingUser);
                
                // Clear session data
                session.removeAttribute("pendingUser");
                session.removeAttribute("generatedOTP");
                session.removeAttribute("otpStatus");
                session.removeAttribute("otpTimestamp");
                
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Email verified successfully! Registration completed. You can now login.");
                return "redirect:/login";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Invalid OTP. Please check and try again.");
                return "redirect:/verify-otp";
            }
            
        } catch (Exception e) {
            System.out.println("OTP verification error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Verification failed. Please try again.");
            return "redirect:/verify-otp";
        }
    }

    @PostMapping("/resend-otp")
    public String resendOTP(HttpSession session, RedirectAttributes redirectAttributes) {
        try {
            User pendingUser = (User) session.getAttribute("pendingUser");
            if (pendingUser == null) {
                return "redirect:/register";
            }
            
            // Generate new OTP
            OTPResponse response = userService.generateAndSendOTP(pendingUser.getEmail(), pendingUser.getName());
            String newOTP = response.getOtp();
            String status = response.getStatus();
            
            // Update session
            session.setAttribute("generatedOTP", newOTP);
            session.setAttribute("otpStatus", status);
            session.setAttribute("otpTimestamp", System.currentTimeMillis());
            
            // Set UI message
            if ("EMAIL_SENT_DEMO".equals(status)) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "New OTP sent in demo mode (check console)!");
            } else if ("EMAIL_SENT_REAL".equals(status)) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "New OTP sent to your email!");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Failed to resend OTP. Please try again.");
            }
            
            return "redirect:/verify-otp";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Failed to resend OTP. Please try again.");
            return "redirect:/verify-otp";
        }
    }

    private boolean isPasswordStrong(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUppercase = password.matches(".*[A-Z].*");
        boolean hasLowercase = password.matches(".*[a-z].*");
        boolean hasNumber = password.matches(".*[0-9].*");
        boolean hasSpecial = password.matches(".*[@#$%^&*!].*");
        
        return hasUppercase && hasLowercase && hasNumber && hasSpecial;
    }

    @GetMapping("/login")
    public String showLoginForm(Model model) {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@ModelAttribute User loginRequest, 
                           HttpSession session, 
                           RedirectAttributes redirectAttributes) {
        try {
            User user = userService.findByEmail(loginRequest.getEmail());
            if (user != null && passwordEncoder.matches(loginRequest.getPassword(), user.getPassword())) {
                // Store user in session
                session.setAttribute("loggedInUser", user);
                System.out.println("Logged in user set: " + user.getEmail() + ", ID: " + user.getId());
                return "redirect:/";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Invalid email or password.");
                return "redirect:/login";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Login failed. Please try again.");
            return "redirect:/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("successMessage", 
            "You have been logged out successfully.");
        return "redirect:/";
    }

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "profile";
    }

    @GetMapping("/profile/edit")
    public String showEditProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "edit-profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute User userUpdate, 
                               HttpSession session, 
                               RedirectAttributes redirectAttributes) {
        try {
            User currentUser = (User) session.getAttribute("loggedInUser");
            if (currentUser == null) {
                return "redirect:/login";
            }

            // Check if email is being changed and if it already exists
            if (!currentUser.getEmail().equals(userUpdate.getEmail()) && 
                userService.existsByEmail(userUpdate.getEmail())) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Email already exists. Please choose a different email.");
                return "redirect:/profile/edit";
            }

            // Update user information
            currentUser.setName(userUpdate.getName());
            currentUser.setEmail(userUpdate.getEmail());
            
            // Only update password if provided
            if (userUpdate.getPassword() != null && !userUpdate.getPassword().trim().isEmpty()) {
            currentUser.setPassword(passwordEncoder.encode(userUpdate.getPassword()));
            }

            User updatedUser = userService.saveUser(currentUser);
            
            // Update session with new user data
            session.setAttribute("loggedInUser", updatedUser);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Profile updated successfully!");
            return "redirect:/profile";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Failed to update profile. Please try again.");
            return "redirect:/profile/edit";
        }
    }

    @GetMapping("/profile/delete")
    public String showDeleteConfirmation(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", user);
        return "delete-account";
    }

    @PostMapping("/profile/delete")
    public String deleteAccount(@RequestParam String confirmEmail,
                               @RequestParam String confirmPassword,
                               HttpSession session, 
                               RedirectAttributes redirectAttributes) {
        try {
            User currentUser = (User) session.getAttribute("loggedInUser");
            if (currentUser == null) {
                return "redirect:/login";
            }

            // Verify email and password for security
            if (!currentUser.getEmail().equals(confirmEmail) || 
            !passwordEncoder.matches(confirmPassword, currentUser.getPassword())) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Email or password incorrect. Account deletion cancelled.");
                return "redirect:/profile/delete";
            }

            // Delete user account
            userService.deleteUser(currentUser.getId());
            
            // Invalidate session
            session.invalidate();
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Your account has been successfully deleted. We're sorry to see you go!");
            return "redirect:/";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Failed to delete account. Please try again or contact support.");
            return "redirect:/profile/delete";
        }
    }
}
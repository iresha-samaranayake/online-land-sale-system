package com.landselling.Online_land_sales_portal.strategy;

import com.landselling.Online_land_sales_portal.entity.User;
import org.springframework.stereotype.Component;

@Component
public class StaffAuthenticationStrategy implements AuthenticationStrategy {

    @Override
    public boolean authenticate(User user, String rolePasscode) {
        return "STAFF123".equals(rolePasscode); // Example validation logic
    }

}
package com.landselling.Online_land_sales_portal.strategy;

import com.landselling.Online_land_sales_portal.entity.User;

public interface AuthenticationStrategy {
    boolean authenticate(User user, String rolePasscode);
}

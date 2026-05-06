package com.landselling.Online_land_sales_portal.Service;

import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.strategy.AuthenticationStrategy;


public class AuthenticationContext {

    private AuthenticationStrategy strategy;

    public void setStrategy(AuthenticationStrategy strategy) {
        this.strategy = strategy;
    }

    public boolean executeAuthentication(User user, String rolePasscode) {
        return strategy.authenticate(user, rolePasscode);
}
}

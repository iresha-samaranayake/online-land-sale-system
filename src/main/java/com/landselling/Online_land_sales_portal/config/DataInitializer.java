package com.landselling.Online_land_sales_portal.config;


import com.landselling.Online_land_sales_portal.Repository.RolePasscodeRepository;
import com.landselling.Online_land_sales_portal.entity.RolePasscode;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;
@Configuration
public class DataInitializer {

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    public CommandLineRunner init(RolePasscodeRepository repo, PasswordEncoder encoder) {
        return args -> {
            if (repo.findByRole("ADMIN") == null) {
                RolePasscode admin = new RolePasscode();
                admin.setRole("ADMIN");
                admin.setPasscode(passwordEncoder.encode("ADMIN123"));
                repo.save(admin);
            }

            if (repo.findByRole("STAFF") == null) {
                RolePasscode staff = new RolePasscode();
                staff.setRole("STAFF");
                staff.setPasscode(passwordEncoder.encode("STAFF123"));
                repo.save(staff);
            }
        };
    }
}
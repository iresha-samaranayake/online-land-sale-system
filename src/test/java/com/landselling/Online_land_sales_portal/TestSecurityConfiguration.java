package com.landselling.Online_land_sales_portal;
/*
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@TestConfiguration
public class TestSecurityConfiguration {


    @Bean
    public WebMvcConfigurer testWebMvcConfigurer() {
        return new WebMvcConfigurer() {
            // Simple test configuration without security
        };
    }



 */


import org.springframework.boot.test.context.TestConfiguration;

@TestConfiguration
public class TestSecurityConfiguration {
    // Commented out to avoid Spring Security compilation errors
    /*
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(authz -> authz.anyRequest().permitAll());
        return http.build();
    }
    */
}


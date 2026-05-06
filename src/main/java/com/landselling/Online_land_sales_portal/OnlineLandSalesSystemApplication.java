package com.landselling.Online_land_sales_portal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import io.github.cdimascio.dotenv.Dotenv;

@SpringBootApplication
public class OnlineLandSalesSystemApplication {

	public static void main(String[] args) {

		Dotenv dotenv = Dotenv.load();

        // Set system properties from .env
        System.setProperty("SPRING_MAIL_USERNAME", dotenv.get("SPRING_MAIL_USERNAME"));
        System.setProperty("SPRING_MAIL_PASSWORD", dotenv.get("SPRING_MAIL_PASSWORD"));
		
		System.out.println("=== Starting Online Land Sales System ===");
		SpringApplication.run(OnlineLandSalesSystemApplication.class, args);
		System.out.println("=== Application Started Successfully ===");
	}
}


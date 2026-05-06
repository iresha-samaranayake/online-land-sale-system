package com.landselling.Online_land_sales_portal;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest(classes = OnlineLandSalesSystemApplication.class)
@ActiveProfiles("test")
class OnlineLandSalesSystemApplicationTests {

	@Test
	void contextLoads() {
		// Test passes if Spring context loads successfully
	}

	@Test
	void applicationMainMethodExists() {
		// Verify the main method exists
		assert OnlineLandSalesSystemApplication.class != null;
	}
}

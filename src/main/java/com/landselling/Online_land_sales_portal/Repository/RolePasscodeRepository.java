package com.landselling.Online_land_sales_portal.Repository;

import com.landselling.Online_land_sales_portal.entity.RolePasscode;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RolePasscodeRepository extends JpaRepository<RolePasscode, Long> {
    RolePasscode findByRole(String role);
}

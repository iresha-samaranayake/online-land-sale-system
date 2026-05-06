package com.landselling.Online_land_sales_portal.Repository;

import com.landselling.Online_land_sales_portal.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    boolean existsByEmail(String email);


    //For payements
    Optional<User> findUserById(Long id);

}

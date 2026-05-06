package com.landselling.Online_land_sales_portal.entity;

import jakarta.persistence.*;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(nullable = false, unique = true)
    private String email;
    
    @Column(nullable = false)
    private String password;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Transient
    private String passcode;

    public String getPasscode() {
    return passcode;
}

public void setPasscode(String passcode) {
    this.passcode = passcode;
}

    @OneToMany(mappedBy = "reviewer", cascade = CascadeType.ALL)
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private List<Review> writtenReviews = new ArrayList<>();

    // Reviews received by this user (as a seller)
    @OneToMany(mappedBy = "seller", cascade = CascadeType.ALL)
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private List<Review> receivedReviews = new ArrayList<>();

    // Lands listed by this user (as a seller)
    @OneToMany(mappedBy = "seller")
    @EqualsAndHashCode.Exclude
    @ToString.Exclude
    private List<Land> listedLands = new ArrayList<>();


    @Column(name = "average_rating")
    private Double averageRating;


    // Default constructor
    public User() {}
    
    // Constructor with parameters
    public User(String name, String email, String password, Role role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public Double getAverageRating() { return averageRating; }
    public void setAverageRating(Double averageRating) { this.averageRating = averageRating; }

    public List<Land> getListedLands() { return listedLands; }
    public void setListedLands(List<Land> listedLands) { this.listedLands = listedLands; }

    public List<Review> getWrittenReviews() { return writtenReviews; }
    public void setWrittenReviews(List<Review> writtenReviews) { this.writtenReviews = writtenReviews; }

    public List<Review> getReceivedReviews() { return receivedReviews; }
    public void setReceivedReviews(List<Review> receivedReviews) { this.receivedReviews = receivedReviews; }
}

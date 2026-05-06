package com.landselling.Online_land_sales_portal.Service;

import com.landselling.Online_land_sales_portal.dto.LandDTO;
import com.landselling.Online_land_sales_portal.dto.LandImageDTO;
import com.landselling.Online_land_sales_portal.entity.Land;
import com.landselling.Online_land_sales_portal.entity.LandImage;
import com.landselling.Online_land_sales_portal.entity.LandStatus;
import com.landselling.Online_land_sales_portal.entity.User;
import com.landselling.Online_land_sales_portal.Repository.LandRepository;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.UUID;
import java.time.LocalDateTime;
import java.util.ArrayList;

@Service

public class LandService {

    @Autowired
    private PromotionService promotionService;

    @Autowired
    private LandRepository landRepository;

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Transactional(readOnly = false) // Explicitly set to read-write for save operation
    public void saveLand(LandDTO landDTO, User user) {
        System.out.println("Attempting to save land for user: " + user.getEmail());

        // Validate that at least one image is provided for new posts
        if (landDTO.getImages() == null || landDTO.getImages().isEmpty()) {
            throw new RuntimeException("At least one image is required to create a property listing");
        }

        // Check if there are any valid (non-empty) images
        boolean hasValidImages = landDTO.getImages().stream().anyMatch(file -> !file.isEmpty());
        if (!hasValidImages) {
            throw new RuntimeException("At least one valid image is required to create a property listing");
        }

        Land land = new Land();
        mapDTOToEntity(landDTO, land);
        land.setSeller(user);
        land.setStatus(LandStatus.PENDING);
        System.out.println("Setting status to: " + land.getStatus());
        handleImages(landDTO.getImages(), land);
        landRepository.save(land);
        System.out.println("Land saved with ID: " + land.getId());
    }

    @Transactional(readOnly = false)
    public void updateLand(Long id, LandDTO landDTO, User user) {
        System.out.println("Attempting to update land with ID: " + id + " for user: " + user.getEmail());
        Land land = landRepository.findByIdAndSeller(id, user)
                .orElseThrow(() -> new RuntimeException("Land not found or not owned by user: " + user.getEmail()));

        // Initialize images to ensure we have the current state
        Hibernate.initialize(land.getImages());
        System.out.println("Original land state - Price: " + land.getPrice() + ", Images count: " + land.getImages().size());

        mapDTOToEntity(landDTO, land);
        System.out.println("Mapped DTO to entity - Price: " + land.getPrice());

        try {
            // Only handle new images if they are provided and not empty
            if (landDTO.getImages() != null && !landDTO.getImages().isEmpty()) {
                boolean hasValidImages = landDTO.getImages().stream().anyMatch(file -> !file.isEmpty());
                if (hasValidImages) {
                    System.out.println("Adding new images to existing " + land.getImages().size() + " images");
                    handleImages(landDTO.getImages(), land);
                } else {
                    System.out.println("No valid new images provided, keeping existing images");
                }
            } else {
                System.out.println("No new images provided, keeping existing images");
            }

            // Ensure at least one image exists
            if (land.getImages().isEmpty()) {
                throw new RuntimeException("Property must have at least one image. Please add an image before updating.");
            }

            System.out.println("Final images count: " + land.getImages().size());
            landRepository.save(land);
            System.out.println("Land updated successfully with ID: " + land.getId() + ", New Price: " + land.getPrice());
        } catch (Exception e) {
            System.out.println("Error handling images or saving: " + e.getMessage());
            e.printStackTrace();
            throw e; // Re-throw to trigger rollback and error handling in controller
        }
    }

    @Transactional(readOnly = false)
    public void deleteLand(Long id, User user) {
        System.out.println("Attempting to delete land with ID: " + id + " for user: " + user.getEmail());
        Land land = landRepository.findByIdAndSeller(id, user).orElseThrow(() -> new RuntimeException("Land not found or not owned"));
        System.out.println("Land found with status: " + land.getStatus() + " (raw value: " + land.getStatus().name() + ")");
        promotionService.deletePromotion(id, user);
        landRepository.delete(land);
        System.out.println("Deletion requested, forcing flush...");
        landRepository.flush();
        System.out.println("Land deleted successfully");
    }

    @Transactional(readOnly = true)
    public List<Land> getLandsByUser(User user) {
        List<Land> lands = landRepository.findBySeller(user);
        // Initialize images for each land
        lands.forEach(land -> Hibernate.initialize(land.getImages()));
        return lands;
    }

    @Transactional(readOnly = true)
    public Land getLandByIdAndUser(Long id, User user) {
        Land land = landRepository.findByIdAndSeller(id, user).orElseThrow(() -> new RuntimeException("Land not found"));
        Hibernate.initialize(land.getImages());
        return land;
    }

    @Transactional(readOnly = true)
    public List<Land> getPendingLands() {
        return landRepository.findByStatusWithSeller(LandStatus.PENDING);
    }

    @Transactional(readOnly = false)
    public void approveLand(Long id, User approver) {
        Land land = landRepository.findById(id).orElseThrow(() -> new RuntimeException("Land not found"));
        land.setStatus(LandStatus.AVAILABLE);
        land.setApprovedBy(approver);
        land.setApprovalDate(LocalDateTime.now());
        landRepository.save(land);
        System.out.println("Land ID: " + id + " approved by user: " + (approver != null ? approver.getEmail() : "null") + " at " + land.getApprovalDate());
    }

    public void rejectLand(Long id, String reason) {
        Land land = landRepository.findById(id).orElseThrow(() -> new RuntimeException("Land not found"));
        land.setStatus(LandStatus.REJECTED);
        land.setRejectionReason(reason);
        land.setApprovedBy(null);
        land.setApprovalDate(null);
        landRepository.save(land);
    }

    private void mapDTOToEntity(LandDTO dto, Land land) {
        land.setTitle(dto.getTitle());
        land.setDescription(dto.getDescription());
        if (dto.getPrice() != null && dto.getPrice() <= 0) {
            throw new IllegalArgumentException("Price must be greater than 0");
        }
        if (dto.getPrice() != null) {
            System.out.println("Setting price to: " + dto.getPrice()); // Debug log
            land.setPrice(BigDecimal.valueOf(dto.getPrice()));
        }
        if (dto.getSize() != null && dto.getSize() <= 0) {
            throw new IllegalArgumentException("Size must be greater than 0");
        }
        if (dto.getSize() != null) {
            land.setSize(BigDecimal.valueOf(dto.getSize()));
        }
        land.setLocation(dto.getLocation());
    }

    private void handleImages(List<MultipartFile> files, Land land) {
        if (files != null) {
            Path uploadDirPath = Path.of(uploadDir);
            if (!Files.exists(uploadDirPath)) {
                try {
                    Files.createDirectories(uploadDirPath);
                    System.out.println("Created upload directory: " + uploadDirPath.toAbsolutePath());
                } catch (IOException e) {
                    System.out.println("Failed to create directory due to permissions: " + e.getMessage());
                    throw new RuntimeException("Failed to create upload directory", e);
                }
            } else if (!Files.isWritable(uploadDirPath)) {
                System.out.println("Upload directory is not writable: " + uploadDirPath.toAbsolutePath());
                throw new RuntimeException("Upload directory is not writable");
            }
            files.forEach(file -> {
                if (!file.isEmpty()) {
                    try {
                        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                        Path dest = uploadDirPath.resolve(fileName);
                        if (Files.exists(dest)) {
                            fileName = UUID.randomUUID() + "_" + file.getOriginalFilename(); // Avoid overwrite
                            dest = uploadDirPath.resolve(fileName);
                        }
                        System.out.println("Attempting to save image to: " + dest.toAbsolutePath());
                        file.transferTo(dest.toFile());
                        System.out.println("Image saved to: " + dest.toAbsolutePath());
                        LandImage image = new LandImage();
                        image.setImageUrl("/uploads/" + fileName);
                        image.setLand(land);
                        land.getImages().add(image);
                    } catch (IOException e) {
                        System.out.println("Image upload failed: " + e.getMessage());
                        throw new RuntimeException("Image upload failed", e);
                    }
                } else {
                    System.out.println("Skipping empty file: " + file.getOriginalFilename());
                }
            });
        } else {
            System.out.println("No images provided for update");
        }
    }

    public LandDTO toDTO(Land land) {
        LandDTO dto = new LandDTO();
        dto.setId(land.getId());
        dto.setTitle(land.getTitle());
        dto.setDescription(land.getDescription());
        dto.setPrice(land.getPrice() != null ? land.getPrice().doubleValue() : null);
        dto.setSize(land.getSize() != null ? land.getSize().doubleValue() : null);
        dto.setLocation(land.getLocation());

        // Convert existing images to DTOs
        List<LandImageDTO> existingImageDTOs = new ArrayList<>();
        if (land.getImages() != null) {
            for (LandImage image : land.getImages()) {
                LandImageDTO imageDTO = new LandImageDTO();
                imageDTO.setId(image.getId());
                imageDTO.setImageUrl(image.getImageUrl());
                imageDTO.setImageName(image.getImageName());
                imageDTO.setIsPrimary(image.getIsPrimary());
                existingImageDTOs.add(imageDTO);
            }
        }
        dto.setExistingImages(existingImageDTOs);

        return dto;
    }

    @Transactional(readOnly = true)
    public List<Land> getAllLands() {
        List<Land> lands = landRepository.findByStatusWithImages(LandStatus.AVAILABLE);
        lands.forEach(land -> {
            if (Hibernate.isInitialized(land.getImages())) {
                System.out.println("Images initialized for land ID: " + land.getId());
            } else {
                System.out.println("Images NOT initialized for land ID: " + land.getId());
            }
        });
        return lands;
    }

    @Transactional(readOnly = true)
    public List<Land> searchAvailableLandsByLocation(String locationQuery) {
        if (locationQuery == null || locationQuery.trim().isEmpty()) {
            return getAllLands();
        }
        return landRepository.findAvailableByLocationWithImages(LandStatus.AVAILABLE, locationQuery.trim());
    }

    @Transactional(readOnly = true)
    public List<Land> searchAvailableLandsByLocationAndSort(String locationQuery, String sortBy) {
        List<Land> lands;
        
        // Apply sorting with location filter
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy.trim()) {
                case "price_asc":
                    lands = landRepository.findAvailableLandsSortedByPriceAscWithLocation(LandStatus.AVAILABLE, locationQuery);
                    break;
                case "price_desc":
                    lands = landRepository.findAvailableLandsSortedByPriceDescWithLocation(LandStatus.AVAILABLE, locationQuery);
                    break;
                case "newest":
                    lands = landRepository.findAvailableLandsSortedByNewestWithLocation(LandStatus.AVAILABLE, locationQuery);
                    break;
                case "oldest":
                    lands = landRepository.findAvailableLandsSortedByOldestWithLocation(LandStatus.AVAILABLE, locationQuery);
                    break;
                default:
                    // No sorting applied, use the original method
                    if (locationQuery == null || locationQuery.trim().isEmpty()) {
                        lands = getAllLands();
                    } else {
                        lands = landRepository.findAvailableByLocationWithImages(LandStatus.AVAILABLE, locationQuery.trim());
                    }
                    break;
            }
        } else {
            // No sorting, just location filter
            if (locationQuery == null || locationQuery.trim().isEmpty()) {
                lands = getAllLands();
            } else {
                lands = landRepository.findAvailableByLocationWithImages(LandStatus.AVAILABLE, locationQuery.trim());
            }
        }
        
        return lands;
    }

    @Transactional(readOnly = true)
    public Land getLandById(Long id) {
        Land land = landRepository.findById(id).orElseThrow(() -> new RuntimeException("Land not found"));
        Hibernate.initialize(land.getSeller());
        Hibernate.initialize(land.getApprovedBy());
        Hibernate.initialize(land.getImages());
        return land;
    }

    @Transactional(readOnly = true)
    public long getTotalAvailableLands() {
        return landRepository.countByStatus(LandStatus.AVAILABLE);
    }

    @Transactional(readOnly = true)
    public Land getLatestApprovedLandBySeller(User seller) {
        List<Land> approvedLands = landRepository.findBySellerAndStatusOrderByCreatedAtDesc(seller, LandStatus.AVAILABLE);
        return approvedLands.isEmpty() ? null : approvedLands.get(0);
    }

    @Transactional(readOnly = false)
    public void deleteImage(Long imageId, User user) {
        System.out.println("=== DELETE IMAGE START ===");
        System.out.println("Attempting to delete image with ID: " + imageId + " for user: " + user.getEmail());

        try {
            // Find the image and verify ownership
            LandImage image = landRepository.findImageByIdAndSeller(imageId, user)
                    .orElseThrow(() -> new RuntimeException("Image not found or not owned by user"));

            System.out.println("Found image: " + image.getId() + " with URL: " + image.getImageUrl());

            // Get the land and initialize images
            Land land = image.getLand();
            Hibernate.initialize(land.getImages());

            System.out.println("Found land ID: " + land.getId() + ", current images count: " + land.getImages().size());

            // Allow deletion of all images - removed restriction
            System.out.println("Allowing deletion of image (removed minimum image restriction)");

            // Delete the physical file
            boolean fileDeleted = false;
            try {
                String imageUrl = image.getImageUrl();
                if (imageUrl != null && imageUrl.startsWith("/uploads/")) {
                    String fileName = imageUrl.substring("/uploads/".length());
                    Path filePath = Path.of(uploadDir).resolve(fileName);
                    if (Files.exists(filePath)) {
                        Files.delete(filePath);
                        fileDeleted = true;
                        System.out.println("SUCCESS: Deleted physical file: " + filePath.toAbsolutePath());
                    } else {
                        System.out.println("WARNING: Physical file not found: " + filePath.toAbsolutePath());
                    }
                } else {
                    System.out.println("WARNING: Invalid image URL format: " + imageUrl);
                }
            } catch (IOException e) {
                System.out.println("ERROR: Failed to delete physical file: " + e.getMessage());
                // Continue with database deletion even if file deletion fails
            }

            // Remove from land's image collection
            boolean removed = land.getImages().remove(image);
            System.out.println("Image removed from collection: " + removed);

            if (!removed) {
                System.out.println("ERROR: Failed to remove image from collection");
                throw new RuntimeException("Failed to remove image from collection");
            }

            // If this was the primary image, set another image as primary (if any remain)
            if (image.getIsPrimary() && !land.getImages().isEmpty()) {
                land.getImages().get(0).setIsPrimary(true);
                System.out.println("Set new primary image");
            }

            // Save the land to persist the changes
            landRepository.save(land);
            System.out.println("SUCCESS: Land saved with remaining images: " + land.getImages().size());

            System.out.println("=== DELETE IMAGE SUCCESS ===");

        } catch (Exception e) {
            System.out.println("=== DELETE IMAGE ERROR ===");
            System.out.println("Error deleting image ID " + imageId + ": " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    //For Payment Plans
    @Transactional(readOnly = true)
    public List<Land> getLandsBySellerAndStatus(Long sellerId) {
        return landRepository.findBySellerId(sellerId);
    }

}
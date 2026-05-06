package com.landselling.Online_land_sales_portal.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Data
public class LandDTO {
    private Long id; 

    @NotBlank(message = "Title is required")
    private String title;

    @NotBlank(message = "Description is required")
    private String description;

    @NotNull(message = "Price is required")
    @Min(value = 1, message = "Price must be greater than 0")
    private Double price;

    @NotNull(message = "Size is required")
    @Min(value = 1, message = "Size must be greater than 0")
    private Double size;

    @NotBlank(message = "Location is required")
    private String location;

    @NotNull(message = "At least one image is required")
    private List<MultipartFile> images;
    
    // Existing images for edit form
    private List<LandImageDTO> existingImages;
}
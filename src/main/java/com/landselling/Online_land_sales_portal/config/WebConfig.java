package com.landselling.Online_land_sales_portal.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.lang.NonNull;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        return resolver;
    }

    @Override
    public void addResourceHandlers(@NonNull ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/", "/static/");

        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/", "/css/");

        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/", "/js/");

        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/", "/images/");

        // Resolve relative path to absolute based on project root
        Path path = Paths.get(uploadDir);
        Path absolutePath;
        if (!path.isAbsolute()) {
            absolutePath = Paths.get(System.getProperty("user.dir"), uploadDir).toAbsolutePath().normalize();
        } else {
            absolutePath = path;
        }
        String uploadPath = "file:" + absolutePath.toString() + "/";
        Path localUploadsPath = Paths.get(System.getProperty("user.dir"), "uploads").toAbsolutePath().normalize();
        String localUploadsResource = "file:" + localUploadsPath.toString() + "/";
        System.out.println("Serving uploads from: " + uploadPath);
        System.out.println("Serving local project uploads from: " + localUploadsResource);
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations(uploadPath, localUploadsResource);
    }

}

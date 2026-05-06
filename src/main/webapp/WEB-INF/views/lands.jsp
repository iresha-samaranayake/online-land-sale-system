<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Lands - Online Land Sales System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');
        
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --secondary: #8b5cf6;
            --accent: #f59e0b;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --info: #06b6d4;
            --dark: #0f172a;
            --light: #f8fafc;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            line-height: 1.6;
            color: var(--gray-800);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Glassmorphism Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1rem 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.75rem;
            color: white !important;
            text-decoration: none;
            letter-spacing: -0.025em;
        }

        .navbar.scrolled .navbar-brand {
            color: var(--primary) !important;
        }

        .nav-link {
            font-weight: 600;
            color: rgba(255, 255, 255, 0.9) !important;
            padding: 0.75rem 1.5rem !important;
            border-radius: 50px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .navbar.scrolled .nav-link {
            color: var(--gray-600) !important;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .navbar.scrolled .nav-link:hover, .navbar.scrolled .nav-link.active {
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary) !important;
        }

        /* Futuristic Hero Section */
        .hero-section {
            min-height: 60vh;
            display: flex;
            align-items: center;
            position: relative;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow: hidden;
            margin-top: 80px;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(120, 119, 198, 0.2) 0%, transparent 50%);
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(1deg); }
        }

        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
        }

        .hero-section h1 {
            font-weight: 900;
            font-size: clamp(2.5rem, 6vw, 4rem);
            line-height: 1.1;
            margin-bottom: 2rem;
            background: linear-gradient(135deg, #ffffff 0%, #e0e7ff 50%, #c7d2fe 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: glow 2s ease-in-out infinite alternate;
        }

        @keyframes glow {
            from { filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.3)); }
            to { filter: drop-shadow(0 0 30px rgba(255, 255, 255, 0.6)); }
        }

        .hero-section .lead {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 0;
            font-weight: 400;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Futuristic Search Section */
        .search-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            padding: 4rem 0;
            position: relative;
            overflow: hidden;
        }

        .search-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="searchPattern" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="2" fill="rgba(99,102,241,0.1)"/><circle cx="5" cy="5" r="1" fill="rgba(139,92,246,0.1)"/><circle cx="15" cy="15" r="1" fill="rgba(139,92,246,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23searchPattern)"/></svg>');
            animation: searchMove 15s linear infinite;
        }

        @keyframes searchMove {
            0% { transform: translateX(0) translateY(0); }
            100% { transform: translateX(-20px) translateY(-20px); }
        }

        .search-form {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 2rem;
            padding: 3rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            z-index: 2;
        }

        .search-form h2 {
            font-weight: 900;
            color: var(--gray-800);
            font-size: 2rem;
            margin-bottom: 1rem;
            text-align: center;
        }

        .search-form p {
            color: var(--gray-600);
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.125rem;
        }

        .form-control {
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 50px;
            padding: 1rem 1.5rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            background: white;
            transform: translateY(-2px);
        }


        select.form-control option {
            padding: 0.5rem;
            background: white;
            color: var(--gray-800);
        }


        /* Sort container styling */
        .sort-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .sort-icon {
            position: absolute;
            left: 1rem;
            color: var(--primary);
            font-size: 1rem;
            z-index: 10;
            pointer-events: none;
        }

        .sort-container select.form-control {
            padding-left: 3rem;
        }

        /* Futuristic Buttons */
        .btn {
            font-weight: 700;
            border-radius: 50px;
            padding: 1rem 2rem;
            font-size: 1rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            min-width: 120px;
            white-space: nowrap;
        }

        .btn i {
            margin-right: 0.5rem;
        }

        /* Responsive button adjustments */
        @media (max-width: 768px) {
            .btn {
                min-width: 100px;
                font-size: 0.875rem;
                padding: 0.75rem 1rem;
            }
            
            .btn i {
                margin-right: 0.25rem;
            }
        }

        @media (max-width: 576px) {
            .btn {
                min-width: 80px;
                font-size: 0.8rem;
                padding: 0.6rem 0.8rem;
            }
            
            .btn i {
                margin-right: 0.2rem;
            }
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.6);
            background: linear-gradient(135deg, #4f46e5 0%, #7c3aed 100%);
        }

        .btn-outline-secondary {
            border: 2px solid rgba(99, 102, 241, 0.3);
            color: var(--primary);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-secondary:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.2);
        }

        /* Professional Land Cards */
        .lands-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 2rem;
            padding: 3rem 0;
            max-width: 1200px;
            margin: 0 auto;
        }

        .land-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05), 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 1px solid #e5e7eb;
            position: relative;
        }

        .land-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1), 0 4px 10px rgba(0, 0, 0, 0.05);
            border-color: #d1d5db;
        }

        .land-image {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
            background: #f9fafb;
        }

        .land-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .land-card:hover .land-image img {
            transform: scale(1.05);
        }

        .land-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            display: flex;
            align-items: flex-end;
            padding: 1.5rem;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .land-card:hover .land-overlay {
            opacity: 1;
        }

        .land-body {
            padding: 1.5rem;
            background: white;
        }

        .land-title {
            font-weight: 600;
            color: #111827;
            font-size: 1.25rem;
            margin-bottom: 0.75rem;
            line-height: 1.4;
        }

        .land-location {
            color: #6b7280;
            font-size: 0.875rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
        }

        .land-location::before {
            content: '📍';
            font-size: 0.875rem;
        }

        /* Professional Details Grid */
        .land-details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 0.75rem;
            margin: 1rem 0;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem;
            background: #f9fafb;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
        }

        .detail-icon {
            width: 32px;
            height: 32px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.875rem;
            color: white;
            background: #6366f1;
            flex-shrink: 0;
        }

        .price-icon {
            background: #10b981;
        }

        .size-icon {
            background: #f59e0b;
        }

        .detail-content {
            display: flex;
            flex-direction: column;
            gap: 0.125rem;
            flex: 1;
        }

        .detail-label {
            font-size: 0.75rem;
            font-weight: 500;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .detail-value {
            font-size: 0.875rem;
            font-weight: 600;
            color: #111827;
        }

        .price-item .detail-value {
            color: #10b981;
            font-size: 1rem;
            font-weight: 700;
        }

        /* Professional Action Button */
        .land-actions {
            margin-top: 1.25rem;
            display: flex;
            justify-content: center;
        }

        .btn-view-details {
            background: #6366f1;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            font-size: 0.875rem;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            width: 100%;
            justify-content: center;
        }

        .btn-view-details:hover {
            background: #4f46e5;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
            color: white;
        }


        /* Futuristic Alert */
        .alert {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            border: 1px solid rgba(6, 182, 212, 0.2);
            padding: 2rem;
            font-weight: 600;
            font-size: 1.125rem;
            color: var(--info);
            text-align: center;
            box-shadow: 0 10px 30px rgba(6, 182, 212, 0.1);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .hero-section {
                min-height: 50vh;
            }
            
            .lands-container {
                grid-template-columns: 1fr;
                gap: 1.5rem;
                padding: 2rem 1rem;
            }
            
            .search-form {
                padding: 2rem;
                margin: 0 1rem;
            }

            .land-details-grid {
                grid-template-columns: 1fr;
                gap: 0.5rem;
            }
        }

        @media (max-width: 576px) {
            .hero-section h1 {
                font-size: 2rem;
            }
            
            .land-image {
                height: 180px;
            }
            
            .search-form {
                padding: 1.5rem;
            }

            .land-body {
                padding: 1rem;
            }

            .detail-item {
                padding: 0.5rem;
            }
        }

        /* Animation Classes */
        .fade-in {
            animation: fadeInUp 0.8s ease-out;
        }

        .slide-up {
            animation: slideUp 1s ease-out;
        }

        @keyframes fadeInUp {
            from { 
                opacity: 0;
                transform: translateY(60px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideUp {
            from { 
                opacity: 0;
                transform: translateY(80px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Scroll animations */
        .animate-on-scroll {
            opacity: 0;
            transform: translateY(50px);
            transition: all 0.8s ease-out;
        }

        .animate-on-scroll.animated {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="/">
            <i class="fas fa-map-marked-alt me-2"></i>Land Sales Portal
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/">Home</a>
                <a class="nav-link active" href="/lands">Browse Lands</a>
                <c:if test="${not empty loggedInUser}">
                    <a class="nav-link" href="/dashboard">Dashboard</a>
                </c:if>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container hero-content">
        <h1 class="slide-up">Explore Available Lands</h1>
        <p class="lead">Discover a wide range of properties for sale across various locations.</p>
    </div>
</section>

<!-- Search Section -->
<section class="search-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="search-form">
                    <h2 class="text-center mb-4" style="color: var(--text-primary); font-weight: 700;">${message}</h2>
                    <p class="text-center text-muted mb-4">Here you will see available lands for sale.</p>

                    <form method="get" action="/lands" class="row g-3">
                        <div class="col-md-3">
                            <input type="text" name="location" value="${fn:escapeXml(location)}" class="form-control" placeholder="Search location">
                        </div>
                        <div class="col-md-3">
                            <div class="sort-container">
                                <i class="fas fa-sort-amount-down sort-icon"></i>
                                <select name="sortBy" class="form-control" onchange="this.form.submit()">
                                    <option value="">Sort by Price</option>
                                    <option value="price_asc" ${sortBy == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                                    <option value="price_desc" ${sortBy == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                                    <option value="newest" ${sortBy == 'newest' ? 'selected' : ''}>Newest First</option>
                                    <option value="oldest" ${sortBy == 'oldest' ? 'selected' : ''}>Oldest First</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3 d-grid">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                        <div class="col-md-3 d-grid">
                            <a href="/lands" class="btn btn-outline-secondary">
                                <i class="fas fa-refresh"></i> Reset
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <div class="lands-container">
        <c:if test="${empty lands}">
            <div class="alert alert-info text-center">No lands found<c:if test='${not empty location}'> for "${fn:escapeXml(location)}"</c:if>.</div>
        </c:if>
        <c:forEach items="${lands}" var="land">
            <div class="land-card fade-in">
                <div class="land-image">
                    <c:if test="${not empty land.images and fn:length(land.images) > 0}">
                        <img src="${land.images[0].imageUrl}" alt="${land.title} Image">
                    </c:if>
                    <div class="land-overlay">
                        <a href="/lands/details/${land.id}" class="btn btn-primary">View Details</a>
                    </div>
                </div>
                <div class="land-body">
                    <h5 class="land-title">${land.title}</h5>
                    
                    <!-- Enhanced Details Grid -->
                    <div class="land-details-grid">
                        <div class="detail-item">
                            <div class="detail-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            <div class="detail-content">
                                <span class="detail-label">Location</span>
                                <span class="detail-value">${land.location}</span>
                            </div>
                        </div>
                        
                        <div class="detail-item price-item">
                            <div class="detail-icon price-icon">
                                <i class="fas fa-tag"></i>
                            </div>
                            <div class="detail-content">
                                <span class="detail-label">Price per Perch</span>
                                <span class="detail-value">LKR <fmt:formatNumber value="${land.price}" type="number" groupingUsed="true" maxFractionDigits="0"/></span>
                            </div>
                        </div>
                        
                        <c:if test="${not empty land.size}">
                        <div class="detail-item size-item">
                            <div class="detail-icon size-icon">
                                <i class="fas fa-expand-arrows-alt"></i>
                            </div>
                            <div class="detail-content">
                                <span class="detail-label">Size</span>
                                <span class="detail-value">${land.size} perches</span>
                            </div>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Navbar scroll effect
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animated');
            }
        });
    }, observerOptions);

    // Observe all elements with animate-on-scroll class
    document.querySelectorAll('.animate-on-scroll').forEach(el => {
        observer.observe(el);
    });

    // Add stagger effect to land cards
    const landCards = document.querySelectorAll('.land-card');
    landCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });

    // Parallax effect for hero section
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const heroSection = document.querySelector('.hero-section');
        if (heroSection) {
            heroSection.style.transform = `translateY(${scrolled * 0.3}px)`;
        }
    });

    // Add hover sound effect (optional)
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(button => {
        button.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px) scale(1.05)';
        });
        
        button.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    // Add floating animation to cards
    landCards.forEach((card, index) => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-20px) scale(1.02)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    // Enhanced sorting functionality
    const sortSelect = document.querySelector('select[name="sortBy"]');
    if (sortSelect) {
        sortSelect.addEventListener('change', function() {
            // Add loading state
            const form = this.closest('form');
            const submitBtn = form.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sorting...';
            submitBtn.disabled = true;
            
            // Submit form
            form.submit();
        });
    }

    // Add visual feedback for current sort
    const currentSort = '${sortBy}';
    if (currentSort) {
        const sortIcon = document.querySelector('.sort-icon');
        if (sortIcon) {
            switch(currentSort) {
                case 'price_asc':
                    sortIcon.className = 'fas fa-sort-amount-down-alt sort-icon';
                    break;
                case 'price_desc':
                    sortIcon.className = 'fas fa-sort-amount-down sort-icon';
                    break;
                case 'newest':
                    sortIcon.className = 'fas fa-clock sort-icon';
                    break;
                case 'oldest':
                    sortIcon.className = 'fas fa-history sort-icon';
                    break;
            }
        }
    }
});
</script>
</body>
</html>
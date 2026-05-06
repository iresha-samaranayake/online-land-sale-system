<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Land Sales System</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow: hidden;
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

        /* Floating Elements */
        .floating-elements {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .floating-circle {
            position: absolute;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.3) 0%, rgba(139, 92, 246, 0.3) 100%);
            animation: floatUpDown 6s ease-in-out infinite;
        }

        .circle-1 {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .circle-2 {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 15%;
            animation-delay: 2s;
        }

        .circle-3 {
            width: 60px;
            height: 60px;
            top: 40%;
            left: 80%;
            animation-delay: 4s;
        }

        .floating-triangle {
            position: absolute;
            width: 0;
            height: 0;
            animation: floatRotate 8s ease-in-out infinite;
        }

        .triangle-1 {
            border-left: 30px solid transparent;
            border-right: 30px solid transparent;
            border-bottom: 50px solid rgba(99, 102, 241, 0.4);
            top: 30%;
            right: 20%;
            animation-delay: 1s;
        }

        .triangle-2 {
            border-left: 25px solid transparent;
            border-right: 25px solid transparent;
            border-bottom: 40px solid rgba(139, 92, 246, 0.4);
            top: 70%;
            left: 20%;
            animation-delay: 3s;
        }

        .floating-square {
            position: absolute;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.2) 0%, rgba(139, 92, 246, 0.2) 100%);
            animation: floatRotate 10s ease-in-out infinite;
        }

        .square-1 {
            width: 50px;
            height: 50px;
            top: 15%;
            right: 30%;
            animation-delay: 2.5s;
        }

        .square-2 {
            width: 70px;
            height: 70px;
            top: 50%;
            left: 5%;
            animation-delay: 5s;
        }

        @keyframes floatUpDown {
            0%, 100% { 
                transform: translateY(0px) rotate(0deg);
                opacity: 0.7;
            }
            50% { 
                transform: translateY(-30px) rotate(180deg);
                opacity: 1;
            }
        }

        @keyframes floatRotate {
            0%, 100% { 
                transform: translateY(0px) rotate(0deg) scale(1);
                opacity: 0.6;
            }
            50% { 
                transform: translateY(-20px) rotate(180deg) scale(1.1);
                opacity: 0.9;
            }
        }

        .hero-section h1 {
            font-weight: 900;
            font-size: clamp(3rem, 8vw, 6rem);
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
            font-size: 1.5rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 3rem;
            font-weight: 400;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Futuristic Buttons */
        .btn {
            font-weight: 700;
            border-radius: 50px;
            padding: 1rem 2.5rem;
            font-size: 1.125rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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

        .btn-outline-light {
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-light:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(255, 255, 255, 0.2);
        }

        /* Futuristic Hexagonal Grid */
        .features-section {
            padding: 8rem 0;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
            position: relative;
            overflow: hidden;
        }

        .features-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="hexagons" width="30" height="30" patternUnits="userSpaceOnUse"><polygon points="15,5 25,10 25,20 15,25 5,20 5,10" fill="none" stroke="rgba(99,102,241,0.3)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23hexagons)"/></svg>');
            animation: hexagonMove 20s linear infinite;
        }

        @keyframes hexagonMove {
            0% { transform: translateX(0) translateY(0); }
            100% { transform: translateX(-30px) translateY(-30px); }
        }

        .hexagon-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 3rem;
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .hexagon-item {
            position: relative;
            height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .hexagon-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.1) 0%, rgba(139, 92, 246, 0.1) 100%);
            clip-path: polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%);
            transition: all 0.6s ease;
            border: 2px solid rgba(99, 102, 241, 0.3);
        }

        .hexagon-item:hover::before {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.3) 0%, rgba(139, 92, 246, 0.3) 100%);
            border-color: rgba(99, 102, 241, 0.6);
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.4);
        }

        .hexagon-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
            padding: 2rem;
        }

        .hexagon-content i {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            display: block;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: hexagonPulse 3s ease-in-out infinite;
        }

        @keyframes hexagonPulse {
            0%, 100% { 
                transform: scale(1) rotate(0deg);
                filter: drop-shadow(0 0 10px rgba(99, 102, 241, 0.5));
            }
            50% { 
                transform: scale(1.2) rotate(180deg);
                filter: drop-shadow(0 0 20px rgba(99, 102, 241, 0.8));
            }
        }

        .hexagon-content h5 {
            font-weight: 800;
            color: white;
            margin-bottom: 1rem;
            font-size: 1.25rem;
            letter-spacing: -0.025em;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .hexagon-content p {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1rem;
            line-height: 1.6;
            font-weight: 400;
        }

        .hexagon-item:hover {
            transform: translateY(-20px);
        }

        .hexagon-item:hover .hexagon-content i {
            animation-duration: 1s;
        }

        /* Futuristic Stats Section */
        .stats-section {
            background: linear-gradient(135deg, var(--dark) 0%, var(--gray-800) 100%);
            padding: 6rem 0;
            position: relative;
            overflow: hidden;
        }

        .stats-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="circuit" width="40" height="40" patternUnits="userSpaceOnUse"><path d="M20,0 L20,20 L0,20 L0,40 L40,40 L40,20 L20,20" fill="none" stroke="rgba(99,102,241,0.2)" stroke-width="1"/></pattern></defs><rect width="100" height="100" fill="url(%23circuit)"/></svg>');
            animation: circuitMove 20s linear infinite;
        }

        @keyframes circuitMove {
            0% { transform: translateX(0) translateY(0); }
            100% { transform: translateX(-40px) translateY(-40px); }
        }

        .stats-content {
            position: relative;
            z-index: 2;
            color: white;
        }

        .stats-section h3 {
            font-weight: 900;
            font-size: 4rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: countUp 2s ease-out;
        }

        @keyframes countUp {
            from { transform: scale(0.5); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .stats-section p {
            color: rgba(255, 255, 255, 0.8);
            font-weight: 600;
            font-size: 1.25rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Futuristic CTA Section */
        .cta-section {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #ec4899 100%);
            padding: 6rem 0;
            position: relative;
            overflow: hidden;
        }

        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="stars" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="rgba(255,255,255,0.3)"/><circle cx="5" cy="5" r="0.5" fill="rgba(255,255,255,0.2)"/><circle cx="15" cy="15" r="0.5" fill="rgba(255,255,255,0.2)"/></pattern></defs><rect width="100" height="100" fill="url(%23stars)"/></svg>');
            animation: twinkle 3s ease-in-out infinite;
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 0.8; }
        }

        .cta-content {
            position: relative;
            z-index: 2;
            color: white;
            text-align: center;
        }

        .cta-content h2 {
            font-weight: 900;
            font-size: 3rem;
            margin-bottom: 1.5rem;
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        .cta-content .lead {
            font-size: 1.5rem;
            margin-bottom: 3rem;
            opacity: 0.9;
        }

        /* Futuristic Footer */
        footer {
            background: var(--dark);
            color: white;
            padding: 4rem 0 2rem;
            position: relative;
        }

        footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(99, 102, 241, 0.5), transparent);
        }

        footer h5 {
            font-weight: 800;
            margin-bottom: 1.5rem;
            color: white;
            font-size: 1.5rem;
        }

        footer p {
            color: rgba(255, 255, 255, 0.7);
            font-weight: 400;
        }

        /* User Info Styling */
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem 1.5rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        .navbar.scrolled .user-info {
            background: rgba(99, 102, 241, 0.1);
            border-color: rgba(99, 102, 241, 0.2);
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 800;
            font-size: 1.125rem;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 3rem;
            }
            
            .hero-section .lead {
                font-size: 1.25rem;
            }
            
            .feature-card {
                margin-bottom: 2rem;
                padding: 2rem 1.5rem;
            }
            
            .stats-section h3 {
                font-size: 3rem;
            }
            
            .cta-content h2 {
                font-size: 2.5rem;
            }
        }

        @media (max-width: 576px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .btn {
                padding: 0.875rem 2rem;
                font-size: 1rem;
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
<c:if test="${not empty loggedInUser && loggedInUser.role == 'STAFF'}">
    <script>
        (function(){
            if (window.location.pathname === '/' || window.location.pathname === '/index' ) {
                window.location.replace('/dashboard');
            }
        })();
    </script>
    
</c:if>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container">
        <a class="navbar-brand text-primary" href="/">
            <i class="fas fa-map-marked-alt"></i> LandSales Portal
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lands">Browse Lands</a>
                </li>
                <!-- Only show Dashboard link for logged-in users -->
                <c:if test="${not empty loggedInUser}">
                    <li class="nav-item">
                        <a class="nav-link" href="/dashboard">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                </c:if>
            </ul>

            <!-- User Authentication Section -->
            <div class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty loggedInUser}">
                        <!-- Logged in user section -->
                        <div class="user-info me-3">
                            <div class="user-avatar">
                                    ${loggedInUser.name.substring(0,1).toUpperCase()}
                            </div>
                            <div>
                                <div class="fw-bold">${loggedInUser.name}</div>
                                <small class="text-muted">${loggedInUser.role.displayName}</small>
                            </div>
                        </div>

                        <!-- Profile and Logout buttons -->
                        <div class="btn-group" role="group">
                            <a href="/profile" class="btn btn-outline-primary">
                                <i class="fas fa-user"></i> Profile
                            </a>
                            <a href="/logout" class="btn btn-danger">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Not logged in section -->
                        <div class="btn-group" role="group">
                            <a href="/login" class="btn btn-outline-primary me-2">
                                <i class="fas fa-sign-in-alt"></i> Login
                            </a>
                            <a href="/register" class="btn btn-primary">
                                <i class="fas fa-user-plus"></i> Register
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- Success/Error Messages -->
<c:if test="${not empty successMessage}">
    <div class="alert alert-success alert-dismissible fade show mt-5 pt-5" role="alert">
        <div class="container">
            <i class="fas fa-check-circle"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</c:if>

<!-- Hero Section -->
<section class="hero-section">
    <!-- Floating Elements -->
    <div class="floating-elements">
        <div class="floating-circle circle-1"></div>
        <div class="floating-circle circle-2"></div>
        <div class="floating-circle circle-3"></div>
        <div class="floating-triangle triangle-1"></div>
        <div class="floating-triangle triangle-2"></div>
        <div class="floating-square square-1"></div>
        <div class="floating-square square-2"></div>
    </div>
    
    <div class="container">
        <div class="hero-content">
                <c:choose>
                    <c:when test="${not empty loggedInUser}">
                    <h1 class="slide-up">Welcome back, ${loggedInUser.name}!</h1>
                    <p class="lead">
                            Ready to explore land opportunities? Browse our latest properties or manage your account from your personalized dashboard.
                        </p>
                    </c:when>
                    <c:otherwise>
                    <h1 class="slide-up">Find Your Perfect Land</h1>
                    <p class="lead">${message}</p>
                    </c:otherwise>
                </c:choose>

            <div class="d-flex gap-4 flex-wrap justify-content-center">
                <a href="/lands" class="btn btn-primary">
                        <i class="fas fa-search"></i> Browse Lands
                    </a>
                    <c:choose>
                        <c:when test="${not empty loggedInUser}">
                            <!-- Role-specific dashboard button -->
                            <c:choose>
                                <c:when test="${loggedInUser.role == 'ADMIN'}">
                                <a href="/dashboard" class="btn btn-outline-light">
                                        <i class="fas fa-shield-alt"></i> Admin Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${loggedInUser.role == 'SELLER'}">
                                <a href="/dashboard" class="btn btn-outline-light">
                                        <i class="fas fa-user-tie"></i> Seller Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${loggedInUser.role == 'BUYER'}">
                                <a href="/dashboard" class="btn btn-outline-light">
                                        <i class="fas fa-user"></i> Buyer Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${loggedInUser.role == 'STAFF'}">
                                <a href="/dashboard" class="btn btn-outline-light">
                                        <i class="fas fa-users"></i> Staff Dashboard
                                    </a>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <!-- Get Started button for non-logged users -->
                        <a href="/register" class="btn btn-outline-light">
                                <i class="fas fa-user-plus"></i> Get Started
                            </a>
                        </c:otherwise>
                    </c:choose>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="features-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold animate-on-scroll" style="font-size: 3rem; font-weight: 900; color: white; margin-bottom: 1rem; text-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);">Why Choose Our Platform?</h2>
            <p class="animate-on-scroll" style="font-size: 1.25rem; color: rgba(255, 255, 255, 0.8); font-weight: 500;">We provide comprehensive land management solutions</p>
        </div>

        <!-- Hexagonal Grid Layout -->
        <div class="hexagon-grid">
            <div class="hexagon-item animate-on-scroll">
                <div class="hexagon-content">
                    <i class="fas fa-shield-alt"></i>
                    <h5>Secure Transactions</h5>
                    <p>Advanced encryption & verification</p>
                </div>
            </div>

            <div class="hexagon-item animate-on-scroll">
                <div class="hexagon-content">
                    <i class="fas fa-map-marked"></i>
                    <h5>Verified Properties</h5>
                    <p>Thoroughly documented listings</p>
                </div>
            </div>

            <div class="hexagon-item animate-on-scroll">
                <div class="hexagon-content">
                    <i class="fas fa-credit-card"></i>
                    <h5>Flexible Payment</h5>
                    <p>Multiple payment options</p>
                </div>
            </div>

            <div class="hexagon-item animate-on-scroll">
                <div class="hexagon-content">
                    <i class="fas fa-star"></i>
                    <h5>Featured Listings</h5>
                    <p>Premium visibility</p>
                </div>
            </div>

            <div class="hexagon-item animate-on-scroll">
                <div class="hexagon-content">
                    <i class="fas fa-calendar-check"></i>
                    <h5>Easy Booking</h5>
                    <p>Instant confirmation</p>
                </div>
            </div>

            <div class="hexagon-item animate-on-scroll">
                <div class="hexagon-content">
                    <i class="fas fa-comments"></i>
                    <h5>Reviews & Feedback</h5>
                    <p>Genuine user reviews</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="container">
        <div class="row text-center stats-content">
            <div class="col-md-3">
                <h3 class="animate-on-scroll">1,500+</h3>
                <p class="animate-on-scroll">Properties Listed</p>
            </div>
            <div class="col-md-3">
                <h3 class="animate-on-scroll">850+</h3>
                <p class="animate-on-scroll">Happy Customers</p>
            </div>
            <div class="col-md-3">
                <h3 class="animate-on-scroll">95%</h3>
                <p class="animate-on-scroll">Success Rate</p>
            </div>
            <div class="col-md-3">
                <h3 class="animate-on-scroll">24/7</h3>
                <p class="animate-on-scroll">Support Available</p>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <div class="container text-center cta-content">
        <h2 class="fw-bold mb-3">Ready to Find Your Land?</h2>
        <p class="lead mb-4">Join thousands of satisfied customers who found their perfect property with us.</p>
        <c:choose>
            <c:when test="${not empty loggedInUser}">
                <a href="/lands" class="btn btn-light btn-lg me-3">
                    <i class="fas fa-search"></i> Explore More Properties
                </a>
                <a href="/dashboard" class="btn btn-outline-light btn-lg">
                    <i class="fas fa-tachometer-alt"></i> Go to Dashboard
                </a>
            </c:when>
            <c:otherwise>
                <a href="/register" class="btn btn-light btn-lg me-3">
                    <i class="fas fa-user-plus"></i> Register Now
                </a>
                <a href="/lands" class="btn btn-outline-light btn-lg">
                    <i class="fas fa-search"></i> Browse Properties
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5><i class="fas fa-map-marked-alt"></i> LandSales Portal</h5>
                <p class="text-muted">Your trusted partner in land acquisition and sales.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <p class="text-muted">&copy; 2024 Online Land Sales System. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>

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

    // Add stagger effect to feature cards
    const featureCards = document.querySelectorAll('.feature-card');
    featureCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });

    // Parallax effect for hero section
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const heroSection = document.querySelector('.hero-section');
        if (heroSection) {
            heroSection.style.transform = `translateY(${scrolled * 0.5}px)`;
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
});
</script>
</body>
</html>
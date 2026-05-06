<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- Last updated: Modern UI Redesign --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Pending Lands | Online Land Sales System</title>
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
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1rem 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.75rem;
            color: var(--primary) !important;
            text-decoration: none;
            letter-spacing: -0.025em;
        }

        .nav-link {
            font-weight: 600;
            color: var(--gray-600) !important;
            padding: 0.75rem 1.5rem !important;
            border-radius: 50px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-link:hover {
            background: rgba(99, 102, 241, 0.1);
            transform: translateY(-2px);
            color: var(--primary) !important;
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

        /* User Avatar */
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

        /* Futuristic Hero Section */
        .hero-section {
            min-height: 50vh;
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

        .hero-section h1 {
            font-weight: 900;
            font-size: clamp(2.5rem, 6vw, 4rem);
            line-height: 1.1;
            margin-bottom: 1rem;
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

        .hero-section p {
            font-size: 1.25rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 400;
        }

        /* Futuristic Cards */
        .card-land {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            overflow: hidden;
            position: relative;
        }

        .card-land::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
        }

        .card-land:hover::before {
            opacity: 1;
        }

        .card-land:hover {
            transform: translateY(-10px) scale(1.01);
            box-shadow: 0 40px 80px rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .card-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 2rem;
            border-radius: 2rem 2rem 0 0;
            position: relative;
            z-index: 2;
        }

        .card-header h2 {
            font-weight: 900;
            font-size: 2rem;
            margin-bottom: 0;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .card-body {
            position: relative;
            z-index: 2;
        }

        /* Pending Land Cards */
        .pending-land-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 1.5rem;
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
            margin-bottom: 2rem;
        }

        .pending-land-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
        }

        .pending-land-card:hover::before {
            opacity: 1;
        }

        .pending-land-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .pending-land-card .card-body {
            position: relative;
            z-index: 2;
            padding: 2rem;
        }

        .land-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--gray-800);
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .land-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .info-item {
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
            padding: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .info-item:hover {
            background: rgba(99, 102, 241, 0.1);
            transform: translateY(-2px);
        }

        .info-label {
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--gray-500);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .info-label i {
            color: var(--primary);
            margin-right: 0.5rem;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 700;
            color: var(--gray-800);
        }

        .land-description {
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .land-description p {
            margin: 0;
            color: var(--gray-700);
            line-height: 1.6;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            font-weight: 700;
            border-radius: 50px;
            padding: 0.75rem 2rem;
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

        .btn-success {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.4);
        }

        .btn-success:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 20px 40px rgba(16, 185, 129, 0.6);
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(239, 68, 68, 0.4);
        }

        .btn-danger:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 20px 40px rgba(239, 68, 68, 0.6);
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid var(--primary);
            color: var(--primary);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary-dark);
            transform: translateY(-3px) scale(1.05);
            color: var(--primary-dark);
        }

        /* Rejection Form */
        .rejection-form {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            padding: 1.5rem;
            margin-top: 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            display: none;
        }

        .rejection-form.show {
            display: block;
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-control {
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 1rem;
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

        /* Alert Messages */
        .alert {
            border-radius: 1rem;
            border: none;
            backdrop-filter: blur(20px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        /* Stats Section */
        .stats-section {
            background: linear-gradient(135deg, var(--dark) 0%, var(--gray-800) 100%);
            padding: 4rem 0;
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

        .stats-section h3 {
            font-weight: 900;
            font-size: 3rem;
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
            font-size: 1.125rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Footer */
        footer {
            background: var(--dark);
            color: white;
            padding: 3rem 0 2rem;
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

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .hero-section {
                min-height: 40vh;
            }
            
            .land-info-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
        }

        @media (max-width: 576px) {
            .action-buttons {
                gap: 0.5rem;
            }
            
            .btn {
                padding: 0.5rem 1.5rem;
                font-size: 0.9rem;
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

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--gray-400);
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: var(--gray-600);
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: var(--gray-500);
        }
    </style>
</head>
<body>
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
                    <a class="nav-link" href="/">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/lands">Browse Lands</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/admin/pending">Admin Dashboard</a>
                </li>
            </ul>
            <div class="navbar-nav align-items-center">
                <c:choose>
                    <c:when test="${not empty loggedInUser}">
                        <!-- On lg and up show avatar + name + buttons; on smaller screens collapse into dropdown -->
                        <div class="d-none d-lg-flex align-items-center me-2">
                            <div class="user-avatar">${loggedInUser.name.substring(0,1).toUpperCase()}</div>
                            <div class="me-3">
                                <div class="fw-bold small mb-0">${loggedInUser.name}</div>
                                <small class="text-muted">${loggedInUser.role.displayName}</small>
                            </div>
                            <a href="/profile" class="btn btn-sm btn-outline-primary me-1">
                                <i class="fas fa-user"></i>
                            </a>
                            <a href="/logout" class="btn btn-sm btn-danger">
                                <i class="fas fa-sign-out-alt"></i>
                            </a>
                        </div>

                        <!-- Compact dropdown for small screens -->
                        <div class="d-lg-none">
                            <div class="dropdown">
                                <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="userMenu" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="user-avatar me-1">${loggedInUser.name.substring(0,1).toUpperCase()}</span>
                                    <span class="small">${loggedInUser.name}</span>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userMenu">
                                    <li><a class="dropdown-item" href="/profile"><i class="fas fa-user me-2"></i>Profile</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger" href="/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                                </ul>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="d-none d-lg-flex">
                            <a href="/login" class="btn btn-sm btn-outline-primary me-2">
                                <i class="fas fa-sign-in-alt"></i> Login
                            </a>
                            <a href="/register" class="btn btn-sm btn-primary">
                                <i class="fas fa-user-plus"></i> Register
                            </a>
                        </div>
                        <div class="d-lg-none">
                            <div class="btn-group">
                                <a href="/login" class="btn btn-sm btn-outline-primary">Login</a>
                                <a href="/register" class="btn btn-sm btn-primary">Register</a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<!-- Wrap page content and footer in a flex container so footer stays at bottom -->
<div class="site-wrapper">
    <main class="site-main">

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12 text-center">
                    <h1 class="display-4 fw-bold mb-4">Admin Dashboard</h1>
                    <p class="lead mb-4">
                        Review and manage pending land listings awaiting approval.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content Section -->
    <section class="py-5">
        <div class="container">
            <!-- Display Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show fade-in">
                    <i class="fas fa-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show fade-in">
                    <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Pending Lands Cards -->
            <c:choose>
                <c:when test="${not empty pendingLands}">
                    <div class="row">
                        <c:forEach items="${pendingLands}" var="land">
                            <div class="col-12">
                                <div class="pending-land-card animate-on-scroll">
                                    <div class="card-body">
                                        <h3 class="land-title">${land.title}</h3>
                                        
                                        <div class="land-info-grid">
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-map-marker-alt"></i> Location
                                                </div>
                                                <div class="info-value">${land.location}</div>
                                            </div>
                                            
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-expand-arrows-alt"></i> Size
                                                </div>
                                                <div class="info-value">${land.size} perches</div>
                                            </div>
                                            
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-tag"></i> Price per Perch
                                                </div>
                                                <div class="info-value">LKR <fmt:formatNumber value="${land.price}" type="number" groupingUsed="true" maxFractionDigits="0"/></div>
                                            </div>
                                            
                                            <div class="info-item">
                                                <div class="info-label">
                                                    <i class="fas fa-user"></i> Seller
                                                </div>
                                                <div class="info-value">${land.seller.name}</div>
                                            </div>
                                        </div>
                                        
                                        <div class="land-description">
                                            <div class="info-label">
                                                <i class="fas fa-align-left"></i> Description
                                            </div>
                                            <p>${land.description}</p>
                                        </div>
                                        
                                        <div class="action-buttons">
                                            <form action="/admin/approve/${land.id}" method="post" class="d-inline">
                                                <button type="submit" class="btn btn-success">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                            </form>
                                            
                                            <button type="button" class="btn btn-danger" onclick="toggleRejectionForm('${land.id}')">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                            
                                            <a href="/lands/details/${land.id}" class="btn btn-secondary">
                                                <i class="fas fa-eye"></i> View Details
                                            </a>
                                        </div>
                                        
                                        <!-- Rejection Form -->
                                        <div class="rejection-form" id="rejectionForm-${land.id}">
                                            <form action="/admin/reject/${land.id}" method="post">
                                                <div class="mb-3">
                                                    <label for="reason-${land.id}" class="form-label fw-bold">Rejection Reason <span class="text-danger">*</span></label>
                                                    <textarea class="form-control" id="reason-${land.id}" name="reason" rows="3" 
                                                              placeholder="Please provide a detailed reason for rejection..." required></textarea>
                                                </div>
                                                <div class="d-flex gap-2">
                                                    <button type="submit" class="btn btn-danger">
                                                        <i class="fas fa-times"></i> Confirm Rejection
                                                    </button>
                                                    <button type="button" class="btn btn-secondary" onclick="toggleRejectionForm('${land.id}')">
                                                        <i class="fas fa-arrow-left"></i> Cancel
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-clipboard-check"></i>
                        <h3>No Pending Lands</h3>
                        <p>All land listings have been reviewed. Great job!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3">
                    <h3 class="fw-bold text-primary">${pendingLands.size()}</h3>
                    <p class="text-muted">Pending Reviews</p>
                </div>
                <div class="col-md-3">
                    <h3 class="fw-bold text-success">1,500+</h3>
                    <p class="text-muted">Total Properties</p>
                </div>
                <div class="col-md-3">
                    <h3 class="fw-bold text-warning">95%</h3>
                    <p class="text-muted">Approval Rate</p>
                </div>
                <div class="col-md-3">
                    <h3 class="fw-bold text-info">24/7</h3>
                    <p class="text-muted">Admin Support</p>
                </div>
            </div>
        </div>
    </section>

    </main>

    <%-- Footer --%>
    <footer>
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Navbar scroll effect
    document.addEventListener('DOMContentLoaded', function() {
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

        // Parallax effect for hero section
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const heroSection = document.querySelector('.hero-section');
            if (heroSection) {
                heroSection.style.transform = `translateY(${scrolled * 0.3}px)`;
            }
        });

        // Add hover effects to cards
        const cards = document.querySelectorAll('.pending-land-card');
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    });

    // Toggle rejection form
    function toggleRejectionForm(landId) {
        const form = document.getElementById('rejectionForm-' + landId);
        if (form.classList.contains('show')) {
            form.classList.remove('show');
            setTimeout(() => {
                form.style.display = 'none';
            }, 300);
        } else {
            form.style.display = 'block';
            setTimeout(() => {
                form.classList.add('show');
            }, 10);
        }
    }

    // Form validation
    document.addEventListener('DOMContentLoaded', function() {
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            });
        });
    });
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- Last updated: Modern UI Redesign --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reviews | Online Land Sales System</title>
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

        /* Review Cards */
        .review-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 1.5rem;
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
            margin-bottom: 2rem;
            height: 100%;
        }

        .review-card::before {
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

        .review-card:hover::before {
            opacity: 1;
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .review-card .card-body {
            position: relative;
            z-index: 2;
            padding: 2rem;
        }

        .review-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--gray-800);
            margin-bottom: 1rem;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .review-rating {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .stars {
            color: var(--warning);
            font-size: 1.25rem;
            filter: drop-shadow(0 2px 4px rgba(245, 158, 11, 0.3));
        }

        .stars .text-muted {
            color: var(--gray-300) !important;
        }

        .review-comment {
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .review-comment p {
            margin: 0;
            color: var(--gray-700);
            line-height: 1.6;
        }

        .review-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .seller-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .seller-avatar {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 0.9rem;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        .seller-details h6 {
            margin: 0;
            font-weight: 700;
            color: var(--gray-800);
        }

        .seller-details small {
            color: var(--gray-500);
            font-size: 0.8rem;
        }

        .review-date {
            color: var(--gray-500);
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .btn {
            font-weight: 700;
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-size: 0.9rem;
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

        .btn-outline-primary {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid var(--primary);
            color: var(--primary);
            backdrop-filter: blur(10px);
        }

        .btn-outline-primary:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary-dark);
            transform: translateY(-3px) scale(1.05);
            color: var(--primary-dark);
        }

        .btn-outline-danger {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid var(--danger);
            color: var(--danger);
            backdrop-filter: blur(10px);
        }

        .btn-outline-danger:hover {
            background: rgba(239, 68, 68, 0.1);
            border-color: #dc2626;
            transform: translateY(-3px) scale(1.05);
            color: #dc2626;
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

        .alert-info {
            background: rgba(6, 182, 212, 0.1);
            color: var(--info);
            border-left: 4px solid var(--info);
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
            margin-bottom: 1.5rem;
        }

        .empty-state .btn {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        .empty-state .btn:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.6);
        }

        /* Modal Styles */
        .modal-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border-radius: 2rem 2rem 0 0;
            padding: 2rem;
        }

        .modal-title {
            font-weight: 800;
            font-size: 1.5rem;
        }

        .form-control, .form-select {
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 1rem;
            padding: 1rem 1.5rem;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            background: white;
            transform: translateY(-2px);
        }

        .modal-footer .btn {
            padding: 0.75rem 2rem;
            font-size: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.6);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid var(--gray-400);
            color: var(--gray-600);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: rgba(107, 114, 128, 0.1);
            border-color: var(--gray-500);
            transform: translateY(-3px) scale(1.05);
            color: var(--gray-700);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(239, 68, 68, 0.4);
        }

        .btn-danger:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 20px 40px rgba(239, 68, 68, 0.6);
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
            
            .review-meta {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
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
                padding: 0.5rem 1rem;
                font-size: 0.8rem;
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
                    <a class="nav-link active" href="/reviews/my">My Reviews</a>
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
                    <h1 class="display-4 fw-bold mb-4">My Reviews</h1>
                    <p class="lead mb-4">
                        Manage and view all your reviews for land sellers.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Content Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="card card-land">
                        <div class="card-header">
                            <h2 class="mb-0"><i class="fas fa-star"></i> My Reviews</h2>
                        </div>
                        <div class="card-body">
                            <!-- Display Messages -->
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show fade-in">
                                    <i class="fas fa-check-circle"></i> ${successMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show fade-in">
                                    <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Reviews Grid -->
                            <c:choose>
                                <c:when test="${not empty reviews}">
                                    <div class="row">
                                        <c:forEach items="${reviews}" var="review">
                                            <div class="col-lg-6 mb-4">
                                                <div class="review-card animate-on-scroll">
                                                    <div class="card-body">
                                                        <h3 class="review-title">${review.title}</h3>
                                                        
                                                        <div class="review-rating">
                                                            <div class="stars">
                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="review-comment">
                                                            <p>${review.comment}</p>
                                                        </div>
                                                        
                                                        <div class="review-meta">
                                                            <div class="seller-info">
                                                                <div class="seller-avatar">${review.seller.name.substring(0,1).toUpperCase()}</div>
                                                                <div class="seller-details">
                                                                    <h6>${review.seller.name}</h6>
                                                                    <small>Seller</small>
                                                                </div>
                                                            </div>
                                                            <div class="review-date">
                                                                <i class="fas fa-calendar-alt"></i> ${review.createdAt.toLocalDate()}
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="action-buttons">
                                                            <c:if test="${loggedInUser.role == 'BUYER'}">
                                                                <button type="button" class="btn btn-outline-primary" 
                                                                        data-review-id="${review.id}"
                                                                        data-review-title="${fn:escapeXml(review.title)}"
                                                                        data-review-comment="${fn:escapeXml(review.comment)}"
                                                                        data-review-rating="${review.rating}"
                                                                        onclick="editReview(this)">
                                                                    <i class="fas fa-edit"></i> Edit
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${loggedInUser.role == 'BUYER' || loggedInUser.role == 'ADMIN'}">
                                                                <button type="button" class="btn btn-outline-danger" 
                                                                        onclick="deleteReview('${review.id}')">
                                                                    <i class="fas fa-trash"></i> Delete
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        <i class="fas fa-star"></i>
                                        <h3>No Reviews Yet</h3>
                                        <p>You haven't written any reviews yet. Start by browsing available lands and reviewing sellers.</p>
                                        <a href="/lands" class="btn">
                                            <i class="fas fa-search"></i> Browse Lands
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3">
                    <h3 class="fw-bold text-primary">${fn:length(reviews)}</h3>
                    <p class="text-muted">Total Reviews</p>
                </div>
                <div class="col-md-3">
                    <h3 class="fw-bold text-success">1,500+</h3>
                    <p class="text-muted">Properties Listed</p>
                </div>
                <div class="col-md-3">
                    <h3 class="fw-bold text-warning">95%</h3>
                    <p class="text-muted">Satisfaction Rate</p>
                </div>
                <div class="col-md-3">
                    <h3 class="fw-bold text-info">24/7</h3>
                    <p class="text-muted">Support Available</p>
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

<!-- Modals (Edit & Delete) -->
<div class="modal fade" id="editReviewModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-edit"></i> Edit Review</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form id="editReviewForm" action="" method="POST">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Rating <span class="text-danger">*</span></label>
                        <select name="rating" class="form-select" id="editRating" required>
                            <option value="5">5 - Excellent</option>
                            <option value="4">4 - Very Good</option>
                            <option value="3">3 - Good</option>
                            <option value="2">2 - Fair</option>
                            <option value="1">1 - Poor</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Title <span class="text-danger">*</span></label>
                        <input type="text" name="title" class="form-control" id="editTitle" maxlength="100" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">Comment <span class="text-danger">*</span></label>
                        <textarea name="comment" class="form-control" id="editComment" rows="3" maxlength="1000" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteConfirmModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle"></i> Confirm Delete</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this review? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times"></i> Cancel
                </button>
                <form id="deleteReviewForm" action="" method="POST" style="display: inline;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Delete Review
                    </button>
                </form>
            </div>
        </div>
    </div>
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
        const cards = document.querySelectorAll('.review-card');
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    });

    // Edit Review Function
    function editReview(button) {
        const reviewId = button.getAttribute('data-review-id');
        const title = button.getAttribute('data-review-title');
        const comment = button.getAttribute('data-review-comment');
        const rating = button.getAttribute('data-review-rating');
        
        document.getElementById('editReviewForm').action = '${pageContext.request.contextPath}/reviews/edit/' + reviewId;
        document.getElementById('editTitle').value = decodeHtmlEntities(title);
        document.getElementById('editComment').value = decodeHtmlEntities(comment);
        document.getElementById('editRating').value = rating;
        
        new bootstrap.Modal(document.getElementById('editReviewModal')).show();
    }

    // Delete Review Function
    function deleteReview(reviewId) {
        document.getElementById('deleteReviewForm').action = '${pageContext.request.contextPath}/reviews/delete/' + reviewId;
        new bootstrap.Modal(document.getElementById('deleteConfirmModal')).show();
    }

    // Decode HTML entities
    function decodeHtmlEntities(text) {
        const textarea = document.createElement('textarea');
        textarea.innerHTML = text;
        return textarea.value;
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
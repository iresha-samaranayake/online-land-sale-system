<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Online Land Sales System</title>
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
            position: relative;
        }

        /* Floating Elements */
        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        .floating-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        .circle-1 { width: 120px; height: 120px; top: 10%; left: 5%; animation-delay: 0s; }
        .circle-2 { width: 80px; height: 80px; top: 60%; right: 8%; animation-delay: 2s; }
        .circle-3 { width: 60px; height: 60px; bottom: 20%; left: 10%; animation-delay: 4s; }

        .floating-triangle {
            position: absolute;
            width: 0;
            height: 0;
            animation: float 8s ease-in-out infinite;
        }

        .triangle-1 {
            border-left: 30px solid transparent;
            border-right: 30px solid transparent;
            border-bottom: 50px solid rgba(255, 255, 255, 0.1);
            top: 30%;
            right: 5%;
            animation-delay: 1s;
        }

        .triangle-2 {
            border-left: 20px solid transparent;
            border-right: 20px solid transparent;
            border-bottom: 35px solid rgba(255, 255, 255, 0.1);
            bottom: 30%;
            right: 20%;
            animation-delay: 3s;
        }

        .floating-square {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            animation: float 7s ease-in-out infinite;
        }

        .square-1 { width: 40px; height: 40px; top: 50%; left: 2%; animation-delay: 2.5s; }
        .square-2 { width: 55px; height: 55px; bottom: 40%; right: 2%; animation-delay: 5s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-25px) rotate(180deg); }
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
            z-index: 9999;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        .navbar.scrolled {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
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
            background: rgba(99, 102, 241, 0.1);
            transform: translateY(-2px);
            color: var(--primary) !important;
        }

        /* Ensure first content is visible */
        .first-content-section {
            margin-top: 3rem !important;
            padding-top: 2rem !important;
        }

        /* Futuristic Dashboard Cards */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .dashboard-card::before {
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

        .dashboard-card:hover::before {
            opacity: 1;
        }

        .dashboard-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 40px 80px rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .dashboard-card .card-body {
            position: relative;
            z-index: 2;
        }

        /* Futuristic Stats Cards */
        .dashboard-card.bg-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%) !important;
            color: white;
        }

        .dashboard-card.bg-success {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%) !important;
            color: white;
        }

        .dashboard-card.bg-warning {
            background: linear-gradient(135deg, var(--warning) 0%, #d97706 100%) !important;
            color: white;
        }

        .dashboard-card.bg-info {
            background: linear-gradient(135deg, var(--info) 0%, #0891b2 100%) !important;
            color: white;
        }

        .stats-icon {
            font-size: 3rem;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.2));
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .progress-custom {
            height: 8px;
            border-radius: 50px;
            background: rgba(255, 255, 255, 0.2);
            overflow: hidden;
        }

        .progress-custom .progress-bar {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 50px;
            transition: width 0.6s ease;
        }

        /* Futuristic Card Headers */
        .card-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border-radius: 2rem 2rem 0 0;
            padding: 1.5rem 2rem;
            font-weight: 800;
            font-size: 1.125rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            z-index: 2;
        }

        .card-header.bg-secondary {
            background: linear-gradient(135deg, var(--gray-600) 0%, var(--gray-700) 100%);
        }

        /* Futuristic Buttons */
        .btn {
            font-weight: 700;
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            font-size: 0.875rem;
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
            border: 2px solid rgba(99, 102, 241, 0.3);
            color: var(--primary);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-primary:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.2);
        }

        .btn-outline-success {
            border: 2px solid rgba(16, 185, 129, 0.3);
            color: var(--success);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-success:hover {
            background: rgba(16, 185, 129, 0.1);
            border-color: var(--success);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(16, 185, 129, 0.2);
        }

        .btn-outline-info {
            border: 2px solid rgba(6, 182, 212, 0.3);
            color: var(--info);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-info:hover {
            background: rgba(6, 182, 212, 0.1);
            border-color: var(--info);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(6, 182, 212, 0.2);
        }

        .btn-outline-warning {
            border: 2px solid rgba(245, 158, 11, 0.3);
            color: var(--warning);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-warning:hover {
            background: rgba(245, 158, 11, 0.1);
            border-color: var(--warning);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(245, 158, 11, 0.2);
        }

        .btn-outline-danger {
            border: 2px solid rgba(239, 68, 68, 0.3);
            color: var(--danger);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-danger:hover {
            background: rgba(239, 68, 68, 0.1);
            border-color: var(--danger);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(239, 68, 68, 0.2);
        }

        .btn-outline-secondary {
            border: 2px solid rgba(107, 114, 128, 0.3);
            color: var(--gray-600);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-outline-secondary:hover {
            background: rgba(107, 114, 128, 0.1);
            border-color: var(--gray-600);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(107, 114, 128, 0.2);
        }

        /* Activity Items */
        .activity-item {
            border-left: 4px solid var(--primary);
            padding-left: 1.5rem;
            margin-bottom: 1.5rem;
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 1rem;
            padding: 1.5rem;
            transition: all 0.3s ease;
        }

        .activity-item:hover {
            background: rgba(99, 102, 241, 0.05);
            transform: translateX(5px);
            border-left-color: var(--secondary);
        }

        .badge {
            border-radius: 50px;
            padding: 0.5rem 1rem;
            font-weight: 700;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Featured Bar */
        .featured-bar {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            color: white;
            padding: 2rem 3rem;
            border-radius: 2rem;
            font-size: 2rem;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 3px;
            box-shadow: 0 20px 40px rgba(16, 185, 129, 0.3);
            position: relative;
            overflow: hidden;
            margin-bottom: 3rem;
        }

        .featured-bar::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }

        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .featured-bar i {
            margin-right: 1rem;
            font-size: 2.5rem;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.3));
        }

        /* Featured Listings */
        .featured-listings {
            display: none;
            margin-top: 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            padding: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .featured-listings.active {
            display: block;
            animation: slideDown 0.5s ease-out;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Table Styling - Compact and Beautiful */
        .table-responsive {
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .table {
            margin-bottom: 0;
            font-size: 0.875rem;
        }

        .table thead th {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.75rem 0.5rem;
            border: none;
            vertical-align: middle;
        }

        .table tbody td {
            padding: 0.5rem;
            vertical-align: middle;
            border-color: rgba(0, 0, 0, 0.05);
            font-size: 0.8rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(99, 102, 241, 0.05);
            transform: scale(1.01);
        }

        .thumbnail-image {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 0.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .badge {
            font-size: 0.7rem;
            padding: 0.4rem 0.8rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Poster Cards */
        .poster-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            position: relative;
            height: 100%;
        }

        .poster-card::before {
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

        .poster-card:hover::before {
            opacity: 1;
        }

        .poster-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 40px 80px rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .poster-wrapper {
            position: relative;
            width: 100%;
            overflow: hidden;
        }

        .poster-wrapper.gold-size {
            padding-top: 150%;
        }

        .poster-wrapper.silver-size {
            padding-top: 130%;
        }

        .poster-wrapper.bronze-size {
            padding-top: 120%;
        }

        .poster-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .poster-card:hover .poster-image {
            transform: scale(1.05);
        }

        .poster-placeholder {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .poster-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.95) 0%, rgba(0,0,0,0.7) 50%, transparent 100%);
            padding: 2rem 1.5rem;
            color: white;
            z-index: 5;
        }

        .badge-tier {
            position: absolute;
            top: 1rem;
            left: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 900;
            z-index: 10;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
            border: 2px solid #FFF;
        }

        .badge-gold {
            background: linear-gradient(135deg, #FFD700, #FFA500);
            color: #000;
        }

        .badge-silver {
            background: linear-gradient(135deg, #E5E5E5, #B8B8B8);
            color: #000;
        }

        .badge-bronze {
            background: linear-gradient(135deg, #CD7F32, #8B4513);
            color: #fff;
        }

        .badge-discount {
            position: absolute;
            top: 1rem;
            right: 1rem;
            z-index: 10;
            background: var(--danger);
            color: white;
            padding: 0.75rem 1rem;
            border-radius: 50px;
            font-weight: 900;
            font-size: 0.875rem;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.5);
        }

        .poster-title {
            font-size: 1.25rem;
            font-weight: 900;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
        }

        .poster-location {
            font-size: 0.875rem;
            margin-bottom: 0.5rem;
            opacity: 0.95;
        }

        .poster-price {
            font-size: 1.5rem;
            font-weight: 900;
            color: #FFD700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
            margin-bottom: 0.5rem;
        }

        .poster-size {
            font-size: 0.75rem;
            opacity: 0.9;
            margin-bottom: 1rem;
        }

        .poster-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .poster-buttons .btn {
            flex: 1;
            font-weight: 700;
            border: 2px solid white;
            text-transform: uppercase;
            font-size: 0.75rem;
            padding: 0.5rem 0.75rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-card {
                margin-bottom: 1.5rem;
            }
            
            .featured-bar {
                padding: 1.5rem 2rem;
                font-size: 1.5rem;
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

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">
            <i class="fas fa-map-marked-alt"></i> LandSales Portal
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link" href="/">Home</a>
            <a class="nav-link" href="/lands">Browse Lands</a>
            <a class="nav-link" href="/profile">Profile</a>
            <a class="nav-link" href="/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid main-content mt-4">
    <div class="row">
        <!-- Welcome Section -->
        <div class="col-12 mb-4 first-content-section">
            <div class="card dashboard-card">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h2 class="mb-2">
                                <c:choose>
                                    <c:when test="${loggedInUser.role == 'ADMIN'}">
                                        <i class="fas fa-shield-alt text-danger"></i> Admin Dashboard
                                    </c:when>
                                    <c:when test="${loggedInUser.role == 'SELLER'}">
                                        <i class="fas fa-user-tie text-warning"></i> Seller Dashboard
                                    </c:when>
                                    <c:when test="${loggedInUser.role == 'BUYER'}">
                                        <i class="fas fa-user text-success"></i> Buyer Dashboard
                                    </c:when>
                                    <c:when test="${loggedInUser.role == 'STAFF'}">
                                        <i class="fas fa-users text-info"></i> Staff Dashboard
                                    </c:when>
                                </c:choose>
                            </h2>
                            <p class="text-muted mb-0">
                                Welcome back, <strong>${loggedInUser.name}</strong>!
                                <span class="badge bg-secondary ms-2">${loggedInUser.role.displayName}</span>
                            </p>
                            <p class="text-muted mt-1">
                                <c:choose>
                                    <c:when test="${loggedInUser.role == 'ADMIN'}">
                                        Manage the entire system, approve lands, and oversee all operations.
                                    </c:when>
                                    <c:when test="${loggedInUser.role == 'SELLER'}">
                                        Manage your land listings, view inquiries, and track your sales.
                                    </c:when>
                                    <c:when test="${loggedInUser.role == 'BUYER'}">
                                        Browse lands, manage your bookings, and track your purchases.
                                    </c:when>
                                    <c:when test="${loggedInUser.role == 'STAFF'}">
                                        Assist users, handle support requests, and manage day-to-day operations.
                                    </c:when>
                                </c:choose>
                            </p>
                        </div>
                        <div class="col-md-4 text-end">
                            <c:choose>
                                <c:when test="${loggedInUser.role == 'ADMIN'}">
                                    <i class="fas fa-shield-alt fa-4x text-danger"></i>
                                </c:when>
                                <c:when test="${loggedInUser.role == 'SELLER'}">
                                    <i class="fas fa-user-tie fa-4x text-warning"></i>
                                </c:when>
                                <c:when test="${loggedInUser.role == 'BUYER'}">
                                    <i class="fas fa-user fa-4x text-success"></i>
                                </c:when>
                                <c:when test="${loggedInUser.role == 'STAFF'}">
                                    <i class="fas fa-users fa-4x text-info"></i>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- Statistics Cards -->
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card dashboard-card bg-primary text-white animate-on-scroll">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">${totalLands}</h3>
                            <p class="mb-0">Total Lands Available</p>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-map stats-icon"></i>
                        </div>
                    </div>
                    <div class="progress progress-custom mt-2">
                        <div class="progress-bar bg-light" style="width: 85%"></div>
                    </div>
                    <small class="mt-1 d-block">+12% from last month</small>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card dashboard-card bg-success text-white animate-on-scroll">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">${myBookings}</h3>
                            <p class="mb-0">My Bookings</p>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-calendar-check stats-icon"></i>
                        </div>
                    </div>
                    <div class="progress progress-custom mt-2">
                        <div class="progress-bar bg-light" style="width: 60%"></div>
                    </div>
                    <small class="mt-1 d-block">3 pending confirmations</small>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card dashboard-card bg-warning text-white animate-on-scroll">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col">
                            <h3 class="mb-0">${pendingPayments}</h3>
                            <p class="mb-0">Payment Plans</p>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-credit-card stats-icon"></i>
                        </div>
                    </div>
                    <div class="progress progress-custom mt-2">
                        <div class="progress-bar bg-light" style="width: 40%"></div>
                    </div>
                    <small class="mt-1 d-block">₹2,50,000 pending</small>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6 mb-4">
            <a href="/my-reviews" class="text-decoration-none">
                <div class="card dashboard-card bg-info text-white animate-on-scroll">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col">
                                <h3 class="mb-0">${totalReviews}</h3>
                                <p class="mb-0">Reviews Given</p>
                            </div>
                            <div class="col-auto">
                                <i class="fas fa-star stats-icon"></i>
                            </div>
                        </div>
                        <div class="progress progress-custom mt-2">
                            <div class="progress-bar bg-light" style="width: 90%"></div>
                        </div>
                        <small class="mt-1 d-block">Avg. 4.5/5 rating</small>
                    </div>
                </div>
            </a>
        </div>
    </div>

    <div class="row">
        <!-- Quick Actions -->
        <div class="col-lg-4 mb-4">
            <div class="card dashboard-card animate-on-scroll">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-bolt"></i> Quick Actions</h5>
                </div>
                <div class="card-body quick-actions">
                    <div class="d-grid gap-2">
                        <a href="/lands" class="btn btn-outline-primary">
                            <i class="fas fa-search"></i> Browse Available Lands
                        </a>
                        <c:if test="${loggedInUser.role == 'SELLER'}">
                            <a href="/lands/post" class="btn btn-outline-success">
                                <i class="fas fa-plus"></i> Add New Land
                            </a>
                            <a href="/lands/my-posts" class="btn btn-outline-info">
                                <i class="fas fa-list"></i> My Posts
                            </a>
                            <a href="/promote/listing" class="btn btn-outline-warning">
                                <i class="fas fa-star"></i> Promote Listings
                            </a>
                            <a href="/seller/${loggedInUser.id}/payment-plans" class="btn btn-outline-warning">
                                <i class="fas fa-credit-card"></i> Manage Payment Plans
                            </a>
                            <a href="/requests/manage" class="btn btn-outline-primary">
                                <i class="fas fa-envelope"></i> Manage Requests
                            </a>
                            <a href="/profile" class="btn btn-outline-secondary">
                                <i class="fas fa-user-edit"></i> Edit Profile
                            </a>
                        </c:if>
                        <c:if test="${loggedInUser.role == 'ADMIN'}">
                            <a href="/admin/payment-plans" class="btn btn-outline-warning">
                                <i class="fas fa-credit-card"></i> Manage Payment Plans
                            </a>
                            <a href="/admin/pending-ads" class="btn btn-outline-warning">
                                <i class="fas fa-hourglass-half"></i> Pending Ads
                            </a>
                            <a href="/requests/manage" class="btn btn-outline-danger">
                                <i class="fas fa-clipboard-list"></i> Manage Requests
                            </a>
                            <button id="toggleFeaturedListings" class="btn btn-outline-info">
                                <i class="fas fa-star"></i> View Featured Listings
                            </button>
                            <a href="/profile" class="btn btn-outline-secondary">
                                <i class="fas fa-user-edit"></i> Edit Profile
                            </a>
                        </c:if>
                        <c:if test="${loggedInUser.role == 'STAFF'}">
                            <a href="/staff/payment-plans" class="btn btn-outline-warning">
                                <i class="fas fa-credit-card"></i> Manage Payment Plans
                            </a>
                            <button id="toggleFeaturedListings" class="btn btn-outline-info">
                                <i class="fas fa-star"></i> View Featured Listings
                            </button>
                            <a href="/profile" class="btn btn-outline-secondary">
                                <i class="fas fa-user-edit"></i> Edit Profile
                            </a>
                        </c:if>
                       <c:if test="${loggedInUser.role == 'BUYER'}">
                        <a href="/requests/my-submitted-requests" class="btn btn-outline-success">
                            <i class="fas fa-paper-plane"></i> My Submitted Requests
                        </a>
                        <a href="/my-reviews" class="btn btn-outline-info">
                            <i class="fas fa-star"></i> My Reviews
                        </a>
                        <a href="/profile" class="btn btn-outline-secondary">
                            <i class="fas fa-user-edit"></i> Edit Profile
                        </a>
                       </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Activity -->
        <div class="col-lg-8 mb-4">
            <div class="card dashboard-card animate-on-scroll">
                <div class="card-header bg-secondary text-white">
                    <h5 class="mb-0"><i class="fas fa-clock"></i> Recent Activity</h5>
                </div>
                <div class="card-body recent-activity">
                    <c:if test="${loggedInUser.role == 'SELLER' && latestApprovedLand != null}">
                        <div class="activity-item">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <strong>Land approved</strong>
                                    <p class="mb-1 text-muted">Your ${latestApprovedLand.title} listing has been approved</p>
                                    <small class="text-muted">
                                        <c:set var="approvalDate" value="${latestApprovedLand.approvalDate}" />
                                        <c:if test="${not empty approvalDate}">
                                            <%
                                                java.time.LocalDateTime approvalDate = (java.time.LocalDateTime) pageContext.getAttribute("approvalDate");
                                                java.time.LocalDateTime now = java.time.LocalDateTime.now();
                                                long minutesAgo = java.time.temporal.ChronoUnit.MINUTES.between(approvalDate, now);
                                                long hoursAgo = java.time.temporal.ChronoUnit.HOURS.between(approvalDate, now);
                                                long daysAgo = java.time.temporal.ChronoUnit.DAYS.between(approvalDate, now);

                                                if (minutesAgo < 60) {
                                                    if (minutesAgo < 1) {
                                                        out.print("Just now");
                                                    } else {
                                                        out.print(minutesAgo + (minutesAgo == 1 ? " minute ago" : " minutes ago"));
                                                    }
                                                } else if (hoursAgo < 24) {
                                                    out.print(hoursAgo + (hoursAgo == 1 ? " hour ago" : " hours ago"));
                                                } else {
                                                    out.print(daysAgo + (daysAgo == 1 ? " day ago" : " days ago"));
                                                }
                                            %>
                                        </c:if>
                                        <c:if test="${empty approvalDate}">
                                            Date unavailable
                                        </c:if>
                                    </small>
                                </div>
                                <span class="badge bg-success">Approved</span>
                            </div>
                        </div>
                    </c:if>

                    <div class="activity-item">
                        <div class="d-flex justify-content-between">
                            <div>
                                <strong>New land inquiry received</strong>
                                <p class="mb-1 text-muted">Someone inquired about your commercial plot in Colombo</p>
                                <small class="text-muted">2 hours ago</small>
                            </div>
                            <span class="badge bg-primary">New</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="d-flex justify-content-between">
                            <div>
                                <strong>Booking confirmed</strong>
                                <p class="mb-1 text-muted">Your site visit for Kandy residential plot is confirmed for tomorrow</p>
                                <small class="text-muted">1 day ago</small>
                            </div>
                            <span class="badge bg-success">Confirmed</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="d-flex justify-content-between">
                            <div>
                                <strong>Payment plan updated</strong>
                                <p class="mb-1 text-muted">Monthly installment plan modified for Galle beachfront property</p>
                                <small class="text-muted">2 days ago</small>
                            </div>
                            <span class="badge bg-warning">Updated</span>
                        </div>
                    </div>

                    <div class="activity-item">
                        <div class="d-flex justify-content-between">
                            <div>
                                <strong>New review received</strong>
                                <p class="mb-1 text-muted">5-star review for your land listing service</p>
                                <small class="text-muted">3 days ago</small>
                            </div>
                            <span class="badge bg-info">Review</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Featured Listings Section -->
    <div class="row">
        <div class="col-12">
             <div id="featuredListingsSection" class="featured-listings ${loggedInUser.role == 'SELLER' || loggedInUser.role == 'ADMIN' || loggedInUser.role == 'BUYER' ? 'active' : ''}">
                <c:if test="${loggedInUser.role == 'ADMIN'}">
                    <jsp:include page="admin_featured.jsp"/>
                </c:if>
                <c:if test="${loggedInUser.role == 'BUYER'}">
                    <jsp:include page="buyer_featured.jsp"/>
                </c:if>
                <c:if test="${loggedInUser.role == 'SELLER'}">
                    <jsp:include page="seller_featured.jsp"/>
                </c:if>
                <c:if test="${loggedInUser.role == 'STAFF'}">
                    <jsp:include page="staff_featured.jsp"/>
                </c:if>
            </div>
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

            // Add stagger effect to dashboard cards
            const dashboardCards = document.querySelectorAll('.dashboard-card');
            dashboardCards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
            });

            // Featured listings toggle functionality
        const toggleButton = document.getElementById('toggleFeaturedListings');
        if (toggleButton) {
            toggleButton.addEventListener('click', function() {
                const featuredListings = document.getElementById('featuredListingsSection');
                const button = this;
                if (featuredListings.classList.contains('active')) {
                    featuredListings.classList.remove('active');
                        button.innerHTML = '<i class="fas fa-chevron-down"></i> View Featured Listings';
                    button.classList.remove('btn-info');
                    button.classList.add('btn-outline-info');
                } else {
                    featuredListings.classList.add('active');
                        button.innerHTML = '<i class="fas fa-chevron-up"></i> Hide Featured Listings';
                    button.classList.remove('btn-outline-info');
                    button.classList.add('btn-info');
                }
            });
        }

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

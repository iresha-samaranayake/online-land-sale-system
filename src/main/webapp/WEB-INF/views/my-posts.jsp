<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Land Sales System - My Posts</title>
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
            z-index: 1;
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
            z-index: 1000;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
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

        /* User Info */
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem 1.5rem;
            background: rgba(99, 102, 241, 0.1);
            border-radius: 50px;
            border: 1px solid rgba(99, 102, 241, 0.2);
            backdrop-filter: blur(10px);
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

        /* Futuristic Hero Section */
        .hero-section {
            min-height: 50vh;
            display: flex;
            align-items: center;
            position: relative;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            overflow: hidden;
            margin-top: 80px;
            z-index: 2;
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

        /* Main Content Spacing */
        .main-content {
            margin-top: 120px;
            position: relative;
            z-index: 2;
            padding-top: 2rem;
        }

        /* Posts Container */
        .posts-container {
            background: transparent;
            padding: 2rem 0;
        }

        .posts-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .posts-header h2 {
            color: var(--primary);
            font-weight: 800;
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        /* Posts Grid */
        .posts-grid {
            display: grid !important;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr)) !important;
            gap: 2rem !important;
            margin-top: 2rem !important;
            opacity: 1 !important;
            visibility: visible !important;
            position: relative;
            z-index: 5;
        }

        /* Post Cards */
        .post-card {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
            opacity: 1 !important;
            visibility: visible !important;
            display: block !important;
            z-index: 10;
            min-height: 200px;
        }

        .post-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
            z-index: -1;
        }

        .post-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 40px 80px rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.3);
        }

        /* Post Card Header */
        .post-card-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 1.5rem;
            position: relative;
            border-radius: 2rem 2rem 0 0;
        }

        /* Post Image Styling */
        .post-image-container {
            width: 100%;
            height: 250px;
            overflow: hidden;
            position: relative;
            background: linear-gradient(135deg, var(--gray-100) 0%, var(--gray-200) 100%);
            border-radius: 2rem 2rem 0 0;
        }

        .post-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .post-card:hover .post-image {
            transform: scale(1.1);
        }

        .post-image-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.1) 0%, rgba(139, 92, 246, 0.1) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .post-card:hover .post-image-overlay {
            opacity: 1;
        }

        /* Post Content */
        .post-content, .post-card-body {
            padding: 2rem;
            position: relative;
            z-index: 2;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 0 0 2rem 2rem;
        }

        .post-title {
            color: white;
            font-weight: 800;
            font-size: 1.5rem;
            margin-bottom: 0;
            line-height: 1.3;
        }

        .post-description {
            color: var(--gray-600);
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .post-meta, .post-details {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .meta-item, .detail-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: var(--gray-600);
            font-size: 0.875rem;
            font-weight: 500;
            padding: 1rem 1.25rem;
            background: rgba(99, 102, 241, 0.05);
            border-radius: 1rem;
            border: 1px solid rgba(99, 102, 241, 0.1);
            margin-bottom: 0.75rem;
        }

        .meta-item i, .detail-icon {
            color: var(--primary);
            font-size: 1rem;
        }

        /* Status Badges */
        .status-badge {
            font-size: 0.75rem;
            padding: 0.5rem 1rem;
            border-radius: 1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-pending {
            background: linear-gradient(135deg, var(--warning) 0%, #d97706 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.3);
        }

        .status-approved {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        .status-rejected {
            background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Action Buttons */
        .action-buttons, .post-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            margin-top: 1.5rem;
        }

        .action-btn, .btn {
            border-radius: 1rem;
            padding: 0.75rem 1.5rem;
            font-weight: 700;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(99, 102, 241, 0.4);
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

        .btn-danger {
            background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(239, 68, 68, 0.3);
        }

        .btn-danger:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(239, 68, 68, 0.4);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
            opacity: 0.7;
        }

        .empty-state h3 {
            color: var(--gray-700);
            font-weight: 800;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: var(--gray-500);
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        /* Alerts */
        .alert {
            border: none;
            border-radius: 1rem;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            backdrop-filter: blur(20px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .alert-success {
            background: rgba(0, 0, 0, 0.1);
            border-left: 5px solid #000000;
            color: #000000;
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            border-left: 5px solid var(--danger);
            color: var(--danger);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .posts-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .post-card {
                margin-bottom: 1.5rem;
            }
            
            .post-content, .post-card-body {
                padding: 1.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }

        /* Stats Section */
        .stats-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            padding: 3rem 2rem;
            margin: 2rem 0;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .stats-section h3 {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 0.5rem;
        }

        .stats-section p {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .fade-in {
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .animate-on-scroll {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
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
    <div class="container">
        <a class="navbar-brand" href="/">
            <i class="fas fa-mountain"></i> Land Sales Portal
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
                <!-- Only show Dashboard link for logged-in users -->
                <c:if test="${not empty loggedInUser}">
                    <li class="nav-item">
                        <a class="nav-link active" href="/dashboard">
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
    <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert" style="margin-top: 100px; position: relative; z-index: 1001;">
        <div class="container">
            <div class="d-flex align-items-center">
                <i class="fas fa-check-circle me-3" style="font-size: 1.5rem;"></i>
                <div>
                    <p class="mb-0 fw-bold">${successMessage}</p>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert" id="errorAlert" style="margin-top: 100px; position: relative; z-index: 1001;">
        <div class="container">
            <div class="d-flex align-items-center">
                <i class="fas fa-exclamation-triangle me-3" style="font-size: 1.5rem;"></i>
                <div>
                    <h5 class="mb-1 fw-bold">Error!</h5>
                    <p class="mb-0">${errorMessage}</p>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </div>
</c:if>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-12 text-center">
                <h1 class="display-4 fw-bold mb-4">
                    <i class="fas fa-list-alt"></i> Manage Your Posts
                </h1>
                <p class="lead mb-4">
                    Welcome to your post management area. View, edit, or delete your listed lands with ease.
                </p>
                <a href="/lands/post" class="btn btn-primary btn-lg">
                    <i class="fas fa-plus"></i> Add New Post
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Manage Your Listings</h2>
            <p class="text-muted">Tools to help you control and optimize your land posts</p>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-edit fa-3x text-primary mb-3"></i>
                        <h5 class="card-title">Edit Posts</h5>
                        <p class="card-text">Update your land details anytime to keep listings current.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-trash-alt fa-3x text-danger mb-3"></i>
                        <h5 class="card-title">Delete Posts</h5>
                        <p class="card-text">Remove listings that are no longer relevant with a single click.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-eye fa-3x text-success mb-3"></i>
                        <h5 class="card-title">Track Status</h5>
                        <p class="card-text">Monitor the approval status of your land posts in real-time.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Enhanced Posts Section -->
<section class="posts-container main-content">
    <div class="container">
        <div class="posts-header">
            <h2><i class="fas fa-list-alt me-3"></i>My Property Listings</h2>
            <p class="text-muted mb-0">Manage and track all your posted properties from this dashboard</p>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty lands}">
                <div class="posts-grid">
                    <c:forEach var="land" items="${lands}">
                        <div class="card post-card">
                            <!-- Land Image -->
                            <c:if test="${not empty land.images}">
                                <div class="post-image-container">
                                    <img src="${land.images[0].imageUrl}" 
                                         alt="${land.title}" 
                                         class="post-image"
                                         onerror="this.style.display='none'">
                                </div>
                            </c:if>

                            <div class="post-card-header">
                                <h3 class="post-title">${land.title}</h3>
                            </div>

                            <div class="post-card-body">
                                <div class="post-details">
                                    <div class="detail-item price">
                                        <div class="detail-icon price-icon">
                                            <i class="fas fa-rupee-sign"></i>
                                        </div>
                                        <div class="detail-content">
                                            <h6>Price per perch</h6>
                                            <p>LKR <fmt:formatNumber value="${land.price}" type="number" groupingUsed="true" maxFractionDigits="0"/> per perch</p>
                                        </div>
                                    </div>

                                    <div class="detail-item status">
                                        <div class="detail-icon status-icon">
                                            <i class="fas fa-check-circle"></i>
                                        </div>
                                        <div class="detail-content">
                                            <h6>Status</h6>
                                            <p>
                                                <span class="status-badge status-pending">${land.status}</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="post-actions">
                                    <a href="/lands/edit/${land.id}" class="action-btn edit-btn">
                                        <i class="fas fa-edit"></i>
                                        Edit
                                    </a>

                                    <form action="/lands/delete/${land.id}" method="post" style="flex: 1;">
                                        <button type="submit" class="action-btn delete-btn w-100"
                                                onclick="return confirm('Are you sure you want to delete this post?')">
                                            <i class="fas fa-trash-alt"></i>
                                            Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <h3 class="empty-title">No Posts Found</h3>
                    <p class="empty-text">
                        You haven't created any property listings yet. Start by adding your first post to reach potential buyers.
                    </p>
                    <a href="/lands/post" class="add-post-btn">
                        <i class="fas fa-plus"></i>
                        Create Your First Post
                    </a>
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
                <h3 class="fw-bold text-primary">${lands != null ? lands.size() : 0}</h3>
                <p class="text-primary fw-semibold">Posts Listed</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-success">100+</h3>
                <p class="text-success fw-semibold">Active Sellers</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-warning">90%</h3>
                <p class="text-warning fw-semibold">Approval Rate</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-info">24/7</h3>
                <p class="text-info fw-semibold">Support Available</p>
            </div>
        </div>
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
    // Auto-dismiss success message after 5 seconds
    const successAlert = document.getElementById('successAlert');
    if (successAlert) {
        setTimeout(function() {
            const alert = new bootstrap.Alert(successAlert);
            alert.close();
        }, 5000);
    }
    
    // Auto-dismiss error message after 8 seconds (longer for errors)
    const errorAlert = document.getElementById('errorAlert');
    if (errorAlert) {
        setTimeout(function() {
            const alert = new bootstrap.Alert(errorAlert);
            alert.close();
        }, 8000);
    }
});
</script>
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

            // Add stagger effect to post cards
            const postCards = document.querySelectorAll('.post-card');
            postCards.forEach((card, index) => {
                card.style.animationDelay = `${index * 0.1}s`;
                card.classList.add('animate-on-scroll');
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
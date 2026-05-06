<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Land Sales System - Edit Post</title>
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

        .circle-1 { width: 100px; height: 100px; top: 15%; left: 8%; animation-delay: 0s; }
        .circle-2 { width: 80px; height: 80px; top: 70%; right: 12%; animation-delay: 2s; }
        .circle-3 { width: 60px; height: 60px; bottom: 15%; left: 15%; animation-delay: 4s; }

        .floating-triangle {
            position: absolute;
            width: 0;
            height: 0;
            animation: float 8s ease-in-out infinite;
        }

        .triangle-1 {
            border-left: 25px solid transparent;
            border-right: 25px solid transparent;
            border-bottom: 45px solid rgba(255, 255, 255, 0.1);
            top: 25%;
            right: 8%;
            animation-delay: 1s;
        }

        .triangle-2 {
            border-left: 15px solid transparent;
            border-right: 15px solid transparent;
            border-bottom: 30px solid rgba(255, 255, 255, 0.1);
            bottom: 25%;
            right: 25%;
            animation-delay: 3s;
        }

        .floating-square {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            animation: float 7s ease-in-out infinite;
        }

        .square-1 { width: 35px; height: 35px; top: 45%; left: 3%; animation-delay: 2.5s; }
        .square-2 { width: 50px; height: 50px; bottom: 35%; right: 3%; animation-delay: 5s; }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
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
        }

        .navbar.scrolled .nav-link {
            color: var(--gray-600) !important;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .navbar.scrolled .nav-link:hover {
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary) !important;
        }

        /* User Info */
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

        /* Enhanced Form Styling */
        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            padding: 3rem;
            margin: 2rem 0;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: visible;
            z-index: 10;
        }

        .form-section {
            margin-bottom: 2.5rem;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: visible;
            z-index: 1;
        }

        .form-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
            border-radius: 1.5rem;
            z-index: -1;
            pointer-events: none;
        }

        .form-section h3 {
            color: var(--primary);
            font-weight: 800;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .form-section h3 i {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .enhanced-input {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 1rem;
            padding: 1rem 1.25rem;
            font-size: 1rem;
            font-weight: 500;
            color: var(--gray-800);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            backdrop-filter: blur(10px);
            width: 100%;
            pointer-events: auto;
            z-index: 10;
            position: relative;
        }

        .enhanced-input:focus {
            border-color: var(--primary);
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.2);
            transform: translateY(-2px);
            outline: none;
        }

        .enhanced-input:hover {
            border-color: rgba(99, 102, 241, 0.4);
            background: rgba(255, 255, 255, 0.95);
        }

        .form-select {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 1rem;
            padding: 1rem 1.25rem;
            font-size: 1rem;
            font-weight: 500;
            color: var(--gray-800);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            backdrop-filter: blur(10px);
            width: 100%;
            pointer-events: auto;
            z-index: 10;
            position: relative;
        }

        .form-select:focus {
            border-color: var(--primary);
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.2);
            transform: translateY(-2px);
            outline: none;
        }

        .form-select:hover {
            border-color: rgba(99, 102, 241, 0.4);
            background: rgba(255, 255, 255, 0.95);
        }

        .form-label {
            font-weight: 700;
            color: var(--gray-700);
            margin-bottom: 0.75rem;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: var(--primary);
            font-size: 1.125rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border: none;
            border-radius: 1rem;
            padding: 1rem 2rem;
            font-size: 1.125rem;
            font-weight: 700;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.4);
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        .btn-primary:active {
            transform: translateY(-1px) scale(1.02);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid rgba(99, 102, 241, 0.3);
            border-radius: 1rem;
            padding: 1rem 2rem;
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary);
            transform: translateY(-3px) scale(1.05);
            color: var(--primary-dark);
        }

        .error {
            color: var(--danger);
            font-weight: 600;
            font-size: 0.875rem;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        /* Image Preview Styling */
        .image-preview-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .image-preview {
            position: relative;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .image-preview:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .image-preview img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .remove-image-btn {
            position: absolute;
            top: 0.5rem;
            right: 0.5rem;
            background: rgba(239, 68, 68, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .remove-image-btn:hover {
            background: var(--danger);
            transform: scale(1.1);
        }

        /* File Input Styling */
        .file-input-group {
            margin-top: 1rem;
        }

        .file-input {
            background: rgba(255, 255, 255, 0.9);
            border: 2px dashed rgba(99, 102, 241, 0.3);
            border-radius: 1rem;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s ease;
            cursor: pointer;
            backdrop-filter: blur(10px);
        }

        .file-input:hover {
            border-color: var(--primary);
            background: rgba(99, 102, 241, 0.05);
        }

        .file-input i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-container {
                padding: 2rem 1rem;
                margin: 1rem 0;
            }
            
            .form-section {
                padding: 1.5rem;
            }
            
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .image-preview-container {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
        }

        /* Animation Classes */
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
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 25px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            overflow: hidden;
            margin-top: -50px;
            position: relative;
            z-index: 10;
            border: 1px solid #e9ecef;
        }

        .form-header {
            background: linear-gradient(135deg, #34495e, #2c3e50);
            color: #ffffff;
            padding: 35px;
            text-align: center;
            border-bottom: 1px solid #e9ecef;
        }

        .form-body {
            padding: 40px;
        }

        .form-section {
            background: linear-gradient(135deg, #ffffff, #f8f9fb);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            border-left: 5px solid #3498db;
            transition: all 0.3s ease;
        }

        .form-section:hover {
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.15);
            transform: translateY(-2px);
        }

        .section-title {
            color: #34495e;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #3498db, #2980b9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.1rem;
        }

        .enhanced-input {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s ease;
            background: #ffffff;
        }

        .enhanced-input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
            background: #f9fbfb;
        }

        .input-group .enhanced-input {
            border-radius: 0 10px 10px 0;
        }

        .input-group-text {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 10px 0 0 10px;
            font-weight: 600;
        }

        .form-select {
            border: 2px solid #e1e5e9;
            border-radius: 0 10px 10px 0;
            padding: 12px 15px;
            background: #ffffff;
        }

        .form-label {
            font-weight: 600;
            color: #34495e;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .required-star {
            color: #e74c3c;
            font-weight: bold;
        }

        .submit-section {
            text-align: center;
            padding: 30px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            margin-top: 30px;
            border: 1px solid #e9ecef;
        }

        .btn-submit {
            background: linear-gradient(135deg, #3498db, #2980b9);
            border: none;
            border-radius: 50px;
            padding: 15px 50px;
            font-weight: 600;
            font-size: 1.1rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(52, 152, 219, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 30px rgba(52, 152, 219, 0.4);
        }

        .file-upload-area {
            border: 2px dashed #3498db;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            background: linear-gradient(135deg, #f8f9fb, #ffffff);
            transition: all 0.3s ease;
        }

        .file-upload-area:hover {
            background: linear-gradient(135deg, #3498db10, #2980b920);
        }

        .file-upload-icon {
            font-size: 3rem;
            color: #3498db;
            margin-bottom: 15px;
        }

        .progress-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }

        .progress-step {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 10px;
            font-weight: 600;
            color: #7f8c8d;
            position: relative;
        }

        .progress-step.active {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
        }

        .progress-step::after {
            content: '';
            width: 60px;
            height: 2px;
            background: #e9ecef;
            position: absolute;
            right: -35px;
            z-index: -1;
        }

        .progress-step:last-child::after {
            display: none;
        }

        @media (max-width: 768px) {
            .form-body {
                padding: 20px;
            }

            .form-section {
                padding: 20px;
            }
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
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert" style="margin-top: 100px; position: relative; z-index: 1001;">
        <div class="container">
            <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</c:if>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-12 text-center">
                <h1 class="display-4 fw-bold mb-4">
                    <i class="fas fa-edit"></i> Edit Your Land Post
                </h1>
                <p class="lead mb-4">
                    Update your land listing with the latest details. Make changes and submit to refresh your post.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Edit Your Listing</h2>
            <p class="text-muted">Tools to help you refine your land post</p>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-edit fa-3x text-primary mb-3"></i>
                        <h5 class="card-title">Update Details</h5>
                        <p class="card-text">Modify title, description, and pricing as needed.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-camera fa-3x text-success mb-3"></i>
                        <h5 class="card-title">Add Images</h5>
                        <p class="card-text">Upload new images to enhance your listing.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-check-circle fa-3x text-info mb-3"></i>
                        <h5 class="card-title">Review Changes</h5>
                        <p class="card-text">Ensure all updates are accurate before submitting.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Main Content Section -->
<section class="py-5">
    <div class="container">
        <div class="form-container fade-in">
            <!-- Form Header -->
            <div class="form-header">
                <h2 class="mb-3"><i class="fas fa-edit me-3"></i>Edit Your Property</h2>
                <p class="mb-0">Update your listing details below</p>
            </div>

            <!-- Progress Indicator -->
            <div class="progress-indicator mt-4">
                <div class="progress-step active">1</div>
                <div class="progress-step">2</div>
            </div>

            <div class="form-body">
                <c:if test="${not empty errorMessage}"><div class="alert alert-danger">${errorMessage}</div></c:if>
                <%--@elvariable id="landDTO" type=""--%>
                <form:form modelAttribute="landDTO" method="post" action="/lands/update/${landDTO.id}" enctype="multipart/form-data">
                    <!-- Property Information Section -->
                    <div class="form-section animate-on-scroll">
                        <h3>
                            <i class="fas fa-info-circle"></i>
                            Property Information
                        </h3>

                        <div class="form-group">
                            <form:label path="title" cssClass="form-label">
                                <i class="fas fa-tag"></i>
                                Title <span class="required-star">*</span>
                            </form:label>
                            <form:input path="title" cssClass="form-control enhanced-input" value="${landDTO.title}"/>
                            <form:errors path="title" cssClass="error"/>
                        </div>
                        <div class="form-group">
                            <form:label path="description" cssClass="form-label">
                                <i class="fas fa-align-left text-primary me-2"></i>
                                Description <span class="required-star">*</span>
                            </form:label>
                            <form:textarea path="description" cssClass="form-control enhanced-input" rows="5"/>
                            <form:errors path="description" cssClass="error"/>
                        </div>
                    </div>

                    <!-- Pricing & Size Section -->
                    <div class="form-section">
                        <h4 class="section-title">
                            <div class="section-icon">
                                <i class="fas fa-calculator"></i>
                            </div>
                            Pricing & Measurements
                        </h4>

                        <div class="form-group">
                            <form:label path="price" cssClass="form-label">
                                <i class="fas fa-rupee-sign text-success me-2"></i>
                                Price per perch (LKR) <span class="required-star">*</span>
                            </form:label>
                            <div class="input-group">
                                <span class="input-group-text">LKR</span>
                                <form:input path="price" type="number" step="0.01" cssClass="form-control enhanced-input" value="${landDTO.price}"/>
                            </div>
                            <form:errors path="price" cssClass="error"/>
                        </div>
                        <div class="form-group">
                            <form:label path="size" cssClass="form-label">
                                <i class="fas fa-expand-arrows-alt text-info me-2"></i>
                                Size <span class="required-star">*</span>
                            </form:label>
                            <div class="input-group">
                                <form:input path="size" type="number" step="0.01" cssClass="form-control enhanced-input" value="${landDTO.size}"/>
                                <select class="form-select" name="sizeUnit">
                                    <option value="perch">Perch</option>
                                    <option value="acre">Acre</option>
                                    <option value="sqm">Sq.M</option>
                                    <option value="sqft">Sq.Ft</option>
                                </select>
                            </div>
                            <form:errors path="size" cssClass="error"/>
                        </div>
                    </div>

                    <!-- Location Section -->
                    <div class="form-section">
                        <h4 class="section-title">
                            <div class="section-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            Location Details
                        </h4>

                        <div class="form-group">
                            <form:label path="location" cssClass="form-label">
                                <i class="fas fa-map text-danger me-2"></i>
                                Location <span class="required-star">*</span>
                            </form:label>
                            <form:input path="location" cssClass="form-control enhanced-input" value="${landDTO.location}"/>
                            <form:errors path="location" cssClass="error"/>
                        </div>
                    </div>

                    <!-- Images Section -->
                    <div class="form-section">
                        <h4 class="section-title">
                            <div class="section-icon">
                                <i class="fas fa-images"></i>
                            </div>
                            Property Images
                        </h4>

                        <!-- Existing Images -->
                        <c:if test="${not empty landDTO.existingImages}">
                            <div class="existing-images-section mb-4">
                                <h6 class="mb-3">
                                    <i class="fas fa-images me-2"></i>Current Images
                                </h6>
                            <div class="alert alert-info mb-3">
                                <i class="fas fa-info-circle me-2"></i>
                                <strong>Note:</strong> You can delete individual images by clicking the red X button. 
                                If you delete images and then submit the form, the deletions will be permanent.
                            </div>
                                <div class="row g-3" id="existing-images-container">
                                    <c:forEach var="image" items="${landDTO.existingImages}">
                                        <div class="col-md-3 col-sm-4 col-6" data-image-id="${image.id}">
                                            <div class="image-thumbnail-container position-relative">
                                                <img src="${image.imageUrl}" 
                                                     alt="Property Image" 
                                                     class="img-thumbnail existing-image-thumbnail"
                                                     style="width: 100%; height: 150px; object-fit: cover;">
                                                <button type="button" 
                                                        class="btn btn-danger btn-sm delete-image-btn position-absolute top-0 end-0 m-1"
                                                        data-image-id="${image.id}"
                                                        title="Delete Image">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                                <c:if test="${image.isPrimary}">
                                                    <span class="badge bg-primary position-absolute bottom-0 start-0 m-1">
                                                        Primary
                                                    </span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>

                        <div class="file-upload-area">
                            <div class="file-upload-icon">
                                <i class="fas fa-cloud-upload-alt"></i>
                            </div>
                            <h5>Upload New Images (Optional)</h5>
                            <p class="text-muted mb-3">Add or replace images to enhance your listing</p>

                            <div id="file-input-group">
                                <input type="file" id="main-image-input" name="images" multiple class="form-control file-input enhanced-input" accept="image/jpeg,image/png,image/jpg"/>
                            </div>
                            <button type="button" class="btn add-files-btn mt-3" id="add-more-files">
                                <i class="fas fa-plus me-2"></i>Add More Files
                            </button>

                            <!-- Image Thumbnails Container -->
                            <div id="image-thumbnails" class="mt-3" style="display: none;">
                                <h6 class="mb-3">Selected New Images:</h6>
                                <div id="thumbnail-container" class="row g-2"></div>
                            </div>
                            <form:errors path="images" cssClass="error"/>

                            <div class="mt-3">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Accepted formats: JPEG, PNG, JPG | Max file size: 5MB each
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Section -->
                    <div class="submit-section">
                        <h5 class="mb-3">Ready to Update Your Listing?</h5>
                        <p class="text-muted mb-4">Review all changes before submitting</p>
                        <button type="submit" class="btn btn-primary btn-submit">
                            <i class="fas fa-paper-plane me-2"></i>
                            Update Listing
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3">
                <h3 class="fw-bold text-primary">1,500+</h3>
                <p class="text-muted">Posts Edited</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-success">90%</h3>
                <p class="text-muted">Update Success Rate</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-warning">500+</h3>
                <p class="text-muted">Active Edits</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-info">24/7</h3>
                <p class="text-muted">Support Available</p>
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
    // Multiple image upload functionality
    var selectedImages = [];
    
    // Initialize image preview functionality
    var mainInput = document.getElementById('main-image-input');
    var addMoreBtn = document.getElementById('add-more-files');
    var thumbnailContainer = document.getElementById('thumbnail-container');
    var imageThumbnails = document.getElementById('image-thumbnails');
    
    // Add form validation for required fields and image requirement
    var form = document.querySelector('form');
    if (form) {
        form.addEventListener('submit', function(event) {
            var hasErrors = false;
            var errorMessages = [];
            
            // Validate required fields
            var titleField = document.querySelector('input[name="title"]');
            if (!titleField.value.trim()) {
                errorMessages.push('Please enter the title');
                hasErrors = true;
            }
            
            var descriptionField = document.querySelector('textarea[name="description"]');
            if (!descriptionField.value.trim()) {
                errorMessages.push('Please enter the description');
                hasErrors = true;
            }
            
            var priceField = document.querySelector('input[name="price"]');
            if (!priceField.value.trim() || priceField.value <= 0) {
                errorMessages.push('Please enter a valid price');
                hasErrors = true;
            }
            
            var sizeField = document.querySelector('input[name="size"]');
            if (!sizeField.value.trim() || sizeField.value <= 0) {
                errorMessages.push('Please enter a valid size');
                hasErrors = true;
            }
            
            var locationField = document.querySelector('input[name="location"]');
            if (!locationField.value.trim()) {
                errorMessages.push('Please enter the location');
                hasErrors = true;
            }
            
            // Count existing images (not deleted)
            var existingImages = document.querySelectorAll('[data-image-id]');
            var newImages = selectedImages.length;
            var totalImages = existingImages.length + newImages;
            
            console.log('Form submission check - Existing images:', existingImages.length, 'New images:', newImages, 'Total:', totalImages);
            
            if (totalImages === 0) {
                errorMessages.push('At least one image is required for your property listing');
                hasErrors = true;
            }
            
            if (hasErrors) {
                event.preventDefault();
                event.stopPropagation();
                
                // Show all error messages
                var errorMessage = errorMessages.join('\n');
                alert(errorMessage);
                
                // Scroll to first error field
                if (titleField && !titleField.value.trim()) {
                    titleField.scrollIntoView({ behavior: 'smooth' });
                    titleField.focus();
                } else if (descriptionField && !descriptionField.value.trim()) {
                    descriptionField.scrollIntoView({ behavior: 'smooth' });
                    descriptionField.focus();
                } else if (priceField && (!priceField.value.trim() || priceField.value <= 0)) {
                    priceField.scrollIntoView({ behavior: 'smooth' });
                    priceField.focus();
                } else if (sizeField && (!sizeField.value.trim() || sizeField.value <= 0)) {
                    sizeField.scrollIntoView({ behavior: 'smooth' });
                    sizeField.focus();
                } else if (locationField && !locationField.value.trim()) {
                    locationField.scrollIntoView({ behavior: 'smooth' });
                    locationField.focus();
                } else if (totalImages === 0) {
                    var imagesSection = document.querySelector('.file-upload-area');
                    if (imagesSection) {
                        imagesSection.scrollIntoView({ behavior: 'smooth' });
                    }
                }
                
                return false;
            }
        });
    }

    if (mainInput) {
        mainInput.addEventListener('change', function(e) {
            handleFileSelection(e.target.files);
        });
    }

    if (addMoreBtn) {
        addMoreBtn.addEventListener('click', function() {
            var input = document.createElement('input');
            input.type = 'file';
            input.name = 'images';
            input.className = 'form-control file-input enhanced-input mt-2';
            input.setAttribute('multiple', true);
            input.setAttribute('accept', 'image/jpeg,image/png,image/jpg');
            
            input.addEventListener('change', function(e) {
                handleFileSelection(e.target.files);
            });
            
            var removeButton = document.createElement('span');
            removeButton.className = 'remove-file btn btn-sm btn-outline-danger ms-2';
            removeButton.innerHTML = '&times; Remove Input';
            removeButton.addEventListener('click', function() {
                document.getElementById('file-input-group').removeChild(input);
                document.getElementById('file-input-group').removeChild(removeButton);
            });
            
            document.getElementById('file-input-group').appendChild(input);
            document.getElementById('file-input-group').appendChild(removeButton);
        });
    }

    function handleFileSelection(files) {
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            if (validateFile(file)) {
                addImageToPreview(file);
            }
        }
        updateThumbnails();
    }

    function validateFile(file) {
        var validTypes = ['image/jpeg', 'image/jpg', 'image/png'];
        var maxSize = 5 * 1024 * 1024; // 5MB

        if (validTypes.indexOf(file.type) === -1) {
            alert('Invalid file type: ' + file.name + '. Please select JPEG, PNG, or JPG files.');
            return false;
        }

        if (file.size > maxSize) {
            alert('File too large: ' + file.name + '. Maximum size is 5MB.');
            return false;
        }

        return true;
    }

    function addImageToPreview(file) {
        var imageData = {
            file: file,
            id: Date.now() + Math.random() // Unique ID for each image
        };
        selectedImages.push(imageData);
    }

    function updateThumbnails() {
        if (!thumbnailContainer || !imageThumbnails) return;

        // Clear existing thumbnails
        thumbnailContainer.innerHTML = '';

        if (selectedImages.length === 0) {
            imageThumbnails.style.display = 'none';
            return;
        }

        imageThumbnails.style.display = 'block';

        // Create thumbnails for each selected image
        for (var i = 0; i < selectedImages.length; i++) {
            var imageData = selectedImages[i];
            createThumbnail(imageData, i);
        }
    }

    function createThumbnail(imageData, index) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var col = document.createElement('div');
            col.className = 'col-md-3 col-6 mb-3';
            
            col.innerHTML = 
                '<div class="thumbnail-wrapper position-relative" style="border: 1px solid #ddd; border-radius: 8px; padding: 8px; background: white; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">' +
                    '<img src="' + e.target.result + '" class="img-fluid" style="width: 100%; height: 120px; object-fit: cover; border-radius: 4px;">' +
                    '<div class="thumbnail-actions position-absolute" style="top: 8px; right: 8px;">' +
                        '<button type="button" class="btn btn-sm btn-outline-danger remove-image" data-index="' + index + '" title="Remove" style="padding: 2px 6px;">' +
                            '<i class="fas fa-times" style="font-size: 10px;"></i>' +
                        '</button>' +
                        '<button type="button" class="btn btn-sm btn-outline-primary reselect-image" data-index="' + index + '" title="Reselect" style="padding: 2px 6px; margin-left: 2px;">' +
                            '<i class="fas fa-sync-alt" style="font-size: 10px;"></i>' +
                        '</button>' +
                    '</div>' +
                    '<div class="mt-2">' +
                        '<small class="text-muted d-block" style="font-size: 11px;">' + imageData.file.name + '</small>' +
                        '<small class="text-muted" style="font-size: 10px;">' + (imageData.file.size / 1024 / 1024).toFixed(2) + ' MB</small>' +
                    '</div>' +
                '</div>';

            // Add event listeners
            var removeBtn = col.querySelector('.remove-image');
            var reselectBtn = col.querySelector('.reselect-image');
            
            if (removeBtn) {
                removeBtn.addEventListener('click', function() {
                    selectedImages.splice(index, 1);
                    updateThumbnails();
                });
            }
            
            if (reselectBtn) {
                reselectBtn.addEventListener('click', function() {
                    reselectImage(index);
                });
            }

            thumbnailContainer.appendChild(col);
        };
        reader.readAsDataURL(imageData.file);
    }

    function reselectImage(index) {
        var input = document.createElement('input');
        input.type = 'file';
        input.accept = 'image/jpeg,image/png,image/jpg';
        input.style.display = 'none';
        
        input.addEventListener('change', function(e) {
            var file = e.target.files[0];
            if (file && validateFile(file)) {
                selectedImages[index].file = file;
                updateThumbnails();
            }
        });
        
        document.body.appendChild(input);
        input.click();
        document.body.removeChild(input);
    }

    // Use event delegation to handle dynamically added delete buttons
    document.addEventListener('click', function(event) {
        // Check if the clicked element is a delete button
        if (event.target.closest('.delete-image-btn')) {
            event.preventDefault();
            event.stopPropagation();
            
            const deleteButton = event.target.closest('.delete-image-btn');
            const imageId = deleteButton.getAttribute('data-image-id');
            const imageContainer = deleteButton.closest('[data-image-id]');
            
            console.log('Delete button clicked for image ID:', imageId);
            console.log('Delete button element:', deleteButton);
            console.log('Image container found:', imageContainer);
            
            // Validate that we have the necessary elements
            if (!imageId || imageId === 'null' || imageId === 'undefined') {
                console.error('Invalid image ID:', imageId);
                showMessage('Error: Invalid image ID', 'error');
                return;
            }
            
            if (!imageContainer) {
                console.error('Image container not found');
                showMessage('Error: Image container not found', 'error');
                return;
            }
            
            // Additional validation
            if (isNaN(parseInt(imageId))) {
                console.error('Image ID is not a number:', imageId);
                showMessage('Error: Invalid image ID format', 'error');
                return;
            }
            
            // Check if this is the last image
            var existingImages = document.querySelectorAll('[data-image-id]');
            var newImages = selectedImages.length;
            var totalImages = existingImages.length + newImages;
            
            var confirmMessage = 'Are you sure you want to delete this image?';
            if (totalImages <= 1) {
                confirmMessage = 'This is the last image. Deleting it will require you to add a new image before you can submit the form. Are you sure you want to delete this image?';
            }
            
            if (confirm(confirmMessage)) {
                console.log('User confirmed deletion for image ID:', imageId);
                
                // Disable the button to prevent multiple clicks
                deleteButton.disabled = true;
                deleteButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
                
                // IMMEDIATELY remove the image from UI (optimistic update)
                console.log('Starting immediate UI removal');
                if (imageContainer) {
                    // Add fade out effect
                    imageContainer.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                    imageContainer.style.opacity = '0';
                    imageContainer.style.transform = 'scale(0.8)';
                    
                    // Remove from DOM after animation
                    setTimeout(() => {
                        try {
                            if (imageContainer.parentNode) {
                                imageContainer.remove();
                                console.log('SUCCESS: Image container removed from DOM');
                            } else {
                                console.log('Image container already removed');
                            }
                            
                            // Check if no images left
                            const remainingImages = document.querySelectorAll('[data-image-id]');
                            console.log('Remaining images:', remainingImages.length);
                            if (remainingImages.length === 0) {
                                const existingImagesSection = document.querySelector('.existing-images-section');
                                if (existingImagesSection) {
                                    existingImagesSection.style.display = 'none';
                                    console.log('Hidden existing images section - no images left');
                                }
                            }
                        } catch (removeError) {
                            console.error('Error removing image container:', removeError);
                            // Force removal as fallback
                            imageContainer.style.display = 'none';
                        }
                    }, 300);
                }
                
                // Send AJAX request to delete image from server (in background)
                console.log('Sending AJAX request to: /lands/delete-image/' + imageId);
                
                fetch('/lands/delete-image/' + imageId, {
                    method: 'DELETE',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    credentials: 'same-origin' // Include cookies for session
                })
                .then(response => {
                    console.log('Response received - Status:', response.status);
                    if (response.ok) {
                        return response.text();
                    } else {
                        return response.text().then(text => {
                            console.error('Server error response:', text);
                            throw new Error(`Server error: ${response.status} - ${text}`);
                        });
                    }
                })
                .then(data => {
                    console.log('Delete response data:', data);
                    showMessage('Image deleted successfully!', 'success');
                })
                .catch(error => {
                    console.error('AJAX Error details:', error);
                    // Even if server fails, UI is already updated
                    showMessage('Image removed from view. Server sync may have failed.', 'warning');
                    
                    // Re-enable the button
                    deleteButton.disabled = false;
                    deleteButton.innerHTML = '<i class="fas fa-times"></i>';
                });
            }
        }
    });
    
    // Function to show messages
    function showMessage(message, type) {
        const alertClass = type === 'success' ? 'alert-success' : (type === 'warning' ? 'alert-warning' : 'alert-danger');
        const messageDiv = document.createElement('div');
        messageDiv.className = `alert ${alertClass} alert-dismissible fade show`;
        messageDiv.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        // Insert at the top of the form
        const formBody = document.querySelector('.form-body');
        if (formBody) {
            formBody.insertBefore(messageDiv, formBody.firstChild);
            
            // Auto-dismiss after 5 seconds
            setTimeout(() => {
                if (messageDiv.parentNode) {
                    messageDiv.remove();
                }
            }, 5000);
        }
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

            // Test input functionality
            const inputs = document.querySelectorAll('.enhanced-input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    console.log('Input focused:', this.name || this.id);
                });
                
                input.addEventListener('input', function() {
                    console.log('Input changed:', this.name || this.id, 'Value:', this.value);
                });
            });
        });
    </script>
</body>
</html>
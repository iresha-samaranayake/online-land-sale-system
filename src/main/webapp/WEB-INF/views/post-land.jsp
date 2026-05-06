<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Land Sales System - List Your Property</title>
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
        /* Futuristic Feature Cards */
        .feature-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            padding: 2rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            height: 100%;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .feature-card:hover::before {
            opacity: 1;
        }

        .feature-card:hover {
            transform: translateY(-20px) scale(1.02);
            box-shadow: 0 40px 80px rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .feature-card i {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            display: block;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .feature-card h5 {
            font-weight: 800;
            color: var(--gray-800);
            margin-bottom: 1rem;
            font-size: 1.25rem;
            letter-spacing: -0.025em;
        }

        .feature-card p {
            color: var(--gray-600);
            font-size: 1rem;
            line-height: 1.6;
            font-weight: 400;
        }

        /* Futuristic Form Container */
        .form-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: visible;
            margin-top: -50px;
            position: relative;
            z-index: 10;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .form-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 3rem;
            text-align: center;
            position: relative;
        }

        .form-header h2 {
            font-weight: 900;
            font-size: 2rem;
            margin-bottom: 1rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .form-header p {
            font-size: 1.125rem;
            opacity: 0.9;
        }

        .form-body {
            padding: 3rem;
        }

        /* Futuristic Form Sections */
        .form-section {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 1.5rem;
            padding: 2rem;
            margin-bottom: 2rem;
            border-left: 4px solid var(--primary);
            transition: all 0.3s ease;
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
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
            pointer-events: none;
        }

        .form-section:hover::before {
            opacity: 1;
        }

        .form-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
            border-left-color: var(--secondary);
        }

        .section-title {
            color: var(--gray-800);
            font-weight: 800;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.5rem;
            position: relative;
            z-index: 2;
        }

        .section-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        /* Futuristic Form Controls */
        .form-label {
            font-weight: 700;
            color: var(--gray-800);
            margin-bottom: 0.75rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .enhanced-input {
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 1rem;
            padding: 1rem 1.5rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            font-size: 1rem;
            color: var(--gray-800);
            pointer-events: auto;
            z-index: 10;
            position: relative;
        }

        .enhanced-input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            background: white;
            transform: translateY(-2px);
            outline: none;
        }

        .enhanced-input:hover {
            border-color: rgba(99, 102, 241, 0.4);
            background: rgba(255, 255, 255, 0.95);
        }

        .input-group-text {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border: none;
            border-radius: 1rem 0 0 1rem;
            font-weight: 700;
            padding: 1rem 1.5rem;
        }

        .form-select {
            border: 2px solid rgba(99, 102, 241, 0.2);
            border-radius: 0 1rem 1rem 0;
            padding: 1rem 1.5rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            color: var(--gray-800);
            pointer-events: auto;
            z-index: 10;
            position: relative;
        }

        .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            background: white;
            outline: none;
        }

        .form-select:hover {
            border-color: rgba(99, 102, 241, 0.4);
            background: rgba(255, 255, 255, 0.95);
        }

        .required-star {
            color: var(--danger);
            font-weight: 900;
        }

        /* Futuristic File Upload */
        .file-upload-area {
            border: 2px dashed rgba(99, 102, 241, 0.3);
            border-radius: 1.5rem;
            padding: 3rem;
            text-align: center;
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .file-upload-area::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .file-upload-area:hover::before {
            opacity: 1;
        }

        .file-upload-area:hover {
            border-color: var(--primary);
            background: rgba(99, 102, 241, 0.05);
            transform: translateY(-2px);
        }

        .file-upload-icon {
            font-size: 4rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
            filter: drop-shadow(0 4px 8px rgba(99, 102, 241, 0.3));
        }

        .add-files-btn {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            border: none;
            border-radius: 50px;
            padding: 1rem 2rem;
            color: white;
            font-weight: 700;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.3);
        }

        .add-files-btn:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(16, 185, 129, 0.4);
        }

        /* Futuristic Submit Section */
        .submit-section {
            text-align: center;
            padding: 3rem;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 1.5rem;
            margin-top: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .btn-submit {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border: none;
            border-radius: 50px;
            padding: 1.5rem 3rem;
            font-weight: 800;
            font-size: 1.125rem;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.4);
            position: relative;
            overflow: hidden;
        }

        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-submit:hover::before {
            left: 100%;
        }

        .btn-submit:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.6);
            background: linear-gradient(135deg, var(--primary-dark) 0%, #7c3aed 100%);
        }

        /* Progress Indicator */
        .progress-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 2rem;
        }

        .progress-step {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: rgba(99, 102, 241, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 1rem;
            font-weight: 800;
            color: var(--gray-500);
            position: relative;
            transition: all 0.3s ease;
        }

        .progress-step.active {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
        }

        .progress-step::after {
            content: '';
            width: 60px;
            height: 2px;
            background: rgba(99, 102, 241, 0.2);
            position: absolute;
            right: -35px;
            z-index: -1;
        }

        .progress-step:last-child::after {
            display: none;
        }

        /* Info Tooltip */
        .info-tooltip {
            background: var(--primary);
            color: white;
            padding: 0.5rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            margin-left: 0.5rem;
            cursor: help;
            font-weight: 700;
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
            .form-container {
                margin: 1rem;
            }

            .form-body {
                padding: 2rem;
            }

            .form-section {
                padding: 1.5rem;
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

        .error { color: var(--danger); }
        .form-group { margin-bottom: 1rem; }
        /* Custom style for multiple file inputs */
        .file-input-group {
            margin-bottom: 10px;
        }
        .remove-file {
            cursor: pointer;
            color: var(--danger);
            margin-left: 10px;
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
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="/">
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
                <c:if test="${not empty loggedInUser}">
                    <li class="nav-item">
                        <a class="nav-link" href="/dashboard">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                </c:if>
            </ul>
            <div class="navbar-nav">
                <c:choose>
                    <c:when test="${not empty loggedInUser}">
                        <div class="user-info me-3">
                            <div class="user-avatar">
                                    ${loggedInUser.name.substring(0,1).toUpperCase()}
                            </div>
                            <div>
                                <div class="fw-bold">${loggedInUser.name}</div>
                                <small class="text-muted">${loggedInUser.role.displayName}</small>
                            </div>
                        </div>
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
<c:if test="${not empty success}">
    <div class="alert alert-success alert-dismissible fade show mt-5 pt-5" role="alert">
        <div class="container">
            <i class="fas fa-check-circle"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</c:if>
<c:if test="${not empty error}">
    <div class="alert alert-danger alert-dismissible fade show mt-5 pt-5" role="alert">
        <div class="container">
            <i class="fas fa-exclamation-triangle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</c:if>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-12 text-center">
                <h1 class="display-4 fw-bold mb-4">List Your Property</h1>
                <p class="lead mb-4">
                    Share your land with potential buyers. Fill out the form below to get started.
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-5">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold">Why List With Us?</h2>
            <p class="text-muted">Enhance your selling experience with these benefits</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-users fa-3x text-primary mb-3"></i>
                        <h5 class="card-title">Wide Audience</h5>
                        <p class="card-text">Reach thousands of potential buyers across the region.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-shield-alt fa-3x text-success mb-3"></i>
                        <h5 class="card-title">Secure Process</h5>
                        <p class="card-text">Your listing is protected with verified documentation.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card h-100 text-center p-4">
                    <div class="card-body">
                        <i class="fas fa-star fa-3x text-warning mb-3"></i>
                        <h5 class="card-title">Featured Option</h5>
                        <p class="card-text">Boost visibility with our featured listing service.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Enhanced Form Section -->
<section class="py-5" style="background: linear-gradient(135deg, #f8f9fa, #e9ecef);">
    <div class="container">
        <div class="form-container">
            <!-- Form Header -->
            <div class="form-header">
                <h2 class="mb-3"><i class="fas fa-home me-3"></i>Property Details Form</h2>
                <p class="mb-0">Complete all sections to list your property successfully</p>
            </div>

            <!-- Progress Indicator -->
            <div class="progress-indicator mt-4">
                <div class="progress-step active">1</div>
                <div class="progress-step active">2</div>
                <div class="progress-step active">3</div>
                <div class="progress-step active">4</div>
            </div>

            <div class="form-body">
                <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
                <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

                <%--@elvariable id="landDTO" type=""--%>
                <form:form modelAttribute="landDTO" method="post" action="/lands/post" enctype="multipart/form-data" cssClass="needs-validation" novalidate="true">

                    <!-- Property Information Section -->
                    <div class="form-section">
                        <h4 class="section-title">
                            <div class="section-icon">
                                <i class="fas fa-info-circle"></i>
                            </div>
                            Property Information
                        </h4>

                        <div class="row">
                            <div class="col-md-12 form-group">
                                <form:label path="title" cssClass="form-label">
                                    <i class="fas fa-tag text-primary me-2"></i>
                                    Property Title <span class="required-star">*</span>
                                </form:label>
                                <form:input path="title" cssClass="form-control enhanced-input" placeholder="e.g., Prime Agricultural Land in Colombo District" required="true"/>
                                <form:errors path="title" cssClass="error"/>
                            </div>

                            <div class="col-md-12 form-group">
                                <form:label path="description" cssClass="form-label">
                                    <i class="fas fa-align-left text-primary me-2"></i>
                                    Description <span class="required-star">*</span>
                                    <span class="info-tooltip" title="Provide detailed information about your property">ℹ</span>
                                </form:label>
                                <form:textarea path="description" cssClass="form-control enhanced-input" rows="5" placeholder="Describe your property in detail - location benefits, nearby amenities, soil type, access roads, etc." required="true"/>
                                <form:errors path="description" cssClass="error"/>
                            </div>
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

                        <div class="row">
                            <div class="col-md-6 form-group">
                                <form:label path="price" cssClass="form-label">
                                    <i class="fas fa-rupee-sign text-success me-2"></i>
                                    Price per perch <span class="required-star">*</span>
                                </form:label>
                                <div class="input-group">
                                    <span class="input-group-text">LKR</span>
                                    <form:input path="price" type="number" step="0.01" cssClass="form-control enhanced-input" min="0.01" placeholder="0.00" required="true"/>
                                </div>
                                <form:errors path="price" cssClass="error"/>
                            </div>

                            <div class="col-md-6 form-group">
                                <form:label path="size" cssClass="form-label">
                                    <i class="fas fa-expand-arrows-alt text-info me-2"></i>
                                    Size <span class="required-star">*</span>
                                </form:label>
                                <div class="input-group">
                                    <form:input path="size" type="number" step="0.01" cssClass="form-control enhanced-input" min="0.01" placeholder="0.00" required="true"/>
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
                                <span class="info-tooltip" title="Include city, district, and province for better visibility">ℹ</span>
                            </form:label>
                            <form:input path="location" cssClass="form-control enhanced-input" placeholder="e.g., Negombo, Western Province" required="true"/>
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

                        <div class="file-upload-area">
                            <div class="file-upload-icon">
                                <i class="fas fa-cloud-upload-alt"></i>
                            </div>
                            <h5>Upload Property Images <span class="required-star">*</span></h5>
                            <p class="text-muted mb-3">Add high-quality images to attract more buyers (at least one image required)</p>

                            <div id="file-input-group">
                                <input type="file" id="main-image-input" name="images" multiple class="form-control file-input enhanced-input" accept="image/jpeg,image/png,image/jpg"/>
                            </div>
                            <button type="button" class="btn btn-success mt-3" id="add-more-files" style="z-index: 99999; position: relative; pointer-events: auto;">
                                <i class="fas fa-plus me-2"></i>Add More Files
                            </button>

                            <!-- Image Thumbnails Container -->
                            <div id="image-thumbnails" class="mt-3" style="display: none;">
                                <h6 class="mb-3">Selected Images:</h6>
                                <div id="thumbnail-container" class="row g-2"></div>
                            </div>
                            <form:errors path="images" cssClass="error"/>

                            <div class="mt-3">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle me-1"></i>
                                    Accepted formats: JPEG, PNG, JPG | Max file size: 5MB each
                                </small>
                                <div id="image-required-warning" class="alert alert-warning mt-2" style="display: none;">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <strong>Required:</strong> Please select at least one image for your property listing.
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Section -->
                    <div class="submit-section">
                        <h5 class="mb-3">Ready to List Your Property?</h5>
                        <p class="text-muted mb-4">Review all information before submitting</p>
                        <button type="submit" class="btn btn-primary btn-submit" onclick="console.log('Submit button clicked')">
                            <i class="fas fa-paper-plane me-2"></i>
                            Submit Property Listing
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
                <h3 class="fw-bold text-primary">500+</h3>
                <p class="text-muted">Properties Listed</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-success">300+</h3>
                <p class="text-muted">Active Sellers</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-warning">85%</h3>
                <p class="text-muted">Approval Rate</p>
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

    // Parallax effect for hero section
    window.addEventListener('scroll', function() {
        const scrolled = window.pageYOffset;
        const heroSection = document.querySelector('.hero-section');
        if (heroSection) {
            heroSection.style.transform = `translateY(${scrolled * 0.3}px)`;
        }
    });

    // Add hover effects to feature cards
    const featureCards = document.querySelectorAll('.feature-card');
    featureCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-20px) scale(1.02)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    // Add hover effects to form sections
    const formSections = document.querySelectorAll('.form-section');
    formSections.forEach(section => {
        section.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        
        section.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
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

<script>
    (function() {
        'use strict';
        
        // Global array to store selected images
        var selectedImages = [];
        
        window.addEventListener('load', function() {
            var forms = document.getElementsByClassName('needs-validation');
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    console.log('Form submission started');
                    console.log('Selected images count:', selectedImages.length);
                    
                    // Check if at least one image is selected
                    if (selectedImages.length === 0) {
                        event.preventDefault();
                        event.stopPropagation();
                        alert('Please select at least one image for your property listing.');
                        
                        // Scroll to images section
                        var imagesSection = document.querySelector('.file-upload-area');
                        if (imagesSection) {
                            imagesSection.scrollIntoView({ behavior: 'smooth' });
                        }
                        return false;
                    }
                    
                    // Check form validity
                    if (form.checkValidity() === false) {
                        console.log('Form validation failed');
                        event.preventDefault();
                        event.stopPropagation();
                        
                        // Show specific validation messages
                        showFieldValidationMessages(form);
                    } else {
                        console.log('Form validation passed, submitting...');
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);

        // Function to show specific validation messages for each field
        function showFieldValidationMessages(form) {
            var messages = [];
            
            // Check title field
            var titleField = form.querySelector('input[name="title"]');
            if (!titleField.value.trim()) {
                messages.push('Please enter the property title');
            }
            
            // Check description field
            var descriptionField = form.querySelector('textarea[name="description"]');
            if (!descriptionField.value.trim()) {
                messages.push('Please enter the property description');
            }
            
            // Check price field
            var priceField = form.querySelector('input[name="price"]');
            if (!priceField.value.trim() || parseFloat(priceField.value) <= 0) {
                messages.push('Please enter a valid price (greater than 0)');
            }
            
            // Check size field
            var sizeField = form.querySelector('input[name="size"]');
            if (!sizeField.value.trim() || parseFloat(sizeField.value) <= 0) {
                messages.push('Please enter a valid size (greater than 0)');
            }
            
            // Check location field
            var locationField = form.querySelector('input[name="location"]');
            if (!locationField.value.trim()) {
                messages.push('Please enter the property location');
            }
            
            // Show messages if any validation failed
            if (messages.length > 0) {
                alert('Please complete the following fields:\n\n• ' + messages.join('\n• '));
            }
        }

        // Initialize image preview functionality
        document.addEventListener('DOMContentLoaded', function() {
            var mainInput = document.getElementById('main-image-input');
            var addMoreBtn = document.getElementById('add-more-files');
            var thumbnailContainer = document.getElementById('thumbnail-container');
            var imageThumbnails = document.getElementById('image-thumbnails');
            

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
                    
                    document.getElementById('file-input-group').appendChild(input);
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

                // Show/hide warning message
                var warningDiv = document.getElementById('image-required-warning');
                if (selectedImages.length === 0) {
                    imageThumbnails.style.display = 'none';
                    if (warningDiv) {
                        warningDiv.style.display = 'block';
                    }
                    return;
                } else {
                    if (warningDiv) {
                        warningDiv.style.display = 'none';
                    }
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
                            // Recreate file inputs with only remaining images
                            recreateFileInputs();
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

            function recreateFileInputs() {
                var fileInputGroup = document.getElementById('file-input-group');
                var mainInput = document.getElementById('main-image-input');
                
                // Clear the main input
                mainInput.value = '';
                
                // Remove all additional file inputs and their remove buttons
                var additionalInputs = fileInputGroup.querySelectorAll('input[type="file"]:not(#main-image-input)');
                additionalInputs.forEach(function(input) {
                    var removeBtn = input.nextElementSibling;
                    if (removeBtn && removeBtn.classList.contains('remove-file')) {
                        fileInputGroup.removeChild(removeBtn);
                    }
                    fileInputGroup.removeChild(input);
                });
                
                // Create new file inputs for remaining images
                for (var i = 0; i < selectedImages.length; i++) {
                    if (i === 0) {
                        // Use the main input for the first image
                        var dt = new DataTransfer();
                        dt.items.add(selectedImages[i].file);
                        mainInput.files = dt.files;
                    } else {
                        // Create additional inputs for remaining images
                        var input = document.createElement('input');
                        input.type = 'file';
                        input.name = 'images';
                        input.className = 'form-control file-input enhanced-input mt-2';
                        input.setAttribute('accept', 'image/jpeg,image/png,image/jpg');
                        
                        var dt = new DataTransfer();
                        dt.items.add(selectedImages[i].file);
                        input.files = dt.files;
                        
                        var removeButton = document.createElement('span');
                        removeButton.className = 'remove-file btn btn-sm btn-outline-danger ms-2';
                        removeButton.innerHTML = '&times; Remove Input';
                        removeButton.addEventListener('click', function() {
                            fileInputGroup.removeChild(input);
                            fileInputGroup.removeChild(removeButton);
                        });
                        
                        fileInputGroup.appendChild(input);
                        fileInputGroup.appendChild(removeButton);
                    }
                }
            }
        });
    })();
</script>
</body>
</html>
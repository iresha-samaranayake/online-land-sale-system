<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- Last updated: 11:30 PM +0530, September 27, 2025 --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Land Sales System - Land Details</title>
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

        /* Futuristic Carousel */
        .carousel-inner {
            border-radius: 1.5rem;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .carousel-inner img {
            width: 100%;
            height: auto;
            max-height: 500px;
            object-fit: contain;
            transition: transform 0.3s ease;
        }

        .carousel-item:hover img {
            transform: scale(1.05);
        }

        .carousel-control-prev,
        .carousel-control-next {
            background: rgba(99, 102, 241, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            top: 50%;
            transform: translateY(-50%);
            opacity: 0.8;
            transition: all 0.3s ease;
        }

        .carousel-control-prev:hover,
        .carousel-control-next:hover {
            opacity: 1;
            transform: translateY(-50%) scale(1.1);
        }

        .no-image {
            color: var(--gray-500);
            font-style: italic;
            text-align: center;
            padding: 3rem;
            background: linear-gradient(135deg, var(--gray-100) 0%, var(--gray-200) 100%);
            border-radius: 1.5rem;
            font-size: 1.125rem;
        }

        /* Futuristic Detail Cards */
        .detail-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 1.5rem;
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
        }

        .detail-card::before {
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

        .detail-card:hover::before {
            opacity: 1;
        }

        .detail-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.15);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .detail-card .card-body {
            position: relative;
            z-index: 2;
        }

        .detail-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            margin-right: 1rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .detail-item {
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            padding: 1rem 1.5rem;
            margin-bottom: 1rem;
            border-radius: 1rem;
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
        }

        .detail-item:hover {
            background: rgba(99, 102, 241, 0.1);
            transform: translateX(5px);
        }

        .detail-item.price-item { border-left-color: var(--warning); }
        .detail-item.size-item { border-left-color: var(--info); }
        .detail-item.location-item { border-left-color: var(--danger); }
        .detail-item.status-item { border-left-color: var(--success); }

        .detail-content small {
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--gray-500);
            font-weight: 700;
            font-size: 0.875rem;
        }

        .detail-content span {
            font-weight: 700;
            color: var(--gray-800);
            font-size: 1.125rem;
        }

        .badge {
            border-radius: 50px;
            padding: 0.5rem 1rem;
            font-weight: 700;
            font-size: 0.875rem;
        }

        /* Seller Info */
        .seller-info {
            margin-top: 2rem;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-radius: 1.5rem;
            border-left: 4px solid var(--success);
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.1);
        }

        .seller-icon {
            font-size: 2rem;
            color: var(--success);
            margin-right: 1rem;
            filter: drop-shadow(0 2px 4px rgba(16, 185, 129, 0.3));
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
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            box-shadow: 0 10px 30px rgba(16, 185, 129, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(16, 185, 129, 0.6);
            background: linear-gradient(135deg, #059669 0%, #047857 100%);
        }

        .btn-secondary {
            border: 2px solid rgba(99, 102, 241, 0.3);
            color: var(--primary);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary);
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.2);
        }

        /* Rating System */
        .rating {
            display: inline-flex;
            flex-direction: row-reverse;
            gap: 0.5rem;
            padding: 1rem 0;
        }

        .rating input {
            display: none;
        }

        .rating label {
            cursor: pointer;
            font-size: 2rem;
            padding: 0 0.2rem;
            color: var(--gray-300);
            transition: all 0.3s ease;
        }

        .rating label i {
            transition: all 0.3s ease;
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
        }

        .rating:hover label i {
            color: var(--gray-400);
        }

        .rating input:checked ~ label i,
        .rating label:hover i,
        .rating label:hover ~ label i {
            color: var(--warning);
            transform: scale(1.2);
            filter: drop-shadow(0 4px 8px rgba(245, 158, 11, 0.4));
        }

        .stars {
            color: var(--warning);
            font-size: 1.5rem;
            filter: drop-shadow(0 2px 4px rgba(245, 158, 11, 0.3));
        }

        /* Review Items */
        .review-item {
            transition: all 0.3s ease;
            border-radius: 1rem;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .review-item:hover {
            background: rgba(99, 102, 241, 0.05);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.1);
        }

        /* Modal */
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
            
            .carousel-inner img {
                max-height: 300px;
            }
            
            .detail-card {
                margin-bottom: 2rem;
            }
        }

        @media (max-width: 576px) {
            .carousel-inner img {
                max-height: 250px;
            }
            
            .row {
                flex-direction: column;
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
        /* Simplified Property Information Layout */
        .property-info-section {
            background: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            border: 1px solid #e9ecef;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: #495057;
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid #e9ecef;
        }

        .section-title i {
            color: #667eea;
            margin-right: 0.5rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .info-item {
            background: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .info-item:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }

        .info-label {
            font-size: 0.8rem;
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .info-label i {
            color: #667eea;
            margin-right: 0.5rem;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 700;
            color: #212529;
        }

        .status-badge {
            background: #28a745;
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* Description Section */
        .description-section {
            background: white;
            border-radius: 0.75rem;
            padding: 1.5rem;
            border: 1px solid #e9ecef;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            height: fit-content;
        }

        .description-content {
            background: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
            border: 1px solid #e9ecef;
        }

        .description-content p {
            margin: 0;
            line-height: 1.6;
            color: #495057;
        }
        .card-land {
            background: white;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .card-land .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 1.5rem;
        }

        .card-land .card-header h2 {
            font-weight: 700;
            font-size: 1.75rem;
            margin: 0;
        }

        .card-land .card-body {
            padding: 2rem;
            background: white;
        }

        /* Simplified Detail Cards */
        .detail-card {
            background: white;
            border: 1px solid #e9ecef;
            border-radius: 0.75rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            height: 100%;
        }

        .detail-card:hover {
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .detail-card .card-body {
            padding: 1.5rem;
        }

        .detail-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .detail-card .card-title {
            font-size: 1.1rem;
            font-weight: 600;
        }

        /* Simplified Detail Items */
        .detail-item {
            padding: 0.75rem;
            background: #f8f9fa;
            border-radius: 0.5rem;
            margin-bottom: 0.75rem;
            transition: all 0.3s ease;
        }

        .detail-item:hover {
            background: #e9ecef;
        }

        .detail-item .detail-icon {
            width: 35px;
            height: 35px;
            font-size: 0.9rem;
            margin-right: 0.75rem;
        }

        .detail-content {
            flex: 1;
        }

        .detail-content small {
            font-size: 0.7rem;
            font-weight: 600;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: block;
            margin-bottom: 0.25rem;
        }

        .detail-content span {
            font-size: 0.95rem;
            font-weight: 600;
            color: #212529;
        }

        /* Enhanced Seller Info */
        .seller-info {
            background: rgba(99, 102, 241, 0.05);
            border-radius: 1.5rem;
            padding: 1.5rem;
            margin: 2rem 0;
            border: 1px solid rgba(99, 102, 241, 0.1);
        }

        .seller-info h5 {
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .seller-icon {
            font-size: 1.5rem;
            color: var(--primary);
            margin-right: 1rem;
        }

        /* Enhanced Action Buttons */
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border: none;
            border-radius: 1rem;
            padding: 0.75rem 2rem;
            font-weight: 700;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 35px rgba(99, 102, 241, 0.4);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid var(--primary);
            color: var(--primary);
            border-radius: 1rem;
            padding: 0.75rem 2rem;
            font-weight: 700;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary-dark);
            transform: translateY(-3px) scale(1.05);
            color: var(--primary-dark);
        }

        /* Enhanced Carousel */
        .carousel {
            border-radius: 1.5rem;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .carousel-item img {
            width: 100%;
            height: auto;
            max-height: 500px;
            object-fit: contain;
        }

        .carousel-control-prev,
        .carousel-control-next {
            width: 5%;
            background: rgba(0, 0, 0, 0.3);
            border-radius: 0.5rem;
            margin: 0 1rem;
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            width: 2rem;
            height: 2rem;
        }


        /* No Image Placeholder */
        .no-image {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--gray-500);
            font-size: 1.25rem;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 1.5rem;
            margin: 2rem 0;
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
                    <a class="nav-link active" href="/lands">Browse Lands</a>
                </li>
                <c:if test="${not empty loggedInUser}">
                    <li class="nav-item">
                        <a class="nav-link" href="/dashboard">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                    </li>
                </c:if>
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
                <h1 class="display-4 fw-bold mb-4">Land Details</h1>
                <p class="lead mb-4">
                    Explore the details of this land listing, including images and seller info.
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
                        <h2 class="mb-0">${land.title}</h2>
                    </div>
                    <div class="card-body">
                        <!-- Image Carousel -->
                        <div id="landImageCarousel" class="carousel slide">
                            <c:choose>
                                <c:when test="${not empty land.images and fn:length(land.images) > 0}">
                                    <div class="carousel-inner">
                                        <c:forEach var="image" items="${land.images}" varStatus="loop">
                                            <div class="carousel-item ${loop.first ? 'active' : ''}">
                                                <img src="${image.imageUrl}" alt="Land Image" class="d-block w-100">
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <c:if test="${fn:length(land.images) > 1}">
                                        <button class="carousel-control-prev" type="button" data-bs-target="#landImageCarousel" data-bs-slide="prev">
                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Previous</span>
                                        </button>
                                        <button class="carousel-control-next" type="button" data-bs-target="#landImageCarousel" data-bs-slide="next">
                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Next</span>
                                        </button>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <p class="no-image">No images available.</p>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Simplified Details Layout -->
                        <div class="row mt-4">
                            <!-- Property Information -->
                            <div class="col-lg-8 mb-4">
                                <div class="property-info-section">
                                    <h4 class="section-title">
                                        <i class="fas fa-info-circle"></i> Property Information
                                    </h4>
                                    
                                    <div class="info-grid">
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
                                                <i class="fas fa-check-circle"></i> Status
                                            </div>
                                            <div class="info-value">
                                                <span class="status-badge">${land.status}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Description -->
                            <div class="col-lg-4 mb-4">
                                <div class="description-section">
                                    <h4 class="section-title">
                                        <i class="fas fa-align-left"></i> Description
                                    </h4>
                                    <div class="description-content">
                                        <p>${land.description}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Seller Information -->
                        <div class="seller-info">
                            <h5 class="text-muted mb-3">Seller Info</h5>
                            <div class="d-flex align-items-center">
                                <i class="fas fa-user-tie seller-icon"></i>
                                <span class="fw-bold">${land.seller.name}</span>
                            </div>
                            <c:if test="${not empty land.approvedBy}">
                                <p class="text-muted mt-2">Approved By: ${land.approvedBy.name}</p>
                            </c:if>
                        </div>

                         <!-- Action Buttons -->
                         <div class="mt-4">
                             <c:if test="${not empty loggedInUser and loggedInUser.role == 'BUYER' and loggedInUser.id != land.seller.id}">
                                 <c:if test="${land.status == 'AVAILABLE'}">
                                     <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#requestModal">
                                         <i class="fas fa-paper-plane"></i> Make a Request
                                     </button>
                                 </c:if>
                             </c:if>
                             <a href="/lands" class="btn btn-secondary btn-lg">
                                 <i class="fas fa-arrow-left"></i> Back to Listings
                             </a>
                         </div>

                    </div>
                </div>
            </div>

            <!-- Request Modal -->
            <div class="modal fade" id="requestModal" tabindex="-1" aria-labelledby="requestModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white;">
                            <h5 class="modal-title" id="requestModalLabel">
                                <i class="fas fa-paper-plane"></i> Make a Request for ${land.title}
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="/requests/submit" method="post" id="requestForm">
                            <div class="modal-body">
                                <input type="hidden" name="landId" value="${land.id}">

                                <div class="mb-3">
                                    <label for="requestType" class="form-label fw-bold">Request Type <span class="text-danger">*</span></label>
                                    <select class="form-select" id="requestType" name="requestType" required>
                                        <option value="">-- Select Request Type --</option>
                                        <option value="RESERVE">Reserve</option>
                                        <option value="PURCHASE">Purchase</option>
                                    </select>
                                    <div class="form-text">Choose whether you want to reserve or purchase this land.</div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="contactPhone" class="form-label fw-bold">Contact Phone <span class="text-danger">*</span></label>
                                        <input type="tel" class="form-control" id="contactPhone" name="contactPhone"
                                               pattern="[0-9+\-\s()]+"
                                               minlength="10"
                                               maxlength="20"
                                               placeholder="+94 77 123 4567"
                                               required>
                                        <div class="form-text">Enter your contact phone number (10-20 digits)</div>
                                        <div class="invalid-feedback">
                                            Please provide a valid phone number.
                                        </div>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label for="contactEmail" class="form-label fw-bold">Contact Email <span class="text-danger">*</span></label>
                                        <input type="email" class="form-control" id="contactEmail" name="contactEmail"
                                               placeholder="your.email@example.com"
                                               maxlength="100"
                                               required>
                                        <div class="form-text">We'll use this to send updates</div>
                                        <div class="invalid-feedback">
                                            Please provide a valid email address.
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="preferredContactTime" class="form-label fw-bold">Preferred Contact Time</label>
                                    <select class="form-select" id="preferredContactTime" name="preferredContactTime">
                                        <option value="">-- Select Preferred Time (Optional) --</option>
                                        <option value="Morning (8AM - 12PM)">Morning (8AM - 12PM)</option>
                                        <option value="Afternoon (12PM - 4PM)">Afternoon (12PM - 4PM)</option>
                                        <option value="Evening (4PM - 8PM)">Evening (4PM - 8PM)</option>
                                        <option value="Anytime">Anytime</option>
                                    </select>
                                    <div class="form-text">When would you prefer to be contacted?</div>
                                </div>

                                <div class="mb-3">
                                    <label for="message" class="form-label fw-bold">Additional Message (Optional)</label>
                                    <textarea class="form-control" id="message" name="message" rows="3"
                                              maxlength="1000"
                                              placeholder="Add any additional information or questions for the seller..."></textarea>
                                    <div class="form-text">
                                        <span id="charCount">0</span>/1000 characters
                                    </div>
                                </div>

                                <div class="alert alert-info mb-0">
                                    <i class="fas fa-info-circle"></i>
                                    <small>Your request will be sent to the seller for review. You will be notified of their response.</small>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                    <i class="fas fa-times"></i> Cancel
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-paper-plane"></i> Submit Request
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Reviews Section -->
            <div class="col-12 mt-4">
                <div class="card">
                    <div class="card-header" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white;">
                        <h4 class="mb-0">
                            <c:choose>
                                <c:when test="${loggedInUser.role == 'ADMIN' || loggedInUser.role == 'STAFF'}">
                                    Seller Rating Summary
                                </c:when>
                                <c:otherwise>
                                    Reviews and Ratings
                                </c:otherwise>
                            </c:choose>
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Seller Rating Display -->
                        <div class="text-center mb-4">
                            <h3>Seller Rating</h3>
                            <div class="display-4 mb-2" id="averageRating">
                                <c:set var="avgRating" value="${sellerRating != null ? sellerRating : 0}" />
                                <span class="text-warning">${avgRating}</span>/5
                            </div>
                            <div class="stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fas fa-star ${i <= avgRating ? 'text-warning' : 'text-muted'}"></i>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Review Form -->
                        <c:if test="${not empty loggedInUser && !hasReviewed && loggedInUser.role == 'BUYER'}">
                            <div class="review-form mb-4">
                                <h5>Write a Review</h5>
                                <!-- Show validation error message if present -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">
                                        <i class="fas fa-exclamation-circle"></i> ${error}
                                    </div>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/reviews/create/${land.seller.id}" method="POST" id="reviewForm">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="landId" value="${land.id}" />
                                    <div class="mb-3">
                                        <label class="form-label">Rating</label>
                                        <div class="rating" id="ratingStars">
                                            <input type="radio" name="rating" value="5" id="star5" required ${review.rating == 5 ? 'checked' : ''}>
                                            <label for="star5"><i class="fas fa-star"></i></label>
                                            <input type="radio" name="rating" value="4" id="star4" required ${review.rating == 4 ? 'checked' : ''}>
                                            <label for="star4"><i class="fas fa-star"></i></label>
                                            <input type="radio" name="rating" value="3" id="star3" required ${review.rating == 3 ? 'checked' : ''}>
                                            <label for="star3"><i class="fas fa-star"></i></label>
                                            <input type="radio" name="rating" value="2" id="star2" required ${review.rating == 2 ? 'checked' : ''}>
                                            <label for="star2"><i class="fas fa-star"></i></label>
                                            <input type="radio" name="rating" value="1" id="star1" required ${review.rating == 1 ? 'checked' : ''}>
                                            <label for="star1"><i class="fas fa-star"></i></label>
                                        </div>
                                        <small class="text-muted">Click on a star to rate</small>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Title</label>
                                        <input type="text" class="form-control ${not empty error ? 'is-invalid' : ''}" 
                                               name="title" required maxlength="100" value="${review.title}">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Comment</label>
                                        <textarea class="form-control ${not empty error ? 'is-invalid' : ''}" 
                                                  name="comment" rows="3" maxlength="1000">${review.comment}</textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit Review</button>
                                </form>
                            </div>
                        </c:if>

                        <!-- Reviews List -->
                        <c:if test="${loggedInUser.role == 'BUYER' || (loggedInUser.role == 'SELLER' && loggedInUser.id == land.seller.id)}">
                            <div class="reviews-list">
                                <c:choose>
                                    <c:when test="${not empty reviews}">
                                        <c:forEach items="${reviews}" var="review">
                                        <div class="review-item border-bottom py-3">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <h6 class="mb-1">${review.title}</h6>
                                                    <div class="stars mb-2">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-muted'}"></i>
                                                        </c:forEach>
                                                    </div>
                                                    <p class="mb-1">${review.comment}</p>
                                                    <small class="text-muted">By ${review.reviewer.name} on ${review.createdAt}</small>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                            </c:choose>
                        </div>
                        </c:if>
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
                <h3 class="fw-bold text-primary">1,500+</h3>
                <p class="text-muted">Properties Listed</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-success">850+</h3>
                <p class="text-muted">Happy Customers</p>
            </div>
            <div class="col-md-3">
                <h3 class="fw-bold text-warning">95%</h3>
                <p class="text-muted">Success Rate</p>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Touch/Swipe Support for Carousel -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const carousel = document.getElementById('landImageCarousel');
    if (!carousel) return;
    
    // Initialize Bootstrap carousel to ensure it works properly
    const carouselItems = carousel.querySelectorAll('.carousel-item');
    if (carouselItems.length > 1) {
        // Remove data-bs-ride to prevent auto-initialization
        carousel.removeAttribute('data-bs-ride');
        
        // Initialize carousel with proper settings
        const bsCarousel = new bootstrap.Carousel(carousel, {
            interval: false, // Disable auto-play
            wrap: true,
            touch: true
        });
    }
    
    let startX = 0;
    let startY = 0;
    let endX = 0;
    let endY = 0;
    let isDragging = false;
    
    // Touch events
    carousel.addEventListener('touchstart', function(e) {
        startX = e.touches[0].clientX;
        startY = e.touches[0].clientY;
        isDragging = true;
    }, { passive: true });
    
    carousel.addEventListener('touchmove', function(e) {
        if (!isDragging) return;
        endX = e.touches[0].clientX;
        endY = e.touches[0].clientY;
    }, { passive: true });
    
    carousel.addEventListener('touchend', function(e) {
        if (!isDragging) return;
        isDragging = false;
        
        const deltaX = endX - startX;
        const deltaY = endY - startY;
        
        // Only trigger swipe if horizontal movement is greater than vertical
        if (Math.abs(deltaX) > Math.abs(deltaY) && Math.abs(deltaX) > 50) {
            if (deltaX > 0) {
                // Swipe right - go to previous slide
                const prevButton = carousel.querySelector('.carousel-control-prev');
                if (prevButton) {
                    prevButton.click();
                }
            } else {
                // Swipe left - go to next slide
                const nextButton = carousel.querySelector('.carousel-control-next');
                if (nextButton) {
                    nextButton.click();
                }
            }
        }
    }, { passive: true });
    
    // Mouse events for desktop (optional)
    carousel.addEventListener('mousedown', function(e) {
        startX = e.clientX;
        startY = e.clientY;
        isDragging = true;
        e.preventDefault();
    });
    
    carousel.addEventListener('mousemove', function(e) {
        if (!isDragging) return;
        endX = e.clientX;
        endY = e.clientY;
    });
    
    carousel.addEventListener('mouseup', function(e) {
        if (!isDragging) return;
        isDragging = false;
        
        const deltaX = endX - startX;
        const deltaY = endY - startY;
        
        if (Math.abs(deltaX) > Math.abs(deltaY) && Math.abs(deltaX) > 50) {
            if (deltaX > 0) {
                const prevButton = carousel.querySelector('.carousel-control-prev');
                if (prevButton) {
                    prevButton.click();
                }
            } else {
                const nextButton = carousel.querySelector('.carousel-control-next');
                if (nextButton) {
                    nextButton.click();
                }
            }
        }
    });
    
    // Prevent default drag behavior on images
    const images = carousel.querySelectorAll('img');
    images.forEach(img => {
        img.addEventListener('dragstart', function(e) {
            e.preventDefault();
        });
    });
});
</script>

<!-- Review System Scripts -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Star Rating Initialization
    const ratingContainer = document.getElementById('ratingStars');
    const ratingInputs = ratingContainer.querySelectorAll('input[type="radio"]');
    const ratingLabels = ratingContainer.querySelectorAll('label');
    
    // Add hover effect
    ratingLabels.forEach(label => {
        label.addEventListener('mouseover', function() {
            const currentRating = this.getAttribute('for').replace('star', '');
            updateStarsDisplay(currentRating, 'hover');
        });
        
        label.addEventListener('mouseout', function() {
            const selectedRating = ratingContainer.querySelector('input[type="radio"]:checked');
            if (selectedRating) {
                updateStarsDisplay(selectedRating.value, 'selected');
            } else {
                resetStarsDisplay();
            }
        });
    });
    
    // Add click effect
    ratingInputs.forEach(input => {
        input.addEventListener('change', function() {
            updateStarsDisplay(this.value, 'selected');
        });
    });
    
    function updateStarsDisplay(rating, state) {
        ratingLabels.forEach(label => {
            const starValue = label.getAttribute('for').replace('star', '');
            if (starValue <= rating) {
                if (state === 'hover') {
                    label.querySelector('i').style.color = '#ffd700';
                } else {
                    label.querySelector('i').style.color = '#ffc107';
                }
            } else {
                label.querySelector('i').style.color = '#ddd';
            }
        });
    }
    
    function resetStarsDisplay() {
        ratingLabels.forEach(label => {
            label.querySelector('i').style.color = '#ddd';
        });
    }


    

    // Handle review form submission
    const reviewForm = document.getElementById('reviewForm');
    if (reviewForm) {
        reviewForm.addEventListener('submit', function(e) {
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Submitting...';
            submitBtn.disabled = true;
            
            // Let the form submit normally - the server will redirect back to this page
            // with updated rating data
        });
    }
});
</script>

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
         const cards = document.querySelectorAll('.card-land, .detail-card');
         cards.forEach(card => {
             card.addEventListener('mouseenter', function() {
                 this.style.transform = 'translateY(-10px) scale(1.01)';
             });
             
             card.addEventListener('mouseleave', function() {
                 this.style.transform = 'translateY(0) scale(1)';
             });
         });

         // Simple modal fix
         const button = document.querySelector('button[data-bs-target="#requestModal"]');
         const modal = document.getElementById('requestModal');
         
         if (button && modal) {
             button.addEventListener('click', function(e) {
                 e.preventDefault();
                 console.log('Button clicked, opening modal...');
                 
                 // Show modal manually
                 modal.style.display = 'block';
                 modal.classList.add('show');
                 modal.setAttribute('aria-hidden', 'false');
                 document.body.classList.add('modal-open');
                 
                 // Add backdrop
                 const backdrop = document.createElement('div');
                 backdrop.className = 'modal-backdrop fade show';
                 backdrop.style.position = 'fixed';
                 backdrop.style.top = '0';
                 backdrop.style.left = '0';
                 backdrop.style.width = '100%';
                 backdrop.style.height = '100%';
                 backdrop.style.backgroundColor = 'rgba(0,0,0,0.5)';
                 backdrop.style.zIndex = '1040';
                 backdrop.id = 'modalBackdrop';
                 document.body.appendChild(backdrop);
                 
                 console.log('Modal should be visible now');
             });
             
             // Close modal when clicking close buttons
             const closeButtons = modal.querySelectorAll('[data-bs-dismiss="modal"], .btn-close');
             closeButtons.forEach(btn => {
                 btn.addEventListener('click', function() {
                     modal.style.display = 'none';
                     modal.classList.remove('show');
                     modal.setAttribute('aria-hidden', 'true');
                     document.body.classList.remove('modal-open');
                     
                     const backdrop = document.getElementById('modalBackdrop');
                     if (backdrop) {
                         backdrop.remove();
                     }
                 });
             });
         }
     });

     // Form validation
     (function() {
         'use strict';

         // Character count for message
         const messageTextarea = document.getElementById('message');
         const charCount = document.getElementById('charCount');

         if (messageTextarea && charCount) {
             messageTextarea.addEventListener('input', function() {
                 charCount.textContent = this.value.length;
                 if (this.value.length > 900) {
                     charCount.style.color = '#dc3545';
                 } else {
                     charCount.style.color = '#6c757d';
                 }
             });
         }

         // Form validation
         const form = document.getElementById('requestForm');

         if (form) {
             form.addEventListener('submit', function(event) {
                 if (!form.checkValidity()) {
                     event.preventDefault();
                     event.stopPropagation();
                 }

                 // Additional phone validation
                 const phoneInput = document.getElementById('contactPhone');
                 const phonePattern = /^[0-9+\-\s()]+$/;
                 const phoneDigits = phoneInput.value.replace(/[^0-9]/g, '');

                 if (phoneDigits.length < 10 || phoneDigits.length > 15) {
                     event.preventDefault();
                     phoneInput.setCustomValidity('Phone number must contain 10-15 digits');
                     phoneInput.classList.add('is-invalid');
                 } else if (!phonePattern.test(phoneInput.value)) {
                     event.preventDefault();
                     phoneInput.setCustomValidity('Phone number can only contain digits, spaces, +, -, and ()');
                     phoneInput.classList.add('is-invalid');
                 } else {
                     phoneInput.setCustomValidity('');
                     phoneInput.classList.remove('is-invalid');
                 }

                 // Email validation
                 const emailInput = document.getElementById('contactEmail');
                 const emailPattern = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

                 if (!emailPattern.test(emailInput.value)) {
                     event.preventDefault();
                     emailInput.setCustomValidity('Please enter a valid email address');
                     emailInput.classList.add('is-invalid');
                 } else {
                     emailInput.setCustomValidity('');
                     emailInput.classList.remove('is-invalid');
                 }

                 form.classList.add('was-validated');
             }, false);

             // Real-time validation feedback
             const phoneInput = document.getElementById('contactPhone');
             if (phoneInput) {
                 phoneInput.addEventListener('input', function() {
                     this.setCustomValidity('');
                     this.classList.remove('is-invalid');
                 });
             }

             const emailInput = document.getElementById('contactEmail');
             if (emailInput) {
                 emailInput.addEventListener('input', function() {
                     this.setCustomValidity('');
                     this.classList.remove('is-invalid');
                 });
             }
         }

         // Reset form when modal is closed
         const requestModal = document.getElementById('requestModal');
         if (requestModal) {
             requestModal.addEventListener('hidden.bs.modal', function() {
                 if (form) {
                     form.reset();
                     form.classList.remove('was-validated');
                     if (charCount) {
                         charCount.textContent = '0';
                         charCount.style.color = '#6c757d';
                     }
                 }
             });
         }
     })();
 </script>

</body>
</html>
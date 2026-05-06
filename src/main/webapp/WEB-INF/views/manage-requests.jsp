<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Requests - Online Land Sales System</title>
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

        .floating-elements::before,
        .floating-elements::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 20s infinite linear;
        }

        .floating-elements::before {
            width: 200px;
            height: 200px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-elements::after {
            width: 150px;
            height: 150px;
            top: 60%;
            right: 15%;
            animation-delay: -10s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Glassmorphism Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1000;
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: white !important;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        /* Modern Cards */
        .request-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .request-card::before {
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

        .request-card:hover::before {
            opacity: 1;
        }

        .request-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 40px 80px rgba(99, 102, 241, 0.2);
            border-color: rgba(99, 102, 241, 0.3);
        }

        .request-card .card-body {
            position: relative;
            z-index: 2;
        }

        /* Status Badges */
        .status-badge {
            font-weight: 700;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: linear-gradient(135deg, var(--warning) 0%, #d97706 100%);
            color: white;
        }

        .status-approved {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            color: white;
        }

        .status-rejected {
            background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
            color: white;
        }

        /* Role Badges */
        .role-badge {
            font-weight: 700;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .admin-badge {
            background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
            color: white;
        }

        .seller-badge {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
        }

        /* Modern Buttons */
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

        .btn-success {
            background: linear-gradient(135deg, var(--success) 0%, #059669 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.4);
        }

        .btn-info {
            background: linear-gradient(135deg, var(--info) 0%, #0891b2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(6, 182, 212, 0.4);
        }

        .btn-outline-primary {
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.3);
            color: white;
            backdrop-filter: blur(10px);
        }

        .btn-outline-primary:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.5);
            color: white;
        }

        /* Page Header */
        .page-header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            padding: 2rem;
            margin-bottom: 2rem;
            position: relative;
            z-index: 2;
        }

        .page-title {
            color: white;
            font-weight: 800;
            font-size: 2.5rem;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            margin-bottom: 1rem;
        }

        /* Request Type Badge */
        .request-type-badge {
            background: linear-gradient(135deg, var(--info) 0%, #0891b2 100%);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.875rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Contact Info Styling */
        .contact-info {
            background: rgba(99, 102, 241, 0.1);
            border-radius: 1rem;
            padding: 1rem;
            margin: 0.5rem 0;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .contact-item:last-child {
            margin-bottom: 0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            color: white;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.7;
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 2rem;
            border: none;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            border-radius: 2rem 2rem 0 0;
            padding: 1.5rem 2rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .modal-body {
            padding: 2rem;
        }

        .modal-footer {
            border-radius: 0 0 2rem 2rem;
            padding: 1.5rem 2rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-title {
                font-size: 2rem;
            }
            
            .request-card {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <!-- Floating Elements -->
    <div class="floating-elements"></div>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">
            <a class="navbar-brand" href="/">
            <i class="fas fa-map-marked-alt"></i> LandSales Portal
        </a>
        <div class="navbar-nav ms-auto">
            <a href="/dashboard" class="btn btn-outline-primary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-5 pt-5">
    <div class="row">
        <div class="col-12">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="page-title">
                    <i class="fas fa-clipboard-list"></i> 
                    <c:choose>
                        <c:when test="${isAdmin}">
                                        All System Requests
                                    </c:when>
                                    <c:otherwise>
                                        Requests on My Lands
                                    </c:otherwise>
                                </c:choose>
                            </h1>
                            <div class="d-flex align-items-center gap-3">
                                <c:choose>
                                    <c:when test="${isAdmin}">
                                        <span class="role-badge admin-badge">ADMIN VIEW</span>
                        </c:when>
                        <c:otherwise>
                                        <span class="role-badge seller-badge">SELLER VIEW</span>
                        </c:otherwise>
                    </c:choose>
                                <span class="badge bg-light text-dark">Total: ${fn:length(requests)}</span>
                            </div>
                        </div>
                    </div>
            </div>
            
                <!-- Success/Error Messages -->
            <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show" style="background: rgba(16, 185, 129, 0.1); border: 1px solid rgba(16, 185, 129, 0.3); color: var(--success);">
                    <i class="fas fa-check-circle"></i> ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: var(--danger);">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty requests}">
                        <div class="empty-state">
                            <i class="fas fa-clipboard-list"></i>
                            <h3>No Requests Found</h3>
                            <p>
                        <c:choose>
                            <c:when test="${isAdmin}">
                                No requests found in the system yet.
                            </c:when>
                            <c:otherwise>
                                No requests found on your lands yet.
                            </c:otherwise>
                        </c:choose>
                            </p>
                    </div>
                </c:when>
                <c:otherwise>
                        <!-- Request Cards -->
                        <div class="row">
                                <c:forEach var="request" items="${requests}">
                                <div class="col-lg-6 col-xl-4 mb-4">
                                    <div class="request-card">
                                        <div class="card-body">
                                            <!-- Request Header -->
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div>
                                                    <h5 class="card-title mb-1">Request #${request.id}</h5>
                                        <c:if test="${isAdmin}">
                                                        <small class="text-muted">Seller: ${request.land.seller.name}</small>
                                        </c:if>
                                                </div>
                                                <c:choose>
                                                    <c:when test="${request.status == 'PENDING'}">
                                                        <span class="status-badge status-pending">${request.status.displayName}</span>
                                                    </c:when>
                                                    <c:when test="${request.status == 'APPROVED'}">
                                                        <span class="status-badge status-approved">${request.status.displayName}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-rejected">${request.status.displayName}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <!-- Land Information -->
                                            <div class="mb-3">
                                                <h6 class="text-primary mb-1">
                                                    <i class="fas fa-map-marker-alt"></i> ${request.land.title}
                                                </h6>
                                                <small class="text-muted">${request.land.location}</small>
                                            </div>

                                            <!-- Request Type -->
                                            <div class="mb-3">
                                                <span class="request-type-badge">${request.requestType.displayName}</span>
                                            </div>

                                            <!-- Requester Information -->
                                            <div class="mb-3">
                                                <h6 class="mb-2">
                                                    <i class="fas fa-user"></i> Requester Details
                                                </h6>
                                                <p class="mb-1"><strong>Name:</strong> ${request.requester.name}</p>
                                                <p class="mb-1"><strong>Email:</strong> ${request.requester.email}</p>
                                            </div>

                                            <!-- Contact Information -->
                                            <div class="contact-info mb-3">
                                                <h6 class="mb-2">
                                                    <i class="fas fa-phone"></i> Contact Information
                                                </h6>
                                                <div class="contact-item">
                                                <i class="fas fa-phone text-primary"></i> 
                                                    <span>
                                                    <c:choose>
                                                        <c:when test="${not empty request.contactPhone}">
                                                            ${request.contactPhone}
                                                        </c:when>
                                                        <c:otherwise>
                                                                <em class="text-muted">Not provided</em>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    </span>
                                            </div>
                                                <div class="contact-item">
                                                <i class="fas fa-envelope text-success"></i> 
                                                    <span>
                                                    <c:choose>
                                                        <c:when test="${not empty request.contactEmail}">
                                                            ${request.contactEmail}
                                                        </c:when>
                                                        <c:otherwise>
                                                                <em class="text-muted">Not provided</em>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    </span>
                                                </div>
                                                <c:if test="${not empty request.preferredContactTime}">
                                                    <div class="contact-item">
                                                        <i class="fas fa-clock text-warning"></i>
                                                        <span>${request.preferredContactTime}</span>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <!-- Message -->
                                            <c:if test="${not empty request.message}">
                                                <div class="mb-3">
                                                    <h6 class="mb-2">
                                                        <i class="fas fa-comment"></i> Message
                                                    </h6>
                                                    <p class="text-muted">${request.message}</p>
                                                </div>
                                            </c:if>

                                            <!-- Date -->
                                            <div class="mb-3">
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar"></i> 
                                                    ${fn:substring(request.createdAt, 0, 10)} at ${fn:substring(request.createdAt, 11, 16)}
                                                </small>
                                            </div>

                                            <!-- Actions -->
                                            <div class="d-flex gap-2">
                                            <c:if test="${request.status == 'PENDING'}">
                                                    <button type="button" class="btn btn-success flex-fill" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#approveModal${request.id}">
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                                    <button type="button" class="btn btn-danger flex-fill" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#rejectModal${request.id}">
                                                    <i class="fas fa-times"></i> Reject
                                                </button>
                                            </c:if>
                                            <c:if test="${request.status != 'PENDING'}">
                                                    <button type="button" class="btn btn-info w-100" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#detailsModal${request.id}">
                                                        <i class="fas fa-info-circle"></i> View Details
                                                </button>
                                            </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                    <!-- Approve Modal -->
                                    <div class="modal fade" id="approveModal${request.id}" tabindex="-1">
                                    <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                            <div class="modal-header" style="background: linear-gradient(135deg, var(--success) 0%, #059669 100%); color: white;">
                                                <h5 class="modal-title">
                                                    <i class="fas fa-check-circle"></i> Approve Request #${request.id}
                                                </h5>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                </div>
                                                <form action="/requests/approve/${request.id}" method="post">
                                                    <div class="modal-body">
                                                    <div class="alert alert-light border-0 mb-4" style="background: rgba(16, 185, 129, 0.1);">
                                                        <h6 class="mb-3">
                                                            <i class="fas fa-info-circle text-success"></i> 
                                                            Approve ${request.requestType.displayName} request from <strong>${request.requester.name}</strong> for <strong>${request.land.title}</strong>?
                                                        </h6>
                                                    </div>
                                                    
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="contact-info">
                                                                <h6 class="mb-3">
                                                                    <i class="fas fa-user-circle"></i> Contact Information
                                                                </h6>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-user text-primary"></i>
                                                                    <span><strong>Name:</strong> ${request.requester.name}</span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-phone text-primary"></i>
                                                                    <span><strong>Phone:</strong> 
                                                                <c:choose>
                                                                    <c:when test="${not empty request.contactPhone}">
                                                                                <a href="tel:${request.contactPhone}" class="text-decoration-none">${request.contactPhone}</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <em class="text-muted">Not provided</em>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                    </span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-envelope text-success"></i>
                                                                    <span><strong>Email:</strong> 
                                                                <c:choose>
                                                                    <c:when test="${not empty request.contactEmail}">
                                                                                <a href="mailto:${request.contactEmail}" class="text-decoration-none">${request.contactEmail}</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <em class="text-muted">Not provided</em>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                    </span>
                                                                </div>
                                                            <c:if test="${not empty request.preferredContactTime}">
                                                                    <div class="contact-item">
                                                                        <i class="fas fa-clock text-warning"></i>
                                                                        <span><strong>Preferred Contact Time:</strong> ${request.preferredContactTime}</span>
                                                                    </div>
                                                            </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <c:if test="${not empty request.message}">
                                                                <div class="mb-3">
                                                                    <h6 class="mb-2">
                                                                        <i class="fas fa-comment"></i> Message
                                                                    </h6>
                                                                    <div class="p-3" style="background: rgba(99, 102, 241, 0.1); border-radius: 1rem;">
                                                                <p class="mb-0 text-muted">${request.message}</p>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        </div>
                                                        
                                                        <div class="mb-3">
                                                        <label class="form-label">
                                                            <i class="fas fa-reply"></i> Response Message (Optional)
                                                        </label>
                                                            <textarea class="form-control" name="responseMessage" rows="3" 
                                                                  placeholder="Add any message for the requester..." 
                                                                  style="border-radius: 1rem; border: 2px solid var(--gray-200);"></textarea>
                                                    </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                        <i class="fas fa-times"></i> Cancel
                                                    </button>
                                                    <button type="submit" class="btn btn-success">
                                                        <i class="fas fa-check"></i> Approve Request
                                                    </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Reject Modal -->
                                    <div class="modal fade" id="rejectModal${request.id}" tabindex="-1">
                                    <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                            <div class="modal-header" style="background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%); color: white;">
                                                <h5 class="modal-title">
                                                    <i class="fas fa-times-circle"></i> Reject Request #${request.id}
                                                </h5>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                </div>
                                                <form action="/requests/reject/${request.id}" method="post">
                                                    <div class="modal-body">
                                                    <div class="alert alert-light border-0 mb-4" style="background: rgba(239, 68, 68, 0.1);">
                                                        <h6 class="mb-3">
                                                            <i class="fas fa-exclamation-triangle text-danger"></i> 
                                                            Reject ${request.requestType.displayName} request from <strong>${request.requester.name}</strong> for <strong>${request.land.title}</strong>?
                                                        </h6>
                                                    </div>
                                                    
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="contact-info">
                                                                <h6 class="mb-3">
                                                                    <i class="fas fa-user-circle"></i> Contact Information
                                                                </h6>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-user text-primary"></i>
                                                                    <span><strong>Name:</strong> ${request.requester.name}</span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-phone text-primary"></i>
                                                                    <span><strong>Phone:</strong> 
                                                                <c:choose>
                                                                    <c:when test="${not empty request.contactPhone}">
                                                                        ${request.contactPhone}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <em class="text-muted">Not provided</em>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                    </span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-envelope text-success"></i>
                                                                    <span><strong>Email:</strong> 
                                                                <c:choose>
                                                                    <c:when test="${not empty request.contactEmail}">
                                                                        ${request.contactEmail}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <em class="text-muted">Not provided</em>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                    </span>
                                                                </div>
                                                            <c:if test="${not empty request.preferredContactTime}">
                                                                    <div class="contact-item">
                                                                        <i class="fas fa-clock text-warning"></i>
                                                                        <span><strong>Preferred Contact Time:</strong> ${request.preferredContactTime}</span>
                                                                    </div>
                                                            </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <c:if test="${not empty request.message}">
                                                        <div class="mb-3">
                                                                    <h6 class="mb-2">
                                                                        <i class="fas fa-comment"></i> Message
                                                                    </h6>
                                                                    <div class="p-3" style="background: rgba(99, 102, 241, 0.1); border-radius: 1rem;">
                                                                        <p class="mb-0 text-muted">${request.message}</p>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="mb-3">
                                                        <label class="form-label">
                                                            <i class="fas fa-exclamation-circle text-danger"></i> Reason for Rejection <span class="text-danger">*</span>
                                                        </label>
                                                        <textarea class="form-control" name="responseMessage" rows="3" 
                                                                  placeholder="Please provide a reason for rejection..." required
                                                                  style="border-radius: 1rem; border: 2px solid var(--gray-200);"></textarea>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                        <i class="fas fa-times"></i> Cancel
                                                    </button>
                                                    <button type="submit" class="btn btn-danger">
                                                        <i class="fas fa-times"></i> Reject Request
                                                    </button>
                                                    </div>
                                                </form>
                                        </div>
                                        </div>
                                    </div>

                                <!-- Details Modal for processed requests -->
                                <c:if test="${request.status != 'PENDING'}">
                                    <div class="modal fade" id="detailsModal${request.id}" tabindex="-1">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header" style="background: linear-gradient(135deg, var(--info) 0%, #0891b2 100%); color: white;">
                                                    <h5 class="modal-title">
                                                        <i class="fas fa-info-circle"></i> Request Details #${request.id}
                                                    </h5>
                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="contact-info mb-4">
                                                                <h6 class="mb-3">
                                                                    <i class="fas fa-user-check"></i> Processing Information
                                                                </h6>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-user text-primary"></i>
                                                                    <span><strong>Processed By:</strong> ${request.processedBy.name}</span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-calendar text-success"></i>
                                                                    <span><strong>Processed At:</strong> 
                                                                        ${fn:substring(request.processedAt, 0, 10)} at ${fn:substring(request.processedAt, 11, 16)}
                                                                    </span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <c:choose>
                                                                        <c:when test="${request.status == 'APPROVED'}">
                                                                            <i class="fas fa-check-circle text-success"></i>
                                                                            <span><strong>Status:</strong> <span class="status-badge status-approved">${request.status.displayName}</span></span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <i class="fas fa-times-circle text-danger"></i>
                                                                            <span><strong>Status:</strong> <span class="status-badge status-rejected">${request.status.displayName}</span></span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="mb-3">
                                                                <h6 class="mb-2">
                                                                    <i class="fas fa-reply"></i> Response Message
                                                                </h6>
                                                                <div class="p-3" style="background: rgba(6, 182, 212, 0.1); border-radius: 1rem;">
                                                                    <c:choose>
                                                                        <c:when test="${not empty request.responseMessage}">
                                                                            <p class="mb-0">${request.responseMessage}</p>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <p class="mb-0 text-muted"><em>No response message provided</em></p>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                        <i class="fas fa-times"></i> Close
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


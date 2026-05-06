<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Submitted Requests - Online Land Sales System</title>
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

        /* Card Header */
        .card-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            border-radius: 2rem 2rem 0 0;
            padding: 1.5rem 2rem;
            font-weight: 700;
            font-size: 1.125rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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

        .btn-outline-primary {
            background: rgba(6, 182, 212, 0.1);
            border: 2px solid rgba(6, 182, 212, 0.3);
            color: var(--info);
            backdrop-filter: blur(10px);
        }

        .btn-outline-primary:hover {
            background: rgba(6, 182, 212, 0.2);
            border-color: rgba(6, 182, 212, 0.5);
            color: var(--info);
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 8px 25px rgba(6, 182, 212, 0.3);
        }

        .btn-outline-danger {
            background: rgba(239, 68, 68, 0.1);
            border: 2px solid rgba(239, 68, 68, 0.3);
            color: var(--danger);
            backdrop-filter: blur(10px);
        }

        .btn-outline-danger:hover {
            background: rgba(239, 68, 68, 0.2);
            border-color: rgba(239, 68, 68, 0.5);
            color: var(--danger);
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

        /* Response Message Styling */
        .response-message {
            border-radius: 1rem;
            padding: 1rem;
            margin: 0.5rem 0;
        }

        .response-approved {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: var(--success);
        }

        .response-rejected {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: var(--danger);
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
                    <h1 class="page-title">
                        <i class="fas fa-paper-plane"></i> My Submitted Requests
                    </h1>
                    <div class="d-flex align-items-center gap-3">
                        <span class="badge bg-light text-dark">Total: ${fn:length(requests)}</span>
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
                            <i class="fas fa-paper-plane"></i>
                            <h3>No Requests Submitted</h3>
                            <p>You haven't submitted any requests yet.</p>
                            <a href="/lands" class="btn btn-outline-primary mt-3">
                                <i class="fas fa-search"></i> Browse Available Lands
                            </a>
                    </div>
                </c:when>
                <c:otherwise>
                        <!-- Request Cards -->
                    <div class="row">
                        <c:forEach var="request" items="${requests}">
                                <div class="col-lg-6 col-xl-4 mb-4">
                                    <div class="request-card">
                                        <div class="card-header">
                                            <h5 class="mb-0">
                                                <i class="fas fa-map-marker-alt"></i> ${request.land.title}
                                            </h5>
                                    </div>
                                    <div class="card-body">
                                            <!-- Request Info -->
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <div>
                                                    <span class="request-type-badge">${request.requestType.displayName}</span>
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

                                            <!-- Land Details -->
                                        <div class="mb-3">
                                                <h6 class="text-primary mb-2">
                                                    <i class="fas fa-info-circle"></i> Land Details
                                                </h6>
                                                <p class="mb-1"><strong>Location:</strong> ${request.land.location}</p>
                                                <p class="mb-1"><strong>Price:</strong> LKR ${request.land.price}</p>
                                                <p class="mb-1"><strong>Seller:</strong> ${request.land.seller.name}</p>
                                        </div>

                                            <!-- Contact Information -->
                                            <div class="contact-info mb-3">
                                                <h6 class="mb-2">
                                                    <i class="fas fa-address-card"></i> Your Contact Information
                                                </h6>
                                                <c:if test="${not empty request.contactPhone}">
                                                    <div class="contact-item">
                                                        <i class="fas fa-phone text-primary"></i>
                                                        <span><strong>Phone:</strong> ${request.contactPhone}</span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty request.contactEmail}">
                                                    <div class="contact-item">
                                                        <i class="fas fa-envelope text-success"></i>
                                                        <span><strong>Email:</strong> ${request.contactEmail}</span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty request.preferredContactTime}">
                                                    <div class="contact-item">
                                                        <i class="fas fa-clock text-warning"></i> 
                                                        <span><strong>Preferred Time:</strong> ${request.preferredContactTime}</span>
                                                    </div>
                                                </c:if>
                                        </div>

                                            <!-- Your Message -->
                                            <div class="mb-3">
                                                <h6 class="mb-2">
                                                    <i class="fas fa-comment"></i> Your Message
                                                </h6>
                                                <div class="p-3" style="background: rgba(99, 102, 241, 0.1); border-radius: 1rem;">
                                                    <c:choose>
                                                        <c:when test="${not empty request.message}">
                                                            <p class="mb-0">${request.message}</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p class="mb-0 text-muted"><em>No message provided</em></p>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <!-- Response from Seller -->
                                            <c:if test="${request.status != 'PENDING'}">
                                                <div class="mb-3">
                                                    <h6 class="mb-2">
                                                        <i class="fas fa-reply"></i> Response from Seller
                                                    </h6>
                                                    <div class="response-message 
                                                        <c:choose>
                                                            <c:when test='${request.status == "APPROVED"}'>response-approved</c:when>
                                                            <c:otherwise>response-rejected</c:otherwise>
                                                        </c:choose>">
                                                        <c:choose>
                                                            <c:when test="${not empty request.responseMessage}">
                                                                <p class="mb-0">${request.responseMessage}</p>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <p class="mb-0"><em>No response message provided</em></p>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <small class="text-muted mt-2 d-block">
                                                        <i class="fas fa-calendar"></i> 
                                                        Processed on ${fn:substring(request.processedAt, 0, 10)} at ${fn:substring(request.processedAt, 11, 16)}
                                                    </small>
                                                </div>
                                            </c:if>

                                            <!-- Submission Date -->
                                            <div class="mb-3">
                                                <small class="text-muted">
                                                    <i class="fas fa-calendar"></i> 
                                                    Submitted on ${fn:substring(request.createdAt, 0, 10)} at ${fn:substring(request.createdAt, 11, 16)}
                                                </small>
                                            </div>

                                            <!-- Actions -->
                                            <div class="d-flex gap-2">
                                                <a href="/lands/details/${request.land.id}" class="btn btn-outline-primary flex-fill">
                                                    <i class="fas fa-eye"></i> View Land
                                        </a>
                                        
                                        <!-- Delete button - only for pending requests -->
                                        <c:if test="${request.status == 'PENDING'}">
                                                    <button type="button" class="btn btn-outline-danger flex-fill" 
                                                    data-bs-toggle="modal" 
                                                    data-bs-target="#deleteModal${request.id}">
                                                        <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </c:if>
                                            </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Delete Confirmation Modal -->
                            <div class="modal fade" id="deleteModal${request.id}" tabindex="-1" aria-labelledby="deleteModalLabel${request.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <form action="/requests/delete/${request.id}" method="post">
                                                <div class="modal-header" style="background: linear-gradient(135deg, var(--danger) 0%, #dc2626 100%); color: white;">
                                                <h5 class="modal-title" id="deleteModalLabel${request.id}">
                                                    <i class="fas fa-exclamation-triangle"></i> Delete Request
                                                </h5>
                                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                    <div class="alert alert-light border-0 mb-4" style="background: rgba(239, 68, 68, 0.1);">
                                                        <h6 class="mb-3">
                                                            <i class="fas fa-exclamation-triangle text-danger"></i> 
                                                            Are you sure you want to delete this request?
                                                        </h6>
                                                    </div>
                                                    
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="contact-info">
                                                                <h6 class="mb-3">
                                                                    <i class="fas fa-info-circle"></i> Request Details
                                                                </h6>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-map-marker-alt text-primary"></i>
                                                                    <span><strong>Land:</strong> ${request.land.title}</span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <i class="fas fa-tag text-info"></i>
                                                                    <span><strong>Type:</strong> ${request.requestType.displayName}</span>
                                                                </div>
                                                                <div class="contact-item">
                                                                    <c:choose>
                                                                        <c:when test="${request.status == 'PENDING'}">
                                                                            <i class="fas fa-clock text-warning"></i>
                                                                            <span><strong>Status:</strong> <span class="status-badge status-pending">${request.status.displayName}</span></span>
                                                                        </c:when>
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
                                                            <div class="alert alert-warning border-0" style="background: rgba(245, 158, 11, 0.1);">
                                                                <h6 class="mb-2">
                                                                    <i class="fas fa-info-circle text-warning"></i> Important Notice
                                                                </h6>
                                                                <p class="mb-0">This action cannot be undone. Once deleted, you will need to submit a new request if you want to contact the seller again.</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                                    <i class="fas fa-times"></i> Cancel
                                                </button>
                                                <button type="submit" class="btn btn-danger">
                                                    <i class="fas fa-trash"></i> Delete Request
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
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


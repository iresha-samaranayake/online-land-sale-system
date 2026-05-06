<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Payment Plans - Land Sales Portal</title>
    
    <!-- External Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --info-gradient: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);

            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #4facfe;
            --warning-color: #43e97b;
            --danger-color: #fa709a;
            --info-color: #a8edea;

            --text-primary: #2d3748;
            --text-secondary: #718096;
            --text-muted: #a0aec0;
            --bg-primary: #ffffff;
            --bg-secondary: #f7fafc;
            --bg-tertiary: #edf2f7;

            --border-radius: 16px;
            --border-radius-sm: 8px;
            --border-radius-lg: 24px;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            --shadow-xl: 0 20px 25px rgba(0, 0, 0, 0.1);

            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--bg-secondary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Modern Navigation */
        .navbar-modern {
            background: var(--primary-gradient);
            backdrop-filter: blur(20px);
            border: none;
            box-shadow: var(--shadow-lg);
            padding: 1rem 0;
        }

        .navbar-brand-modern {
            font-weight: 700;
            font-size: 1.5rem;
            color: white !important;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link-modern {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            border-radius: var(--border-radius-sm);
            transition: var(--transition);
            text-decoration: none;
        }

        .nav-link-modern:hover {
            color: white !important;
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-1px);
        }

        /* Page Header */
        .page-header-modern {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header-modern::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="rgba(255,255,255,0.1)"><polygon points="0,0 1000,0 1000,100 0,80"/></svg>');
            background-size: cover;
        }

        .page-title-modern {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-subtitle-modern {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        /* Stats Cards */
        .stats-card-modern {
            background: var(--bg-primary);
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            text-align: center;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .stats-card-modern::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .stats-card-modern:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
        }

        .stats-icon-modern {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stats-value-modern {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stats-label-modern {
            color: var(--text-secondary);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        /* Table Container */
        .table-container-modern {
            background: var(--bg-primary);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            overflow: hidden;
            margin-bottom: 2rem;
            width: 100%;
        }

        .table-modern {
            margin: 0;
            border-collapse: separate;
            border-spacing: 0;
            width: 100%;
            table-layout: auto;
        }

        .table-modern th:nth-child(1) { width: 4%; min-width: 50px; }   /* # */
        .table-modern th:nth-child(2) { width: 16%; min-width: 150px; }  /* Plan Details */
        .table-modern th:nth-child(3) { width: 16%; min-width: 150px; }  /* Land Information */
        .table-modern th:nth-child(4) { width: 20%; min-width: 180px; }  /* Financial Summary */
        .table-modern th:nth-child(5) { width: 14%; min-width: 120px; }  /* Payment Schedule */
        .table-modern th:nth-child(6) { width: 10%; min-width: 100px; }  /* Status */
        .table-modern th:nth-child(7) { width: 10%; min-width: 100px; }  /* Created Date */
        .table-modern th:nth-child(8) { width: 10%; min-width: 120px; }  /* Actions */

        .table-modern thead th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1.5rem 1.2rem;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: sticky;
            top: 0;
            z-index: 10;
            white-space: nowrap;
        }

        .table-modern tbody td {
            padding: 1.5rem 1.2rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--bg-tertiary);
            transition: var(--transition);
            word-wrap: break-word;
        }

        .table-modern tbody tr {
            transition: var(--transition);
        }

        .table-modern tbody tr:hover {
            background: var(--bg-secondary);
            transform: scale(1.01);
        }

        /* Status Badges */
        .badge-modern {
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius-lg);
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .badge-proposed-modern {
            background: var(--warning-gradient);
            color: white;
        }

        .badge-active-modern {
            background: var(--success-gradient);
            color: white;
        }

        .badge-accepted-modern {
            background: var(--info-gradient);
            color: var(--text-primary);
        }

        .badge-completed-modern {
            background: var(--primary-gradient);
            color: white;
        }

        .badge-rejected-modern {
            background: var(--danger-gradient);
            color: white;
        }

        .badge-defaulted-modern {
            background: var(--danger-gradient);
            color: white;
        }

        /* Amount Display */
        .amount-cell-modern {
            font-weight: 700;
            color: var(--text-primary);
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
        }

        /* Plan Details */
        .plan-name-modern {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .plan-terms-modern {
            color: var(--text-secondary);
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }

        .land-title-modern {
            font-weight: 600;
            color: var(--primary-color);
            text-decoration: none;
            transition: var(--transition);
        }

        .land-title-modern:hover {
            color: var(--secondary-color);
        }

        /* Empty State */
        .empty-state-modern {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }

        .empty-state-modern i {
            font-size: 4rem;
            margin-bottom: 1.5rem;
            opacity: 0.5;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .empty-state-modern h4 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text-primary);
        }

        .empty-state-modern p {
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        /* Action Buttons */
        .btn-modern {
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 0.75rem 1.5rem;
            font-weight: 600;
            font-size: 1rem;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .btn-modern::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-modern:hover::before {
            left: 100%;
        }

        .btn-primary-modern {
            background: var(--primary-gradient) !important;
            color: white !important;
            cursor: pointer !important;
            text-decoration: none !important;
            display: inline-block !important;
            border: none !important;
            outline: none !important;
            padding: 0.75rem 1.5rem !important;
            font-weight: 600 !important;
            font-size: 1rem !important;
            border-radius: var(--border-radius-sm) !important;
            transition: all 0.3s ease !important;
            position: relative !important;
            overflow: hidden !important;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1) !important;
        }

        .btn-primary-modern:hover {
            transform: translateY(-2px) !important;
            box-shadow: var(--shadow-lg) !important;
            color: white !important;
            text-decoration: none !important;
            background: var(--primary-gradient) !important;
        }

        .btn-primary-modern:focus {
            outline: none !important;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.3) !important;
        }

        .btn-primary-modern:active {
            transform: translateY(0) !important;
        }

        .btn-primary-modern::before {
            content: '' !important;
            position: absolute !important;
            top: 0 !important;
            left: -100% !important;
            width: 100% !important;
            height: 100% !important;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent) !important;
            transition: left 0.5s !important;
        }

        .btn-primary-modern:hover::before {
            left: 100% !important;
        }

        .btn-secondary-modern {
            background: var(--bg-tertiary);
            color: var(--text-primary);
            border: 2px solid var(--bg-tertiary);
        }

        .btn-secondary-modern:hover {
            background: var(--bg-primary);
            border-color: var(--primary-color);
            color: var(--primary-color);
            transform: translateY(-2px);
        }

        .btn-sm-modern {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-title-modern {
                font-size: 2rem;
            }

            .stats-card-modern {
                margin-bottom: 1rem;
            }

            .table-container-modern {
                overflow-x: auto;
            }

            .btn-modern {
                width: 100%;
                justify-content: center;
                margin-bottom: 0.5rem;
            }
        }

        /* Animation Classes */
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        .slide-up {
            animation: slideUp 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--bg-tertiary);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--secondary-color);
        }

        /* Alert Styles */
        .alert-modern {
            border: none;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: var(--shadow-sm);
        }

        .alert-info-modern {
            background: linear-gradient(135deg, #bee3f8 0%, #90cdf4 100%);
            color: #2a4365;
        }

    </style>
</head>
<body>
<!-- Modern Navigation -->
<nav class="navbar navbar-expand-lg navbar-modern">
    <div class="container">
        <a class="navbar-brand-modern" href="/">
            <i class="fas fa-landmark"></i>
            Land Sales Portal
        </a>
        <div class="navbar-nav ms-auto d-flex flex-row">
            <a class="nav-link-modern" href="/">
                <i class="fas fa-home"></i> Home
            </a>
            <a class="nav-link-modern" href="/dashboard">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a class="nav-link-modern" href="/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</nav>
<!-- Page Header -->
<div class="page-header-modern">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="page-title-modern">
                    <i class="fas fa-credit-card"></i>
                    My Payment Plans
                </h1>
                <p class="page-subtitle-modern">
                    Manage and monitor your payment plans with comprehensive financial insights
                </p>
            </div>
            <div class="col-lg-4 text-end">
                <button type="button" 
                        class="btn btn-primary-modern"
                        onclick="window.location.href='${pageContext.request.contextPath}/seller/${userId}/payment-plans/create'; console.log('Create Plan button clicked');">
                    <i class="fas fa-plus"></i>
                    Create New Plan
                </button>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid px-4">

            <c:set var="hasUserPayments" value="false" />
            <c:forEach var="payment" items="${payments}">
                <c:if test="${payment.land.seller.id == userId}">
                    <c:set var="hasUserPayments" value="true" />
                </c:if>
            </c:forEach>

    <!-- Empty State -->
    <c:if test="${not hasUserPayments}">
        <div class="empty-state-modern fade-in">
            <i class="fas fa-credit-card"></i>
            <h4>No Payment Plans Found</h4>
            <p>You haven't created any payment plans yet. Start by creating your first payment plan.</p>
            <button type="button" 
                    class="btn btn-primary-modern"
                    onclick="window.location.href='${pageContext.request.contextPath}/seller/${userId}/payment-plans/create'; console.log('Create First Plan button clicked');">
                <i class="fas fa-plus"></i>
                Create Your First Payment Plan
            </button>
        </div>
    </c:if>

    <!-- Payment Plans Table -->
    <c:if test="${hasUserPayments}">
        <div class="table-container-modern slide-up">
            <div class="table-responsive-lg">
                <table class="table-modern">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Plan Details</th>
                            <th>Land Information</th>
                            <th>Financial Summary</th>
                            <th>Payment Schedule</th>
                            <th>Status</th>
                            <th>Created Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="payment" items="${payments}" varStatus="status">
                            <c:if test="${payment.land.seller.id == userId}">
                                <tr>
                                    <td class="fw-bold text-muted">${status.index + 1}</td>

                                    <!-- Plan Details -->
                                    <td>
                                        <div class="plan-name-modern">${payment.planName}</div>
                                        <c:if test="${not empty payment.terms}">
                                            <div class="plan-terms-modern">
                                                <i class="fas fa-info-circle me-1"></i>
                                                ${payment.terms}
                                            </div>
                                        </c:if>
                                    </td>

                                    <!-- Land Information -->
                                    <td>
                                        <a href="#" class="land-title-modern">${payment.land.title}</a>
                                        <div class="text-muted small">
                                            <i class="fas fa-map-marker-alt me-1"></i>
                                            ${payment.land.location}
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-expand-arrows-alt me-1"></i>
                                            <fmt:formatNumber value="${payment.land.size}" pattern="0.00"/> sq.ft
                                        </div>
                                    </td>

                                    <!-- Financial Summary -->
                                    <td>
                                        <div class="mb-1">
                                            <small class="text-muted">Total Amount:</small>
                                            <div class="amount-cell-modern">
                                                <fmt:formatNumber value="${payment.totalAmount}" type="currency" currencyCode="LKR"/>
                                            </div>
                                        </div>
                                        <div class="mb-1">
                                            <small class="text-muted">Down Payment:</small>
                                            <div class="amount-cell-modern">
                                                <fmt:formatNumber value="${payment.downPayment}" type="currency" currencyCode="LKR"/>
                                            </div>
                                        </div>
                                        <div>
                                            <small class="text-muted">Per Installment:</small>
                                            <div class="amount-cell-modern">
                                                <fmt:formatNumber value="${payment.installmentAmount}" type="currency" currencyCode="LKR"/>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Payment Schedule -->
                                    <td>
                                        <div class="mb-2">
                                            <span class="badge-modern" style="background: var(--bg-tertiary); color: var(--text-primary);">
                                                ${payment.paymentFrequency} days
                                            </span>
                                        </div>
                                        <div class="small">
                                            <div class="text-muted">Installments: ${payment.installmentCount}</div>
                                            <c:if test="${not empty payment.interestRate}">
                                                <div class="text-muted">
                                                    Interest: <fmt:formatNumber value="${payment.interestRate}" pattern="0.00"/>%
                                                </div>
                                            </c:if>
                                        </div>
                                    </td>

                                    <!-- Status -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${payment.status == 'PROPOSED'}">
                                                <span class="badge-modern badge-proposed-modern">
                                                    <i class="fas fa-clock"></i> Proposed
                                                </span>
                                            </c:when>
                                            <c:when test="${payment.status == 'ACCEPTED'}">
                                                <span class="badge-modern badge-accepted-modern">
                                                    <i class="fas fa-check"></i> Accepted
                                                </span>
                                            </c:when>
                                            <c:when test="${payment.status == 'ACTIVE'}">
                                                <span class="badge-modern badge-active-modern">
                                                    <i class="fas fa-play"></i> Active
                                                </span>
                                            </c:when>
                                            <c:when test="${payment.status == 'COMPLETED'}">
                                                <span class="badge-modern badge-completed-modern">
                                                    <i class="fas fa-flag"></i> Completed
                                                </span>
                                            </c:when>
                                            <c:when test="${payment.status == 'REJECTED'}">
                                                <span class="badge-modern badge-rejected-modern">
                                                    <i class="fas fa-times"></i> Rejected
                                                </span>
                                            </c:when>
                                            <c:when test="${payment.status == 'DEFAULTED'}">
                                                <span class="badge-modern badge-defaulted-modern">
                                                    <i class="fas fa-exclamation-triangle"></i> Defaulted
                                                </span>
                                            </c:when>
                                        </c:choose>
                                    </td>

                                    <!-- Created Date -->
                                    <td>
                                        <div class="text-muted small">
                                            <i class="fas fa-calendar me-1"></i>
                                            ${payment.createdAt.year}-${payment.createdAt.monthValue < 10 ? '0' : ''}${payment.createdAt.monthValue}-${payment.createdAt.dayOfMonth < 10 ? '0' : ''}${payment.createdAt.dayOfMonth}
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-clock me-1"></i>
                                            ${payment.createdAt.hour < 10 ? '0' : ''}${payment.createdAt.hour}:${payment.createdAt.minute < 10 ? '0' : ''}${payment.createdAt.minute}
                                        </div>
                                    </td>

                                    <!-- Actions -->
                                    <td>
                                        <div class="d-flex flex-column gap-2">
                                            <button class="btn btn-primary-modern btn-sm-modern"
                                                    onclick="viewPaymentDetails(${payment.id})">
                                                <i class="fas fa-eye"></i> View
                                            </button>
                                            <button class="btn btn-secondary-modern btn-sm-modern"
                                                    onclick="deletePaymentPlanRest(${payment.id})">
                                                <i class="fas fa-trash"></i> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function viewPaymentDetails(paymentId) {
        window.location.href = '${pageContext.request.contextPath}/seller/${userId}/payment-plans/' + paymentId + '/edit';
    }

    function editPayment(paymentId) {
        window.location.href = '${pageContext.request.contextPath}/seller/${userId}/payment-plans/' + paymentId + '/edit';
    }

    async function deletePaymentPlanRest(paymentPlanId) {
        if (confirm('Are you sure you want to delete this payment plan?\n\nThis action cannot be undone.')) {
            try {
                const response = await fetch('${pageContext.request.contextPath}/' + paymentPlanId, {
                    method: 'DELETE',
                });

                if (response.ok) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Success!',
                        text: 'Payment plan has been deleted successfully.',
                        confirmButtonColor: '#667eea',
                        background: '#fff',
                        showClass: { popup: 'animate__animated animate__fadeInDown' },
                        hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                    }).then(() => {
                        window.location.reload();
                    });
                } else {
                    const error = await response.text();
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Error deleting payment plan: ' + error,
                        confirmButtonColor: '#667eea',
                        background: '#fff',
                        showClass: { popup: 'animate__animated animate__fadeInDown' },
                        hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                    });
                }
            } catch (error) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error deleting payment plan: ' + error.message,
                    confirmButtonColor: '#667eea',
                    background: '#fff',
                    showClass: { popup: 'animate__animated animate__fadeInDown' },
                    hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                });
            }
        }
    }

    // Initialize tooltips and button functionality
    document.addEventListener('DOMContentLoaded', function() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
        var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });

        // Ensure all create plan buttons are clickable
        const createButtons = document.querySelectorAll('a[href*="payment-plans/create"]');
        createButtons.forEach(function(button) {
            button.addEventListener('click', function(e) {
                console.log('Create Plan button clicked - navigating to:', this.href);
                // Let the default link behavior happen
            });
            
            // Add visual feedback
            button.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });
            
            button.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    });

    // Add smooth scrolling for better UX
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Payment Plans - Land Sales Portal</title>
    
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
        }

        .table-modern {
            margin: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .table-modern thead th {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1.5rem 1rem;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        .table-modern tbody td {
            padding: 1.5rem 1rem;
            vertical-align: middle;
            border-bottom: 1px solid var(--bg-tertiary);
            transition: var(--transition);
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

        .seller-name-modern {
            color: var(--text-secondary);
            font-size: 0.9rem;
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

        /* Action Buttons */
        .btn-modern {
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 0.5rem 1rem;
            font-weight: 600;
            font-size: 0.9rem;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
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
            background: var(--primary-gradient);
            color: white;
        }

        .btn-primary-modern:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            color: white;
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
            padding: 0.375rem 0.75rem;
            font-size: 0.8rem;
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
                        Staff Payment Plans
                    </h1>
                    <p class="page-subtitle-modern">
                        Comprehensive view of all payment plans for staff management and oversight
                    </p>
                </div>
                <div class="col-lg-4 text-end">
                    <div class="text-white-50 mb-1">Total Plans</div>
                    <div class="h2 mb-0">${payments.size()}</div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card-modern slide-up">
                    <i class="fas fa-clock stats-icon-modern"></i>
                    <div class="stats-value-modern">
                        <c:set var="proposedCount" value="0"/>
                        <c:forEach var="payment" items="${payments}">
                            <c:if test="${payment.status == 'PROPOSED'}">
                                <c:set var="proposedCount" value="${proposedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${proposedCount}
                    </div>
                    <div class="stats-label-modern">Pending Review</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card-modern slide-up">
                    <i class="fas fa-play-circle stats-icon-modern"></i>
                    <div class="stats-value-modern">
                        <c:set var="activeCount" value="0"/>
                        <c:forEach var="payment" items="${payments}">
                            <c:if test="${payment.status == 'ACTIVE'}">
                                <c:set var="activeCount" value="${activeCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${activeCount}
                    </div>
                    <div class="stats-label-modern">Active Plans</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card-modern slide-up">
                    <i class="fas fa-flag-checkered stats-icon-modern"></i>
                    <div class="stats-value-modern">
                        <c:set var="completedCount" value="0"/>
                        <c:forEach var="payment" items="${payments}">
                            <c:if test="${payment.status == 'COMPLETED'}">
                                <c:set var="completedCount" value="${completedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${completedCount}
                    </div>
                    <div class="stats-label-modern">Completed</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card-modern slide-up">
                    <i class="fas fa-chart-line stats-icon-modern"></i>
                    <div class="stats-value-modern">
                        <c:set var="totalValue" value="0"/>
                        <c:forEach var="payment" items="${payments}">
                            <c:set var="totalValue" value="${totalValue + payment.totalAmount}"/>
                        </c:forEach>
                        <fmt:formatNumber value="${totalValue / 1000000}" pattern="0.0"/>M
                    </div>
                    <div class="stats-label-modern">Total Value (LKR)</div>
                </div>
            </div>
        </div>

        <!-- Payment Plans Table -->
        <c:if test="${empty payments}">
            <div class="empty-state-modern fade-in">
                <i class="fas fa-credit-card"></i>
                <h4>No Payment Plans Found</h4>
                <p>There are currently no payment plans available in the system.</p>
            </div>
        </c:if>

        <c:if test="${not empty payments}">
            <div class="table-container-modern slide-up">
                <div class="table-responsive">
                    <table class="table-modern">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Plan Details</th>
                                <th>Land Information</th>
                                <th>Seller Information</th>
                                <th>Financial Details</th>
                                <th>Payment Schedule</th>
                                <th>Status</th>
                                <th>Created Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${payments}" var="plan" varStatus="status">
                                <tr>
                                    <td class="fw-bold text-muted">${status.index + 1}</td>

                                    <!-- Plan Details -->
                                    <td>
                                        <div class="plan-name-modern">${plan.planName}</div>
                                        <c:if test="${not empty plan.terms}">
                                            <div class="plan-terms-modern">
                                                <i class="fas fa-info-circle me-1"></i>
                                                ${plan.terms}
                                            </div>
                                        </c:if>
                                    </td>

                                    <!-- Land Information -->
                                    <td>
                                        <a href="#" class="land-title-modern">${plan.land.title}</a>
                                        <div class="text-muted small">
                                            <i class="fas fa-map-marker-alt me-1"></i>
                                            ${plan.land.location}
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-expand-arrows-alt me-1"></i>
                                            <fmt:formatNumber value="${plan.land.size}" pattern="0.00"/> sq.ft
                                        </div>
                                    </td>

                                    <!-- Seller Information -->
                                    <td>
                                        <div class="seller-name-modern">
                                            <i class="fas fa-user me-1"></i>
                                            ${plan.land.seller.name}
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-envelope me-1"></i>
                                            ${plan.land.seller.email}
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-phone me-1"></i>
                                            ${plan.land.seller.phone}
                                        </div>
                                    </td>

                                    <!-- Financial Details -->
                                    <td>
                                        <div class="mb-1">
                                            <small class="text-muted">Total Amount:</small>
                                            <div class="amount-cell-modern">
                                                <fmt:formatNumber value="${plan.totalAmount}" type="currency" currencyCode="LKR"/>
                                            </div>
                                        </div>
                                        <div class="mb-1">
                                            <small class="text-muted">Down Payment:</small>
                                            <div class="amount-cell-modern">
                                                <fmt:formatNumber value="${plan.downPayment}" type="currency" currencyCode="LKR"/>
                                            </div>
                                        </div>
                                        <div>
                                            <small class="text-muted">Installment:</small>
                                            <div class="amount-cell-modern">
                                                <fmt:formatNumber value="${plan.installmentAmount}" type="currency" currencyCode="LKR"/>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Payment Schedule -->
                                    <td>
                                        <div class="mb-2">
                                            <span class="badge-modern" style="background: var(--bg-tertiary); color: var(--text-primary);">
                                                ${plan.paymentFrequency} days
                                            </span>
                                        </div>
                                        <div class="small">
                                            <div class="text-muted">Installments: ${plan.installmentCount}</div>
                                            <c:if test="${not empty plan.interestRate}">
                                                <div class="text-muted">
                                                    Interest: <fmt:formatNumber value="${plan.interestRate}" pattern="0.00"/>%
                                                </div>
                                            </c:if>
                                        </div>
                                    </td>

                                    <!-- Status -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${plan.status == 'PROPOSED'}">
                                                <span class="badge-modern badge-proposed-modern">
                                                    <i class="fas fa-clock"></i> Proposed
                                                </span>
                                            </c:when>
                                            <c:when test="${plan.status == 'ACCEPTED'}">
                                                <span class="badge-modern badge-accepted-modern">
                                                    <i class="fas fa-check"></i> Accepted
                                                </span>
                                            </c:when>
                                            <c:when test="${plan.status == 'ACTIVE'}">
                                                <span class="badge-modern badge-active-modern">
                                                    <i class="fas fa-play"></i> Active
                                                </span>
                                            </c:when>
                                            <c:when test="${plan.status == 'COMPLETED'}">
                                                <span class="badge-modern badge-completed-modern">
                                                    <i class="fas fa-flag"></i> Completed
                                                </span>
                                            </c:when>
                                            <c:when test="${plan.status == 'REJECTED'}">
                                                <span class="badge-modern badge-rejected-modern">
                                                    <i class="fas fa-times"></i> Rejected
                                                </span>
                                            </c:when>
                                            <c:when test="${plan.status == 'DEFAULTED'}">
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
                                            ${plan.createdAt.year}-${plan.createdAt.monthValue < 10 ? '0' : ''}${plan.createdAt.monthValue}-${plan.createdAt.dayOfMonth < 10 ? '0' : ''}${plan.createdAt.dayOfMonth}
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-clock me-1"></i>
                                            ${plan.createdAt.hour < 10 ? '0' : ''}${plan.createdAt.hour}:${plan.createdAt.minute < 10 ? '0' : ''}${plan.createdAt.minute}
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize tooltips
        document.addEventListener('DOMContentLoaded', function() {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
            var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
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
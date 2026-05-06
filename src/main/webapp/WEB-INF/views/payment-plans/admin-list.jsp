<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Plans Management - Land Sales Portal</title>
    
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

        /* Filter Section */
        .filter-section-modern {
            background: var(--bg-primary);
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
        }

        .filter-title-modern {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
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

        /* Form Controls */
        .form-control-modern {
            border: 2px solid var(--bg-tertiary);
            border-radius: var(--border-radius-sm);
            padding: 0.75rem 1rem;
            font-size: 0.9rem;
            transition: var(--transition);
            background: var(--bg-primary);
            color: var(--text-primary);
        }

        .form-control-modern:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .form-select-modern {
            border: 2px solid var(--bg-tertiary);
            border-radius: var(--border-radius-sm);
            padding: 0.75rem 1rem;
            font-size: 0.9rem;
            transition: var(--transition);
            background: var(--bg-primary);
            color: var(--text-primary);
        }

        .form-select-modern:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
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

        .amount-cell-modern {
            font-weight: 700;
            color: var(--text-primary);
            font-family: 'Courier New', monospace;
        }

        .frequency-badge-modern {
            background: var(--bg-tertiary);
            color: var(--text-primary);
            padding: 0.25rem 0.5rem;
            border-radius: var(--border-radius-sm);
            font-size: 0.75rem;
            font-weight: 600;
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
                        Payment Plans Management
                    </h1>
                    <p class="page-subtitle-modern">
                        Comprehensive overview and management of all payment plans in the system
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
                    <div class="stats-label-modern">Proposed Plans</div>
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
                    <i class="fas fa-times-circle stats-icon-modern"></i>
                    <div class="stats-value-modern">
                        <c:set var="rejectedCount" value="0"/>
                        <c:forEach var="payment" items="${payments}">
                            <c:if test="${payment.status == 'REJECTED' || payment.status == 'DEFAULTED'}">
                                <c:set var="rejectedCount" value="${rejectedCount + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${rejectedCount}
                    </div>
                    <div class="stats-label-modern">Rejected/Defaulted</div>
                </div>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section-modern slide-up">
            <h3 class="filter-title-modern">
                <i class="fas fa-filter"></i>
                Advanced Filters
            </h3>
            <div class="row">
                <div class="col-md-3">
                    <label class="form-label-modern">Status Filter</label>
                    <select class="form-select-modern" id="statusFilter" onchange="filterTable()">
                        <option value="">All Statuses</option>
                        <option value="PROPOSED">Proposed</option>
                        <option value="ACCEPTED">Accepted</option>
                        <option value="ACTIVE">Active</option>
                        <option value="COMPLETED">Completed</option>
                        <option value="REJECTED">Rejected</option>
                        <option value="DEFAULTED">Defaulted</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label-modern">Search Plans</label>
                    <input type="text" class="form-control-modern" id="searchInput" placeholder="Search by plan name..." onkeyup="filterTable()">
                </div>
                <div class="col-md-3">
                    <label class="form-label-modern">Amount Range</label>
                    <select class="form-select-modern" id="amountFilter" onchange="filterTable()">
                        <option value="">All Amounts</option>
                        <option value="0-100000">LKR 0 - 100,000</option>
                        <option value="100000-500000">LKR 100,000 - 500,000</option>
                        <option value="500000-1000000">LKR 500,000 - 1,000,000</option>
                        <option value="1000000+">LKR 1,000,000+</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label-modern">Actions</label>
                    <div class="d-flex gap-2">
                        <button class="btn btn-primary-modern btn-sm-modern" onclick="exportToExcel()">
                            <i class="fas fa-download"></i> Export
                        </button>
                        <button class="btn btn-secondary-modern btn-sm-modern" onclick="resetFilters()">
                            <i class="fas fa-refresh"></i> Reset
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Plans Table -->
        <c:if test="${empty payments}">
            <div class="empty-state-modern fade-in">
                <i class="fas fa-credit-card"></i>
                <h4>No Payment Plans Found</h4>
                <p>There are currently no payment plans available in the system.</p>
                <button class="btn btn-primary-modern">
                    <i class="fas fa-plus"></i> Create New Plan
                </button>
            </div>
        </c:if>

        <c:if test="${not empty payments}">
            <div class="table-container-modern slide-up">
                <div class="table-responsive">
                    <table class="table-modern" id="paymentsTable">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Plan Details</th>
                                <th>Land Information</th>
                                <th>Financial Details</th>
                                <th>Schedule</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="payment" items="${payments}" varStatus="status">
                                <tr class="payment-row" data-status="${payment.status}" data-amount="${payment.totalAmount}" data-name="${payment.planName}">
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
                                        <div class="text-muted small mt-1">
                                            Created: ${payment.createdAt.year}-${payment.createdAt.monthValue < 10 ? '0' : ''}${payment.createdAt.monthValue}-${payment.createdAt.dayOfMonth < 10 ? '0' : ''}${payment.createdAt.dayOfMonth}
                                        </div>
                                    </td>

                                    <!-- Land Information -->
                                    <td>
                                        <a href="#" class="land-title-modern">${payment.land.title}</a>
                                        <div class="text-muted small">
                                            <i class="fas fa-map-marker-alt me-1"></i>
                                            ${payment.land.location}
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-user me-1"></i>
                                            ${payment.land.seller.name}
                                        </div>
                                    </td>

                                    <!-- Financial Details -->
                                    <td>
                                        <div class="mb-1">
                                            <small class="text-muted">Total:</small>
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
                                            <small class="text-muted">Installment:</small>
                                            <div class="amount-cell-modern">
                                                <fmt:formatNumber value="${payment.installmentAmount}" type="currency" currencyCode="LKR"/>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Schedule -->
                                    <td>
                                        <div class="mb-2">
                                            <span class="frequency-badge-modern">
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

                                    <!-- Actions -->
                                    <td>
                                        <div class="d-flex flex-column gap-2">
                                            <form action="/admin/payment-plans/${payment.id}/status" method="post" class="d-inline">
                                                <select name="status" class="form-select-modern form-select-sm" onchange="this.form.submit()">
                                                    <option value="PROPOSED" ${payment.status == 'PROPOSED' ? 'selected' : ''}>Proposed</option>
                                                    <option value="ACCEPTED" ${payment.status == 'ACCEPTED' ? 'selected' : ''}>Accepted</option>
                                                    <option value="ACTIVE" ${payment.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                                    <option value="COMPLETED" ${payment.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                                    <option value="REJECTED" ${payment.status == 'REJECTED' ? 'selected' : ''}>Rejected</option>
                                                </select>
                                            </form>
                                            <div class="d-flex gap-1">
                                                <button class="btn btn-primary-modern btn-sm-modern" onclick="viewDetails(${payment.id})">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-secondary-modern btn-sm-modern" onclick="editPlan(${payment.id})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                            </div>
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
        // Filter functionality
        function filterTable() {
            const statusFilter = document.getElementById('statusFilter').value.toLowerCase();
            const searchInput = document.getElementById('searchInput').value.toLowerCase();
            const amountFilter = document.getElementById('amountFilter').value;
            const rows = document.querySelectorAll('.payment-row');

            rows.forEach(row => {
                const status = row.getAttribute('data-status').toLowerCase();
                const name = row.getAttribute('data-name').toLowerCase();
                const amount = parseFloat(row.getAttribute('data-amount'));

                let showRow = true;

                // Status filter
                if (statusFilter && status !== statusFilter) {
                    showRow = false;
                }

                // Search filter
                if (searchInput && !name.includes(searchInput)) {
                    showRow = false;
                }

                // Amount filter
                if (amountFilter) {
                    switch (amountFilter) {
                        case '0-100000':
                            if (amount < 0 || amount > 100000) showRow = false;
                            break;
                        case '100000-500000':
                            if (amount < 100000 || amount > 500000) showRow = false;
                            break;
                        case '500000-1000000':
                            if (amount < 500000 || amount > 1000000) showRow = false;
                            break;
                        case '1000000+':
                            if (amount < 1000000) showRow = false;
                            break;
                    }
                }

                row.style.display = showRow ? '' : 'none';
            });
        }

        // Reset filters
        function resetFilters() {
            document.getElementById('statusFilter').value = '';
            document.getElementById('searchInput').value = '';
            document.getElementById('amountFilter').value = '';
            filterTable();
        }

        // Export to Excel
        function exportToExcel() {
            Swal.fire({
                icon: 'info',
                title: 'Export Feature',
                text: 'Excel export functionality would be implemented here.',
                confirmButtonColor: '#667eea',
                background: '#fff',
                showClass: { popup: 'animate__animated animate__fadeInDown' },
                hideClass: { popup: 'animate__animated animate__fadeOutUp' }
            });
        }

        // View details
        function viewDetails(paymentId) {
            Swal.fire({
                icon: 'info',
                title: 'View Details',
                text: 'Payment plan details view would open here.',
                confirmButtonColor: '#667eea',
                background: '#fff',
                showClass: { popup: 'animate__animated animate__fadeInDown' },
                hideClass: { popup: 'animate__animated animate__fadeOutUp' }
            });
        }

        // Edit plan
        function editPlan(paymentId) {
            Swal.fire({
                icon: 'info',
                title: 'Edit Plan',
                text: 'Payment plan edit form would open here.',
                confirmButtonColor: '#667eea',
                background: '#fff',
                showClass: { popup: 'animate__animated animate__fadeInDown' },
                hideClass: { popup: 'animate__animated animate__fadeOutUp' }
            });
        }

        // Auto-submit status forms when selection changes
        document.addEventListener('change', function(e) {
            if (e.target.name === 'status' && e.target.closest('form')) {
                e.target.closest('form').submit();
            }
        });

        // Initialize tooltips
        document.addEventListener('DOMContentLoaded', function() {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
            var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });
    </script>
</body>
</html>
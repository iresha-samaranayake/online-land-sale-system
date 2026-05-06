<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Payment Plan - Land Sales Portal</title>
    
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

        /* Modern Cards */
        .card-modern {
            background: var(--bg-primary);
            border: none;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-md);
            transition: var(--transition);
            overflow: hidden;
            position: relative;
        }

        .card-modern:hover {
            box-shadow: var(--shadow-xl);
            transform: translateY(-2px);
        }

        .card-modern::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .card-header-modern {
            background: transparent;
            border: none;
            padding: 2rem 2rem 1rem;
            position: relative;
        }

        .card-title-modern {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-primary);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .card-title-modern i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.75rem;
        }

        .card-body-modern {
            padding: 0 2rem 2rem;
        }

        /* Form Elements */
        .form-group-modern {
            margin-bottom: 1.5rem;
        }

        .form-label-modern {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: block;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control-modern {
            border: 2px solid var(--bg-tertiary);
            border-radius: var(--border-radius-sm);
            padding: 0.875rem 1rem;
            font-size: 1rem;
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
            padding: 0.875rem 1rem;
            font-size: 1rem;
            transition: var(--transition);
            background: var(--bg-primary);
            color: var(--text-primary);
        }

        .form-select-modern:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        /* Buttons */
        .btn-modern {
            border: none;
            border-radius: var(--border-radius-sm);
            padding: 0.875rem 2rem;
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

        /* Status Badges */
        .badge-modern {
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius-lg);
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-success-modern {
            background: var(--success-gradient);
            color: white;
        }

        .badge-warning-modern {
            background: var(--warning-gradient);
            color: white;
        }

        .badge-danger-modern {
            background: var(--danger-gradient);
            color: white;
        }

        .badge-info-modern {
            background: var(--info-gradient);
            color: var(--text-primary);
        }

        .badge-proposed-modern {
            background: var(--warning-gradient);
            color: white;
        }

        .badge-active-modern {
            background: var(--success-gradient);
            color: white;
        }

        .badge-completed-modern {
            background: var(--info-gradient);
            color: var(--text-primary);
        }

        .badge-rejected-modern {
            background: var(--danger-gradient);
            color: white;
        }

        /* Alerts */
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

        .alert-danger-modern {
            background: linear-gradient(135deg, #fed7d7 0%, #feb2b2 100%);
            color: #742a2a;
        }

        .alert-info-modern {
            background: linear-gradient(135deg, #bee3f8 0%, #90cdf4 100%);
            color: #2a4365;
        }

        .alert-warning-modern {
            background: linear-gradient(135deg, #fef5e7 0%, #fbd38d 100%);
            color: #744210;
        }

        /* Preview Cards */
        .preview-card-modern {
            background: var(--bg-primary);
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            border-left: 4px solid var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .preview-title-modern {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .preview-item-modern {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid var(--bg-tertiary);
        }

        .preview-item-modern:last-child {
            border-bottom: none;
        }

        .preview-label-modern {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .preview-value-modern {
            color: var(--text-primary);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .preview-highlight-modern {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.5rem;
            font-weight: 700;
        }

        /* Status Card */
        .status-card-modern {
            background: var(--bg-primary);
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .status-icon-modern {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .status-text-modern {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .status-description-modern {
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .page-title-modern {
                font-size: 2rem;
            }
            
            .card-header-modern,
            .card-body-modern {
                padding: 1.5rem;
            }
            
            .btn-modern {
                width: 100%;
                justify-content: center;
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
                        <i class="fas fa-edit"></i>
                        Edit Payment Plan
                    </h1>
                    <p class="page-subtitle-modern">
                        Update your payment plan details with enhanced financial management tools
                    </p>
                </div>
                <div class="col-lg-4 text-end">
                    <a href="${pageContext.request.contextPath}/seller/${userId}/payment-plans"
                       class="btn btn-secondary-modern">
                        <i class="fas fa-arrow-left"></i>
                        Back to Plans
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Error Alert -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger-modern fade-in">
                <i class="fas fa-exclamation-triangle fa-2x"></i>
                <div>
                    <h6 class="mb-1 fw-bold">Error Occurred</h6>
                    <p class="mb-0">${error}</p>
                </div>
            </div>
        </c:if>

        <div class="row">
            <!-- Left Column - Land Details & Status -->
            <div class="col-lg-5 mb-4">
                <!-- Land Details Card -->
                <div class="card-modern slide-up">
                    <div class="card-header-modern">
                        <h3 class="card-title-modern">
                            <i class="fas fa-map-marked-alt"></i>
                            Land Property Details
                        </h3>
                    </div>
                    <div class="card-body-modern">
                        <div class="preview-card-modern">
                            <h4 class="preview-title-modern">
                                <i class="fas fa-info-circle"></i>
                                Property Information
                            </h4>
                            <div class="preview-item-modern">
                                <span class="preview-label-modern">Title:</span>
                                <span class="preview-value-modern">${paymentPlan.land.title}</span>
                            </div>
                            <div class="preview-item-modern">
                                <span class="preview-label-modern">Location:</span>
                                <span class="preview-value-modern">${paymentPlan.land.location}</span>
                            </div>
                            <div class="preview-item-modern">
                                <span class="preview-label-modern">Status:</span>
                                <span class="badge-modern badge-success-modern">${paymentPlan.land.status}</span>
                            </div>
                            <div class="preview-item-modern">
                                <span class="preview-label-modern">Price:</span>
                                <span class="preview-value-modern">
                                    <fmt:formatNumber value="${paymentPlan.land.price}" type="currency" currencyCode="LKR"/>
                                </span>
                            </div>
                            <div class="preview-item-modern">
                                <span class="preview-label-modern">Size:</span>
                                <span class="preview-value-modern">
                                    <fmt:formatNumber value="${paymentPlan.land.size}" pattern="0.00"/> sq.ft
                                </span>
                            </div>
                        </div>

                        <div class="alert alert-info-modern">
                            <i class="fas fa-info-circle fa-lg"></i>
                            <div>
                                <strong>Note:</strong> Land property cannot be changed for existing payment plans.
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Current Status Card -->
                <div class="status-card-modern slide-up">
                    <div class="status-icon-modern">
                        <c:choose>
                            <c:when test="${paymentPlan.status == 'PROPOSED'}">
                                <i class="fas fa-clock" style="color: var(--warning-color);"></i>
                            </c:when>
                            <c:when test="${paymentPlan.status == 'ACCEPTED'}">
                                <i class="fas fa-check-circle" style="color: var(--success-color);"></i>
                            </c:when>
                            <c:when test="${paymentPlan.status == 'ACTIVE'}">
                                <i class="fas fa-play-circle" style="color: var(--primary-color);"></i>
                            </c:when>
                            <c:when test="${paymentPlan.status == 'COMPLETED'}">
                                <i class="fas fa-flag-checkered" style="color: var(--info-color);"></i>
                            </c:when>
                            <c:when test="${paymentPlan.status == 'REJECTED' || paymentPlan.status == 'DEFAULTED'}">
                                <i class="fas fa-times-circle" style="color: var(--danger-color);"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-question-circle" style="color: var(--text-muted);"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="status-text-modern">Current Status</div>
                    <c:choose>
                        <c:when test="${paymentPlan.status == 'PROPOSED'}">
                            <span class="badge-modern badge-proposed-modern">${paymentPlan.status}</span>
                        </c:when>
                        <c:when test="${paymentPlan.status == 'ACCEPTED'}">
                            <span class="badge-modern badge-success-modern">${paymentPlan.status}</span>
                        </c:when>
                        <c:when test="${paymentPlan.status == 'ACTIVE'}">
                            <span class="badge-modern badge-active-modern">${paymentPlan.status}</span>
                        </c:when>
                        <c:when test="${paymentPlan.status == 'COMPLETED'}">
                            <span class="badge-modern badge-completed-modern">${paymentPlan.status}</span>
                        </c:when>
                        <c:when test="${paymentPlan.status == 'REJECTED' || paymentPlan.status == 'DEFAULTED'}">
                            <span class="badge-modern badge-rejected-modern">${paymentPlan.status}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge-modern badge-info-modern">${paymentPlan.status}</span>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${paymentPlan.status != 'PROPOSED'}">
                        <div class="status-description-modern mt-2">
                            Changes may require admin re-approval
                        </div>
                    </c:if>
                </div>

                <!-- Payment Preview Card -->
                <div class="preview-card-modern slide-up">
                    <h4 class="preview-title-modern">
                        <i class="fas fa-calculator"></i>
                        Payment Breakdown
                    </h4>
                    <div class="text-center mb-3">
                        <div class="preview-highlight-modern" id="previewInstallmentAmount">
                            <fmt:formatNumber value="${paymentPlan.installmentAmount}" type="currency" currencyCode="LKR"/>
                        </div>
                        <div class="text-muted">Per Installment</div>
                    </div>
                    
                    <div class="preview-item-modern">
                        <span class="preview-label-modern">Land Price:</span>
                        <span class="preview-value-modern" id="previewLandPrice">
                            <fmt:formatNumber value="${paymentPlan.land.price}" type="currency" currencyCode="LKR"/>
                        </span>
                    </div>
                    <div class="preview-item-modern">
                        <span class="preview-label-modern">Total Amount:</span>
                        <span class="preview-value-modern" id="previewTotalAmount">
                            <fmt:formatNumber value="${paymentPlan.totalAmount}" type="currency" currencyCode="LKR"/>
                        </span>
                    </div>
                    <div class="preview-item-modern">
                        <span class="preview-label-modern">Down Payment:</span>
                        <span class="preview-value-modern" id="previewDownPayment">
                            <fmt:formatNumber value="${paymentPlan.downPayment}" type="currency" currencyCode="LKR"/>
                        </span>
                    </div>
                    <div class="preview-item-modern">
                        <span class="preview-label-modern">Remaining Amount:</span>
                        <span class="preview-value-modern" id="previewRemainingAmount">
                            <fmt:formatNumber value="${paymentPlan.totalAmount - paymentPlan.downPayment}" type="currency" currencyCode="LKR"/>
                        </span>
                    </div>
                    <div class="preview-item-modern">
                        <span class="preview-label-modern">Installments:</span>
                        <span class="preview-value-modern" id="previewInstallmentCount">${paymentPlan.installmentCount}</span>
                    </div>
                </div>
            </div>

            <!-- Right Column - Payment Plan Form -->
            <div class="col-lg-7">
                <div class="card-modern slide-up">
                    <div class="card-header-modern">
                        <h3 class="card-title-modern">
                            <i class="fas fa-credit-card"></i>
                            Edit Payment Plan
                        </h3>
                    </div>
                    <div class="card-body-modern">
                        <form:form method="POST"
                                   action="${pageContext.request.contextPath}/seller/${userId}/payment-plans/${paymentPlanId}/edit"
                                   modelAttribute="paymentPlan"
                                   onsubmit="return validateForm()">

                            <input type="hidden" name="landId" value="${paymentPlan.land.id}" />

                            <!-- Basic Information Section -->
                            <div class="mb-4">
                                <h5 class="mb-3" style="color: var(--text-primary); font-weight: 600;">
                                    <i class="fas fa-info-circle me-2"></i>Basic Information
                                </h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group-modern">
                                            <label for="planName" class="form-label-modern">Plan Name *</label>
                                            <form:input path="planName" class="form-control-modern"
                                                        placeholder="e.g., Premium Plan, Standard Plan" required="true"/>
                                            <form:errors path="planName" class="text-danger small"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group-modern">
                                            <label for="paymentFrequency" class="form-label-modern">Payment Frequency *</label>
                                            <form:select path="paymentFrequency" class="form-select-modern" required="true">
                                                <option value="">Select Frequency</option>
                                                <c:forEach var="freq" items="${paymentFrequencies}">
                                                    <option value="${freq.key}">${freq.value}</option>
                                                </c:forEach>
                                            </form:select>
                                            <form:errors path="paymentFrequency" class="text-danger small"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Financial Details Section -->
                            <div class="mb-4">
                                <h5 class="mb-3" style="color: var(--text-primary); font-weight: 600;">
                                    <i class="fas fa-dollar-sign me-2"></i>Financial Details
                                </h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group-modern">
                                            <label for="totalAmount" class="form-label-modern">Total Amount (LKR) *</label>
                                            <form:input path="totalAmount" type="number" step="0.01"
                                                        class="form-control-modern" placeholder="0.00"
                                                        onchange="calculateInstallments()" required="true"/>
                                            <form:errors path="totalAmount" class="text-danger small"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group-modern">
                                            <label for="downPayment" class="form-label-modern">Down Payment (LKR) *</label>
                                            <form:input path="downPayment" type="number" step="0.01"
                                                        class="form-control-modern" placeholder="0.00"
                                                        onchange="calculateInstallments()" required="true"/>
                                            <form:errors path="downPayment" class="text-danger small"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group-modern">
                                            <label for="installmentCount" class="form-label-modern">Number of Installments *</label>
                                            <form:input path="installmentCount" type="number"
                                                        class="form-control-modern" placeholder="e.g., 12"
                                                        onchange="calculateInstallments()" required="true"/>
                                            <form:errors path="installmentCount" class="text-danger small"/>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group-modern">
                                            <label for="installmentAmount" class="form-label-modern">Installment Amount (LKR)</label>
                                            <form:input path="installmentAmount" type="number" step="0.01"
                                                        class="form-control-modern" placeholder="Auto-calculated"
                                                        readonly="true"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Additional Information Section -->
                            <div class="mb-4">
                                <h5 class="mb-3" style="color: var(--text-primary); font-weight: 600;">
                                    <i class="fas fa-cog me-2"></i>Additional Information
                                </h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group-modern">
                                            <label for="interestRate" class="form-label-modern">Interest Rate (%)</label>
                                            <form:input path="interestRate" type="number" step="0.01"
                                                        class="form-control-modern" placeholder="0.00"
                                                        min="0" max="100"/>
                                            <form:errors path="interestRate" class="text-danger small"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group-modern">
                                    <label for="terms" class="form-label-modern">Terms & Conditions</label>
                                    <form:textarea path="terms" class="form-control-modern" rows="4"
                                                   placeholder="Enter specific terms and conditions for this payment plan..."/>
                                    <form:errors path="terms" class="text-danger small"/>
                                </div>
                            </div>

                            <!-- Warning Alert -->
                            <div class="alert alert-warning-modern">
                                <i class="fas fa-exclamation-triangle fa-lg"></i>
                                <div>
                                    <strong>Important:</strong>
                                    <c:choose>
                                        <c:when test="${paymentPlan.status != 'PROPOSED'}">
                                            Changes to amount details will reset the status to "PROPOSED" and require admin re-approval.
                                        </c:when>
                                        <c:otherwise>
                                            Payment plan is currently pending admin approval.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="d-flex gap-3 justify-content-end">
                                <a href="${pageContext.request.contextPath}/seller/${userId}/payment-plans"
                                   class="btn btn-secondary-modern">
                                    <i class="fas fa-times"></i>
                                    Cancel
                                </a>
                                <button type="submit" class="btn btn-primary-modern">
                                    <i class="fas fa-save"></i>
                                    Update Payment Plan
                                </button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let selectedLandPrice = ${paymentPlan.land.price};
        let selectedLandId = ${paymentPlan.land.id};

        function calculateInstallments() {
            const totalAmount = parseFloat(document.getElementById('totalAmount').value) || 0;
            const downPayment = parseFloat(document.getElementById('downPayment').value) || 0;
            const installmentCount = parseInt(document.getElementById('installmentCount').value) || 0;

            // Update preview with current values
            document.getElementById('previewTotalAmount').textContent = formatCurrency(totalAmount);
            document.getElementById('previewDownPayment').textContent = formatCurrency(downPayment);
            document.getElementById('previewInstallmentCount').textContent = installmentCount;

            if (totalAmount > 0 && downPayment > 0 && installmentCount > 0) {
                const remainingAmount = totalAmount - downPayment;
                const installmentAmount = remainingAmount / installmentCount;

                document.getElementById('installmentAmount').value = installmentAmount.toFixed(2);

                // Update preview
                document.getElementById('previewRemainingAmount').textContent = formatCurrency(remainingAmount);
                document.getElementById('previewInstallmentAmount').textContent = formatCurrency(installmentAmount);
            } else {
                document.getElementById('installmentAmount').value = '';
                document.getElementById('previewRemainingAmount').textContent = formatCurrency(0);
                document.getElementById('previewInstallmentAmount').textContent = formatCurrency(0);
            }
        }

        function formatCurrency(amount) {
            return 'LKR ' + parseFloat(amount).toLocaleString('en-US', {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2
            });
        }

        function validateForm() {
            const totalAmount = parseFloat(document.getElementById('totalAmount').value) || 0;
            if (totalAmount <= 0) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Total Amount',
                    text: 'Total amount must be greater than 0.',
                    confirmButtonColor: '#667eea',
                    background: '#fff',
                    showClass: { popup: 'animate__animated animate__fadeInDown' },
                    hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                });
                document.getElementById('totalAmount').focus();
                return false;
            }

            if (totalAmount > selectedLandPrice) {
                Swal.fire({
                    icon: 'error',
                    title: 'Amount Exceeds Land Price',
                    text: 'Total amount cannot exceed the land price of ' + formatCurrency(selectedLandPrice),
                    confirmButtonColor: '#667eea',
                    background: '#fff',
                    showClass: { popup: 'animate__animated animate__fadeInDown' },
                    hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                });
                document.getElementById('totalAmount').focus();
                return false;
            }

            const downPayment = parseFloat(document.getElementById('downPayment').value) || 0;
            if (downPayment <= 0) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Down Payment',
                    text: 'Down payment must be greater than 0.',
                    confirmButtonColor: '#667eea',
                    background: '#fff',
                    showClass: { popup: 'animate__animated animate__fadeInDown' },
                    hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                });
                document.getElementById('downPayment').focus();
                return false;
            }

            if (downPayment >= totalAmount) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Down Payment',
                    text: 'Down payment must be less than total amount.',
                    confirmButtonColor: '#667eea',
                    background: '#fff',
                    showClass: { popup: 'animate__animated animate__fadeInDown' },
                    hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                });
                document.getElementById('downPayment').focus();
                return false;
            }

            const installmentCount = parseInt(document.getElementById('installmentCount').value) || 0;
            if (installmentCount <= 0) {
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Installment Count',
                    text: 'Number of installments must be greater than 0.',
                    confirmButtonColor: '#667eea',
                    background: '#fff',
                    showClass: { popup: 'animate__animated animate__fadeInDown' },
                    hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                });
                document.getElementById('installmentCount').focus();
                return false;
            }

            const paymentFrequency = document.getElementById('paymentFrequency').value;
            if (!paymentFrequency) {
                Swal.fire({
                    icon: 'error',
                    title: 'Payment Frequency Required',
                    text: 'Please select a payment frequency.',
                    confirmButtonColor: '#667eea',
                    background: '#fff',
                    showClass: { popup: 'animate__animated animate__fadeInDown' },
                    hideClass: { popup: 'animate__animated animate__fadeOutUp' }
                });
                document.getElementById('paymentFrequency').focus();
                return false;
            }

            return true;
        }

        // Initialize form validation and event listeners
        document.addEventListener('DOMContentLoaded', function() {
            // Add event listeners to amount fields for real-time calculation
            document.getElementById('totalAmount').addEventListener('input', calculateInstallments);
            document.getElementById('downPayment').addEventListener('input', calculateInstallments);
            document.getElementById('installmentCount').addEventListener('input', calculateInstallments);

            // Form submission validation
            const form = document.querySelector('form');
            form.addEventListener('submit', function(event) {
                if (!validateForm()) {
                    event.preventDefault();
                }
            });
        });
    </script>
</body>
</html>
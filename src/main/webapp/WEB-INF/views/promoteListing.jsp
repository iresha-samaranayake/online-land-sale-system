<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Promote Listing - Land Sales Portal</title>
    
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
            --gold-gradient: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
            --silver-gradient: linear-gradient(135deg, #c0c0c0 0%, #e8e8e8 100%);
            --bronze-gradient: linear-gradient(135deg, #cd7f32 0%, #daa520 100%);

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

        /* Table Styling */
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
            width: 100%;
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

        .badge-promoted-modern {
            background: var(--success-gradient);
            color: white;
        }

        .badge-not-promoted-modern {
            background: var(--bg-tertiary);
            color: var(--text-primary);
        }

        /* Banner Type Cards */
        .banner-card-modern {
            background: var(--bg-primary);
            border: 2px solid var(--bg-tertiary);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            transition: var(--transition);
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .banner-card-modern:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .banner-card-modern.selected {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .banner-gold-modern {
            border-color: #ffd700;
        }

        .banner-gold-modern.selected {
            border-color: #ffd700;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
        }

        .banner-silver-modern {
            border-color: #c0c0c0;
        }

        .banner-silver-modern.selected {
            border-color: #c0c0c0;
            box-shadow: 0 0 0 3px rgba(192, 192, 192, 0.2);
        }

        .banner-bronze-modern {
            border-color: #cd7f32;
        }

        .banner-bronze-modern.selected {
            border-color: #cd7f32;
            box-shadow: 0 0 0 3px rgba(205, 127, 50, 0.2);
        }

        .banner-icon-modern {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .banner-gold-modern .banner-icon-modern {
            background: var(--gold-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .banner-silver-modern .banner-icon-modern {
            background: var(--silver-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .banner-bronze-modern .banner-icon-modern {
            background: var(--bronze-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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

        .btn-warning-modern {
            background: var(--warning-gradient);
            color: white;
        }

        .btn-danger-modern {
            background: var(--danger-gradient);
            color: white;
        }

        .btn-sm-modern {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        /* Cost Display */
        .cost-display-modern {
            background: var(--primary-gradient);
            color: white;
            padding: 1.5rem;
            border-radius: var(--border-radius);
            text-align: center;
            margin: 1rem 0;
        }

        .cost-amount-modern {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .cost-label-modern {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* Preview Card */
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

        .alert-success-modern {
            background: linear-gradient(135deg, #c6f6d5 0%, #9ae6b4 100%);
            color: #22543d;
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
            <a class="nav-link-modern" href="/lands">
                <i class="fas fa-search"></i> Browse Lands
            </a>
            <a class="nav-link-modern" href="/profile">
                <i class="fas fa-user"></i> Profile
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
                    <i class="fas fa-star"></i>
                    Promote Your Land Listing
                </h1>
                <p class="page-subtitle-modern">
                    Boost your land listing visibility with premium promotion packages
                </p>
            </div>
        </div>
    </div>
                </div>
<div class="container">
    <!-- Error/Success Messages -->
                    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger-modern fade-in">
            <i class="fas fa-exclamation-triangle fa-2x"></i>
            <div>
                <h6 class="mb-1 fw-bold">Error Occurred</h6>
                <p class="mb-0">${errorMessage}</p>
            </div>
        </div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
        <div class="alert alert-success-modern fade-in">
            <i class="fas fa-check-circle fa-2x"></i>
            <div>
                <h6 class="mb-1 fw-bold">Success!</h6>
                <p class="mb-0">${successMessage}</p>
            </div>
        </div>
                    </c:if>

    <!-- Step 1: Select Listing -->
    <div class="card-modern slide-up">
        <div class="card-header-modern">
            <h3 class="card-title-modern">
                <i class="fas fa-list"></i>
                Step 1: Select a Listing to Promote
            </h3>
        </div>
        <div class="card-body-modern">
            <div class="table-container-modern">
                <div class="table-responsive">
                    <table class="table-modern">
                        <thead>
                        <tr>
                            <th>Title</th>
                            <th>Location</th>
                            <th>Price</th>
                            <th>Status</th>
                                <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="listing" items="${approvedListings}">
                            <tr>
                                    <td>
                                        <div class="fw-bold">${listing.title}</div>
                                    </td>
                                    <td>
                                        <div class="text-muted">
                                            <i class="fas fa-map-marker-alt me-1"></i>
                                            ${listing.location}
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-success">
                                            <fmt:formatNumber value="${listing.price}" type="currency" currencyCode="LKR"/>
                                        </div>
                                    </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${listing.isPromoted}">
                                                <span class="badge-modern badge-promoted-modern">
                                                    <i class="fas fa-star"></i> Promoted
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                                <span class="badge-modern badge-not-promoted-modern">
                                                    <i class="fas fa-circle"></i> Not Promoted
                                                </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                        <div class="d-flex gap-2">
                                    <c:if test="${!listing.isPromoted}">
                                                <a href="/promote/listing/select/${listing.id}" 
                                                   class="btn btn-primary-modern btn-sm-modern">
                                                    <i class="fas fa-check"></i> Select
                                                </a>
                                    </c:if>
                                    <c:if test="${listing.isPromoted}">
                                                <a href="/promote/listing/edit/${listing.id}" 
                                                   class="btn btn-warning-modern btn-sm-modern">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <a href="/promote/listing/delete/${listing.id}" 
                                                   class="btn btn-danger-modern btn-sm-modern"
                                                   onclick="return confirm('Are you sure you want to remove this promotion?')">
                                                    <i class="fas fa-trash"></i> Remove
                                                </a>
                                    </c:if>
                                        </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- Step 2: Promotion Options (shown if a listing is selected) -->
                    <c:if test="${selectedListing != null}">
        <div class="card-modern slide-up">
            <div class="card-header-modern">
                <h3 class="card-title-modern">
                    <i class="fas fa-cog"></i>
                    Step 2: Choose Promotion Options for ${selectedListing.title}
                </h3>
            </div>
            <div class="card-body-modern">
                        <form action="/promote/listing/save" method="post">
                            <input type="hidden" name="listingId" value="${selectedListing.id}">
                    
                    <!-- Banner Type Selection -->
                    <div class="mb-4">
                        <h5 class="mb-3" style="color: var(--text-primary); font-weight: 600;">
                            <i class="fas fa-star me-2"></i>Banner Type
                        </h5>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="banner-card-modern banner-gold-modern ${promotionDTO.bannerType == 'GOLD' ? 'selected' : ''}" 
                                     onclick="selectBannerType('GOLD')">
                                    <div class="banner-icon-modern">
                                        <i class="fas fa-crown"></i>
                                    </div>
                                    <h6 class="fw-bold">Gold Banner</h6>
                                    <p class="text-muted small">Premium Visibility</p>
                                    <div class="fw-bold text-success">LKR 5,000/week</div>
                                    <input type="radio" name="bannerType" value="GOLD" id="goldBanner" 
                                           ${promotionDTO.bannerType == 'GOLD' ? 'checked' : ''} style="display: none;">
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="banner-card-modern banner-silver-modern ${promotionDTO.bannerType == 'SILVER' ? 'selected' : ''}" 
                                     onclick="selectBannerType('SILVER')">
                                    <div class="banner-icon-modern">
                                        <i class="fas fa-medal"></i>
                                    </div>
                                    <h6 class="fw-bold">Silver Banner</h6>
                                    <p class="text-muted small">Standard Visibility</p>
                                    <div class="fw-bold text-success">LKR 3,000/week</div>
                                    <input type="radio" name="bannerType" value="SILVER" id="silverBanner" 
                                           ${promotionDTO.bannerType == 'SILVER' ? 'checked' : ''} style="display: none;">
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="banner-card-modern banner-bronze-modern ${promotionDTO.bannerType == null ? 'selected' : promotionDTO.bannerType == 'BRONZE' ? 'selected' : ''}" 
                                     onclick="selectBannerType('BRONZE')">
                                    <div class="banner-icon-modern">
                                        <i class="fas fa-award"></i>
                                    </div>
                                    <h6 class="fw-bold">Bronze Banner</h6>
                                    <p class="text-muted small">Basic Visibility</p>
                                    <div class="fw-bold text-success">LKR 1,000/week</div>
                                    <input type="radio" name="bannerType" value="BRONZE" id="bronzeBanner" 
                                           ${promotionDTO.bannerType == null ? 'checked' : promotionDTO.bannerType == 'BRONZE' ? 'checked' : ''} style="display: none;">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Form Fields -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group-modern">
                                <label for="discount" class="form-label-modern">Discount Percentage</label>
                                <input type="number" class="form-control-modern" name="discount" 
                                       placeholder="Enter discount percentage (0-50)" min="0" max="50" 
                                       value="${promotionDTO.discount}" required onchange="updateCost()">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group-modern">
                                <label for="duration" class="form-label-modern">Promotion Duration</label>
                                <select class="form-select-modern" name="duration" required onchange="updateCost()">
                                    <option value="7" ${promotionDTO.duration == 7 ? 'selected' : ''}>7 Days</option>
                                    <option value="14" ${promotionDTO.duration == 14 ? 'selected' : ''}>14 Days</option>
                                    <option value="30" ${promotionDTO.duration == 30 ? 'selected' : ''}>30 Days</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Cost Display -->
                    <div class="cost-display-modern">
                        <div class="cost-amount-modern" id="costEstimate">LKR 0</div>
                        <div class="cost-label-modern">Estimated Total Cost</div>
                            </div>

                    <!-- Action Buttons -->
                    <div class="d-flex gap-3 justify-content-end">
                        <a href="/promote/listing" class="btn btn-secondary-modern">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary-modern">
                            <i class="fas fa-check"></i> Confirm Promotion
                        </button>
                            </div>
                        </form>
                                </div>
                            </div>
        <!-- Promotion Preview -->
        <div class="preview-card-modern">
            <h4 class="preview-title-modern">
                <i class="fas fa-eye"></i>
                Promotion Preview
            </h4>
            <div class="card-modern">
                <div class="card-body-modern">
                    <h6 class="fw-bold">${selectedListing.title}</h6>
                    <p class="text-muted mb-2">
                        <i class="fas fa-map-marker-alt me-1"></i>
                        ${selectedListing.location}
                    </p>
                    <p class="text-success fw-bold mb-2">
                        <fmt:formatNumber value="${selectedListing.price}" type="currency" currencyCode="LKR"/>
                    </p>
                    <span class="badge-modern badge-promoted-modern">
                        <i class="fas fa-star"></i> Featured
                    </span>
                </div>
            </div>
        </div>
    </c:if>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Banner type selection
    function selectBannerType(type) {
        // Remove selected class from all banner cards
        document.querySelectorAll('.banner-card-modern').forEach(card => {
            card.classList.remove('selected');
        });
        
        // Add selected class to clicked card
        event.currentTarget.classList.add('selected');
        
        // Check the corresponding radio button
        document.getElementById(type.toLowerCase() + 'Banner').checked = true;
        
        // Update cost
        updateCost();
    }

    // Cost estimation logic
    function updateCost() {
        var bannerTypeElement = document.querySelector('input[name="bannerType"]:checked');
        var discountElement = document.querySelector('input[name="discount"]');
        var durationElement = document.querySelector('select[name="duration"]');
        var costEstimateElement = document.getElementById('costEstimate');

        // Check if all elements exist
        if (!bannerTypeElement || !discountElement || !durationElement || !costEstimateElement) {
            if (costEstimateElement) {
            costEstimateElement.textContent = 'LKR 0';
            }
            return;
        }

        var bannerType = bannerTypeElement.value;
        var discount = parseFloat(discountElement.value) || 0; // Default to 0 if invalid or empty
        var duration = parseInt(durationElement.value) || 7;

        // Calculate base cost
        var baseCost = 0;
        if (bannerType === 'GOLD') {
            baseCost = 5000;
        } else if (bannerType === 'SILVER') {
            baseCost = 3000;
        } else if (bannerType === 'BRONZE') {
            baseCost = 1000;
        }

        // Validate discount
        if (discount < 0 || discount > 50) {
            costEstimateElement.textContent = 'LKR ' + Math.round(baseCost * (duration / 7)); // Show cost without discount
            return;
        }

        // Calculate total cost
        var totalCost = baseCost * (duration / 7) * (1 - discount / 100);

        // Update display with proper rounding
        costEstimateElement.textContent = 'LKR ' + Math.round(totalCost);
    }

    // Add event listeners when DOM is ready
    document.addEventListener('DOMContentLoaded', function() {
        // Add listeners for banner type radio buttons
        var bannerInputs = document.querySelectorAll('input[name="bannerType"]');
        bannerInputs.forEach(function(input) {
            input.addEventListener('change', updateCost);
        });

        // Add listener for discount input
        var discountInput = document.querySelector('input[name="discount"]');
        if (discountInput) {
            discountInput.addEventListener('input', updateCost);
        }

        // Add listener for duration select
        var durationSelect = document.querySelector('select[name="duration"]');
        if (durationSelect) {
            durationSelect.addEventListener('change', updateCost);
        }

        // Ensure all buttons are clickable
        const buttons = document.querySelectorAll('.btn-modern, .btn-secondary-modern, .btn-primary-modern, .btn-warning-modern, .btn-danger-modern');
        buttons.forEach(function(button) {
            button.addEventListener('click', function(e) {
                console.log('Button clicked:', this.textContent.trim());
                // Let the default behavior happen (navigation, form submission, etc.)
            });
            
            // Add visual feedback
            button.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });
            
            button.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        // Initial cost calculation
        updateCost();
    });
</script>
</body>
</html>
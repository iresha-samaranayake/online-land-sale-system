<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .table-responsive {
        border-radius: 1rem;
        overflow: hidden;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .table {
        margin-bottom: 0;
        font-size: 0.875rem;
    }

    .table thead th {
        background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
        color: white;
        font-weight: 700;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        padding: 0.75rem 0.5rem;
        border: none;
        vertical-align: middle;
    }

    .table tbody td {
        padding: 0.5rem;
        vertical-align: middle;
        border-color: rgba(0, 0, 0, 0.05);
        font-size: 0.8rem;
    }

    .table tbody tr {
        transition: all 0.3s ease;
    }

    .table tbody tr:hover {
        background: rgba(99, 102, 241, 0.05);
        transform: scale(1.01);
    }

    .thumbnail-image {
        width: 40px;
        height: 40px;
        object-fit: cover;
        border-radius: 0.5rem;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .badge {
        font-size: 0.7rem;
        padding: 0.4rem 0.8rem;
        border-radius: 0.5rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
</style>

<h4 class="text-primary mt-4 mb-3"><i class="fas fa-table"></i> Featured Listings (Table View)</h4>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>Image</th>
                <th>ID</th>
                <th>Listing Title</th>
                <th>Location</th>
                <th>Size</th>
                <th>Price</th>
                <th>Banner Type</th>
                <th>Discount</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty featuredPromotions}">
                    <c:forEach items="${featuredPromotions}" var="promo">
                        <c:if test="${promo.listing != null}">
                            <tr>
                                <c:if test="${not empty promo.listing.images}">
                                    <c:set var="primaryImage" value="${promo.listing.images.stream().filter(i -> i.isPrimary).findFirst().orElse(promo.listing.images[0])}" />
                                    <td><img src="${primaryImage.imageUrl}" alt="${promo.listing.title} Image" class="thumbnail-image"></td>
                                </c:if>
                                <c:if test="${empty promo.listing.images}">
                                    <td>No Image</td>
                                </c:if>
                                <td>${promo.id}</td>
                                <td>${promo.listing.title}</td>
                                <td>${promo.listing.location}</td>
                                <td>${promo.listing.size} Acres</td>
                                <td>LKR ${promo.listing.price}</td>
                                <td>
                                    <span class="badge ${promo.bannerType == 'GOLD' ? 'bg-warning' : promo.bannerType == 'SILVER' ? 'bg-secondary' : 'bg-info'}">${promo.bannerType}</span>
                                </td>
                                <td>${(promo.discountPercentage > 0 ? promo.discountPercentage : 0)}%</td>
                                <td>
                                    <span class="badge ${promo.isActive ? 'bg-success' : 'bg-danger'}">${promo.isActive ? 'Active' : 'Inactive'}</span>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="9" class="text-center text-muted">No active featured promotions available at this time.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
    <h4 class="text-primary mb-3"><i class="fas fa-star"></i> Featured Listings (Poster View)</h4>
    <div class="row">
        <c:if test="${not empty featuredPromotions}">
            <c:forEach items="${featuredPromotions}" var="promo">
                <c:if test="${promo.listing != null}">
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="poster-card">
                            <div class="poster-wrapper ${promo.bannerType == 'GOLD' ? 'gold-size' : promo.bannerType == 'SILVER' ? 'silver-size' : 'bronze-size'}">
                                <span class="badge-tier ${promo.bannerType == 'GOLD' ? 'badge-gold' : promo.bannerType == 'SILVER' ? 'badge-silver' : 'badge-bronze'}">
                                    <i class="fas ${promo.bannerType == 'GOLD' ? 'fa-crown' : promo.bannerType == 'SILVER' ? 'fa-medal' : 'fa-award'}"></i> ${promo.bannerType}
                                </span>
                                <c:if test="${promo.discountPercentage > 0}">
                                    <span class="badge-discount">
                                        ${promo.discountPercentage}% OFF
                                    </span>
                                </c:if>
                                <c:choose>
                                    <c:when test="${not empty promo.listing.images}">
                                        <c:set var="primaryImage" value="${promo.listing.images.stream().filter(i -> i.isPrimary).findFirst().orElse(promo.listing.images[0])}" />
                                        <img src="${primaryImage.imageUrl}" alt="${promo.listing.title}" class="poster-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="poster-placeholder">
                                            <i class="fas fa-image fa-4x"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <div class="poster-overlay">
                                    <h5 class="poster-title">${promo.listing.title}</h5>
                                    <p class="poster-location">
                                        <i class="fas fa-map-marker-alt"></i> ${promo.listing.location}
                                    </p>
                                    <div class="poster-price">LKR ${promo.listing.price}</div>
                                    <p class="poster-size">
                                        <i class="fas fa-ruler-combined"></i> ${promo.listing.size} Acres
                                    </p>
                                    <div class="poster-buttons">
                                        <a href="/lands/view/${promo.listing.id}" class="btn btn-light btn-sm">
                                            View
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </c:if>
    </div>
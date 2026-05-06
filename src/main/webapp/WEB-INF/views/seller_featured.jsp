<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .modern-table-container {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 15px;
        padding: 1rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        margin: 1rem 0;
    }

    .modern-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.85rem;
        color: #ffffff;
    }

    .modern-table thead th {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #ffffff;
        padding: 0.75rem 0.5rem;
        text-align: left;
        font-weight: 600;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border: none;
        position: sticky;
        top: 0;
        z-index: 10;
    }

    .modern-table tbody tr {
        background: rgba(255, 255, 255, 0.05);
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        transition: all 0.3s ease;
    }

    .modern-table tbody tr:hover {
        background: rgba(255, 255, 255, 0.1);
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }

    .modern-table tbody td {
        padding: 0.6rem 0.5rem;
        border: none;
        vertical-align: middle;
        color: #000000;
    }

    .modern-table .thumbnail-image {
        width: 40px;
        height: 40px;
        border-radius: 8px;
        object-fit: cover;
        border: 2px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s ease;
    }

    .modern-table .thumbnail-image:hover {
        transform: scale(1.1);
        border-color: rgba(79, 172, 254, 0.5);
        box-shadow: 0 0 15px rgba(79, 172, 254, 0.3);
    }

    .modern-badge {
        padding: 0.25rem 0.5rem;
        border-radius: 12px;
        font-size: 0.7rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border: 1px solid;
        backdrop-filter: blur(10px);
    }

    .badge-gold {
        background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
        color: #000;
        border-color: rgba(255, 215, 0, 0.3);
        box-shadow: 0 0 10px rgba(255, 215, 0, 0.3);
    }

    .badge-silver {
        background: linear-gradient(135deg, #c0c0c0 0%, #e8e8e8 100%);
        color: #000;
        border-color: rgba(192, 192, 192, 0.3);
        box-shadow: 0 0 10px rgba(192, 192, 192, 0.3);
    }

    .badge-bronze {
        background: linear-gradient(135deg, #cd7f32 0%, #daa520 100%);
        color: #fff;
        border-color: rgba(205, 127, 50, 0.3);
        box-shadow: 0 0 10px rgba(205, 127, 50, 0.3);
    }

    .badge-success {
        background: linear-gradient(135deg, #4ade80 0%, #22c55e 100%);
        color: #fff;
        border-color: rgba(74, 222, 128, 0.3);
        box-shadow: 0 0 10px rgba(74, 222, 128, 0.3);
    }

    .badge-danger {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
        color: #fff;
        border-color: rgba(255, 107, 107, 0.3);
        box-shadow: 0 0 10px rgba(255, 107, 107, 0.3);
    }

    .no-data-message {
        text-align: center;
        padding: 2rem;
        color: rgba(255, 255, 255, 0.6);
        font-style: italic;
        background: rgba(255, 255, 255, 0.05);
        border-radius: 10px;
        margin: 1rem 0;
    }

    .table-responsive {
        overflow-x: auto;
        border-radius: 15px;
    }

    .table-responsive::-webkit-scrollbar {
        height: 8px;
    }

    .table-responsive::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 4px;
    }

    .table-responsive::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 4px;
    }

    .table-responsive::-webkit-scrollbar-thumb:hover {
        background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    }

    @media (max-width: 768px) {
        .modern-table {
            font-size: 0.75rem;
        }
        
        .modern-table thead th,
        .modern-table tbody td {
            padding: 0.4rem 0.3rem;
        }
        
        .modern-table .thumbnail-image {
            width: 30px;
            height: 30px;
        }
        
        .modern-badge {
            font-size: 0.6rem;
            padding: 0.2rem 0.4rem;
        }
    }
</style>

<div class="modern-table-container">
    <div class="table-responsive">
        <table class="modern-table">
            <thead>
                <tr>
                    <th><i class="fas fa-image me-1"></i>Image</th>
                    <th><i class="fas fa-hashtag me-1"></i>ID</th>
                    <th><i class="fas fa-tag me-1"></i>Title</th>
                    <th><i class="fas fa-map-marker-alt me-1"></i>Location</th>
                    <th><i class="fas fa-ruler-combined me-1"></i>Size</th>
                    <th><i class="fas fa-dollar-sign me-1"></i>Price</th>
                    <th><i class="fas fa-star me-1"></i>Banner</th>
                    <th><i class="fas fa-percentage me-1"></i>Discount</th>
                    <th><i class="fas fa-toggle-on me-1"></i>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty featuredPromotions}">
                        <c:forEach items="${featuredPromotions}" var="promo">
                            <c:if test="${promo.listing != null && promo.listing.seller.id == loggedInUser.id}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty promo.listing.images}">
                                                <c:set var="primaryImage" value="${promo.listing.images.stream().filter(i -> i.isPrimary).findFirst().orElse(promo.listing.images[0])}" />
                                                <img src="${primaryImage.imageUrl}" alt="${promo.listing.title} Image" class="thumbnail-image">
                                            </c:when>
                                            <c:otherwise>
                                                <div style="width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); border-radius: 8px; display: flex; align-items: center; justify-content: center;">
                                                    <i class="fas fa-image" style="color: rgba(255, 255, 255, 0.5); font-size: 0.8rem;"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><strong>${promo.id}</strong></td>
                                    <td style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${promo.listing.title}">${promo.listing.title}</td>
                                    <td style="max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" title="${promo.listing.location}">${promo.listing.location}</td>
                                    <td>${promo.listing.size} Acres</td>
                                    <td><strong>LKR ${promo.listing.price}</strong></td>
                                    <td>
                                        <span class="modern-badge ${promo.bannerType == 'GOLD' ? 'badge-gold' : promo.bannerType == 'SILVER' ? 'badge-silver' : 'badge-bronze'}">
                                            ${promo.bannerType}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${promo.discountPercentage > 0}">
                                                <span style="color: #4ade80; font-weight: 600;">${promo.discountPercentage}%</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: rgba(255, 255, 255, 0.5);">0%</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="modern-badge ${promo.isActive ? 'badge-success' : 'badge-danger'}">
                                            ${promo.isActive ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="9" class="no-data-message">
                                <i class="fas fa-info-circle me-2"></i>
                                No active featured promotions available at this time.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>
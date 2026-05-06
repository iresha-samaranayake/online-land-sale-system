<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .featured-bar {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #ffffff;
        padding: 1rem 1.5rem;
        border-radius: 15px;
        margin-bottom: 2rem;
        font-weight: 700;
        font-size: 1.2rem;
        text-align: center;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        position: relative;
        overflow: hidden;
    }

    .featured-bar::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
        animation: shimmer 3s infinite;
    }

    @keyframes shimmer {
        0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
        100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
    }

    .featured-bar i {
        margin-right: 0.5rem;
        color: #ffd700;
        animation: sparkle 2s infinite;
    }

    @keyframes sparkle {
        0%, 100% { transform: scale(1) rotate(0deg); }
        50% { transform: scale(1.1) rotate(180deg); }
    }

    .buyer-featured-card {
        position: relative;
        height: auto;
        transition: all 0.3s ease;
    }

    .buyer-featured-card:hover {
        transform: translateY(-10px);
    }

    .buyer-featured-wrapper {
        position: relative;
        border-radius: 20px;
        overflow: hidden;
        background: #ffffff;
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        height: auto;
        display: flex;
        flex-direction: column;
    }

    .buyer-featured-media {
        position: relative;
        width: 100%;
        height: 240px;
        overflow: hidden;
        background: #f3f4f6;
        border-bottom: 1px solid rgba(0, 0, 0, 0.06);
    }

    .buyer-featured-wrapper:hover {
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        border-color: rgba(79, 172, 254, 0.5);
    }

    .buyer-featured-wrapper.gold-size {
        border: 2px solid rgba(255, 215, 0, 0.5);
        box-shadow: 0 0 30px rgba(255, 215, 0, 0.3);
    }

    .buyer-featured-wrapper.gold-size .buyer-featured-media {
        height: 320px;
    }

    .buyer-featured-wrapper.gold-size .buyer-featured-title {
        font-size: 1.35rem;
    }

    .buyer-featured-wrapper.silver-size {
        border: 2px solid rgba(192, 192, 192, 0.5);
        box-shadow: 0 0 30px rgba(192, 192, 192, 0.3);
    }

    .buyer-featured-wrapper.silver-size .buyer-featured-media {
        height: 260px;
    }

    .buyer-featured-wrapper.silver-size .buyer-featured-title {
        font-size: 1.2rem;
    }

    .buyer-featured-wrapper.bronze-size {
        border: 2px solid rgba(205, 127, 50, 0.5);
        box-shadow: 0 0 30px rgba(205, 127, 50, 0.3);
    }

    .buyer-featured-wrapper.bronze-size .buyer-featured-media {
        height: 220px;
    }

    .badge-tier {
        position: absolute;
        top: 1rem;
        left: 1rem;
        z-index: 10;
        padding: 0.5rem 1rem;
        border-radius: 25px;
        font-weight: 700;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        backdrop-filter: blur(10px);
        border: 1px solid;
        animation: pulse 2s infinite;
    }

    .badge-gold {
        background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
        color: #000;
        border-color: rgba(255, 215, 0, 0.3);
        box-shadow: 0 0 15px rgba(255, 215, 0, 0.4);
    }

    .badge-silver {
        background: linear-gradient(135deg, #c0c0c0 0%, #e8e8e8 100%);
        color: #000;
        border-color: rgba(192, 192, 192, 0.3);
        box-shadow: 0 0 15px rgba(192, 192, 192, 0.4);
    }

    .badge-bronze {
        background: linear-gradient(135deg, #cd7f32 0%, #daa520 100%);
        color: #fff;
        border-color: rgba(205, 127, 50, 0.3);
        box-shadow: 0 0 15px rgba(205, 127, 50, 0.4);
    }

    .badge-discount {
        position: absolute;
        top: 1rem;
        right: 1rem;
        z-index: 10;
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
        color: #fff;
        padding: 0.4rem 0.8rem;
        border-radius: 20px;
        font-weight: 700;
        font-size: 0.7rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 0 15px rgba(255, 107, 107, 0.4);
        animation: bounce 2s infinite;
    }

    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-5px); }
    }

    .buyer-featured-image {
        width: 100%;
        height: 100%;
        display: block;
        object-fit: cover;
        object-position: center;
        transition: all 0.3s ease;
    }

    .buyer-featured-card:hover .buyer-featured-image {
        transform: scale(1.05);
    }

    .buyer-featured-placeholder {
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, #e5e7eb 0%, #cbd5e1 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        color: rgba(71, 85, 105, 0.45);
    }

    .buyer-featured-overlay {
        padding: 1.5rem;
        background: linear-gradient(180deg, rgba(15, 23, 42, 0.78) 0%, rgba(30, 41, 59, 0.92) 100%);
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        gap: 1rem;
    }

    .buyer-featured-title {
        color: #ffffff;
        font-weight: 700;
        font-size: 1.1rem;
        margin-bottom: 0.5rem;
        line-height: 1.3;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .buyer-featured-location {
        color: rgba(255, 255, 255, 0.8);
        font-size: 0.9rem;
        margin-bottom: 0.5rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .buyer-featured-price {
        color: #4ade80;
        font-weight: 700;
        font-size: 1.2rem;
        margin-bottom: 0.5rem;
    }

    .buyer-featured-size {
        color: rgba(255, 255, 255, 0.7);
        font-size: 0.85rem;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .buyer-featured-buttons {
        display: flex;
        gap: 0.5rem;
    }

    .buyer-featured-buttons .btn {
        flex: 1;
        padding: 0.6rem 1rem;
        border-radius: 25px;
        font-weight: 600;
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .buyer-featured-buttons .btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
        transition: left 0.5s;
    }

    .buyer-featured-buttons .btn:hover::before {
        left: 100%;
    }

    .buyer-featured-buttons .btn-light {
        background: rgba(255, 255, 255, 0.9);
        color: #000;
        border: none;
    }

    .buyer-featured-buttons .btn-light:hover {
        background: #ffffff;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.3);
    }

    .buyer-featured-buttons .btn-outline-light {
        background: transparent;
        color: #ffffff;
        border: 2px solid rgba(255, 255, 255, 0.5);
    }

    .buyer-featured-buttons .btn-outline-light:hover {
        background: rgba(255, 255, 255, 0.1);
        border-color: #ffffff;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 255, 255, 0.2);
    }

    .no-data-alert {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 15px;
        padding: 2rem;
        text-align: center;
        color: rgba(255, 255, 255, 0.8);
        margin: 2rem 0;
    }

    .no-data-alert i {
        font-size: 2rem;
        color: rgba(79, 172, 254, 0.8);
        margin-bottom: 1rem;
    }

    @media (max-width: 768px) {
        .featured-bar {
            font-size: 1rem;
            padding: 0.8rem 1rem;
        }
        
        .buyer-featured-wrapper {
            margin-bottom: 1rem;
        }
        
        .buyer-featured-image {
            min-height: 0;
        }

        .buyer-featured-media {
            height: 200px;
        }

        .buyer-featured-wrapper.gold-size .buyer-featured-media,
        .buyer-featured-wrapper.silver-size .buyer-featured-media,
        .buyer-featured-wrapper.bronze-size .buyer-featured-media {
            height: 200px;
        }
        
        .buyer-featured-overlay {
            padding: 1rem;
        }
        
        .buyer-featured-title {
            font-size: 1rem;
        }
        
        .buyer-featured-price {
            font-size: 1.1rem;
        }
        
        .buyer-featured-buttons .btn {
            padding: 0.5rem 0.8rem;
            font-size: 0.7rem;
        }
    }
</style>

<div class="featured-bar">
    <i class="fas fa-star"></i> Featured Lands
</div>
<div class="row align-items-stretch">
    <c:if test="${not empty featuredPromotions}">
        <c:forEach items="${featuredPromotions}" var="promo">
            <c:if test="${promo.listing != null}">
                <div class="${promo.bannerType == 'GOLD' ? 'col-lg-6 col-md-12' : promo.bannerType == 'SILVER' ? 'col-lg-4 col-md-6' : 'col-lg-3 col-md-6'} mb-4">
                    <div class="buyer-featured-card">
                        <div class="buyer-featured-wrapper ${promo.bannerType == 'GOLD' ? 'gold-size' : promo.bannerType == 'SILVER' ? 'silver-size' : 'bronze-size'}">
                            <span class="badge-tier ${promo.bannerType == 'GOLD' ? 'badge-gold' : promo.bannerType == 'SILVER' ? 'badge-silver' : 'badge-bronze'}">
                                <i class="fas ${promo.bannerType == 'GOLD' ? 'fa-crown' : promo.bannerType == 'SILVER' ? 'fa-medal' : 'fa-award'}"></i> ${promo.bannerType}
                            </span>
                            <c:if test="${promo.discountPercentage > 0}">
                                <span class="badge-discount">${promo.discountPercentage}% OFF</span>
                            </c:if>
                            <div class="buyer-featured-media">
                                <c:choose>
                                    <c:when test="${not empty promo.listing.images}">
                                        <c:set var="primaryImage" value="${promo.listing.images.stream().filter(i -> i.isPrimary).findFirst().orElse(promo.listing.images[0])}" />
                                        <img src="${primaryImage.imageUrl}" alt="${promo.listing.title}" class="buyer-featured-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="buyer-featured-placeholder">
                                            <i class="fas fa-image fa-4x"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="buyer-featured-overlay">
                                <div>
                                    <h5 class="buyer-featured-title">${promo.listing.title}</h5>
                                    <p class="buyer-featured-location">
                                        <i class="fas fa-map-marker-alt"></i> ${promo.listing.location}
                                    </p>
                                    <div class="buyer-featured-price">LKR ${promo.listing.price}</div>
                                    <p class="buyer-featured-size">
                                        <i class="fas fa-ruler-combined"></i> ${promo.listing.size} Acres
                                    </p>
                                </div>
                                <div class="buyer-featured-buttons">
                                    <a href="/lands/view/${promo.listing.id}" class="btn btn-light btn-sm">View</a>
                                    <a href="/bookings/create/${promo.listing.id}" class="btn btn-outline-light btn-sm">Book</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </c:if>
    <c:if test="${empty featuredPromotions}">
        <div class="col-12">
            <div class="no-data-alert">
                <i class="fas fa-info-circle"></i>
                <h5>No Featured Lands Available</h5>
                <p>No featured promotions available at this time. Check back later for exciting land deals!</p>
            </div>
        </div>
    </c:if>
</div>

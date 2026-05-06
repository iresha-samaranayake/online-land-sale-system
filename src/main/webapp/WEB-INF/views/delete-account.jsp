<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Account - Online Land Sales System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            --warning-gradient: linear-gradient(135deg, #ffa726 0%, #ff7043 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.8);
            --shadow-glow: 0 0 30px rgba(102, 126, 234, 0.3);
            --danger-glow: 0 0 30px rgba(255, 107, 107, 0.3);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--primary-gradient);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 80%, rgba(255, 107, 107, 0.2) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 87, 51, 0.2) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.1) 0%, transparent 50%);
            z-index: -1;
            animation: backgroundShift 20s ease-in-out infinite;
        }

        @keyframes backgroundShift {
            0%, 100% { transform: translateX(0) translateY(0); }
            25% { transform: translateX(-20px) translateY(-10px); }
            50% { transform: translateX(20px) translateY(10px); }
            75% { transform: translateX(-10px) translateY(20px); }
        }

        .navbar {
            background: rgba(255, 255, 255, 0.1) !important;
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--glass-border);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-link {
            color: var(--text-secondary) !important;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link:hover {
            color: var(--text-primary) !important;
            transform: translateY(-2px);
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--accent-gradient);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .delete-container {
            position: relative;
            z-index: 1;
        }

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            box-shadow: var(--danger-glow);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(255, 107, 107, 0.4);
        }

        .danger-header {
            background: var(--danger-gradient);
            border-radius: 20px 20px 0 0;
            padding: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .danger-header::before {
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

        .danger-icon {
            width: 120px;
            height: 120px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: var(--text-primary);
            margin: 0 auto 1rem;
            position: relative;
            z-index: 2;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .danger-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 2;
        }

        .danger-subtitle {
            color: var(--text-secondary);
            font-size: 1rem;
            position: relative;
            z-index: 2;
        }

        .form-section {
            padding: 2rem;
        }

        .warning-box {
            background: rgba(255, 167, 38, 0.1);
            border: 1px solid rgba(255, 167, 38, 0.3);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            backdrop-filter: blur(10px);
        }

        .warning-header {
            color: #ffa726;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .warning-list {
            color: var(--text-secondary);
            margin: 0;
            padding-left: 1.5rem;
        }

        .warning-list li {
            margin-bottom: 0.5rem;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-label {
            color: var(--text-primary);
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-group-modern {
            position: relative;
            margin-bottom: 0.5rem;
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            z-index: 3;
            transition: all 0.3s ease;
        }

        .form-control-modern {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .form-control-modern:focus {
            outline: none;
            border-color: rgba(255, 107, 107, 0.5);
            box-shadow: 0 0 20px rgba(255, 107, 107, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-control-modern::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .checkbox-modern {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 2rem 0;
            padding: 1rem;
            background: rgba(255, 107, 107, 0.1);
            border: 1px solid rgba(255, 107, 107, 0.3);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .checkbox-modern:hover {
            background: rgba(255, 107, 107, 0.15);
            transform: scale(1.02);
        }

        .checkbox-modern input[type="checkbox"] {
            width: 20px;
            height: 20px;
            accent-color: #ff6b6b;
            cursor: pointer;
        }

        .checkbox-modern label {
            color: var(--text-primary);
            font-weight: 600;
            cursor: pointer;
            flex: 1;
        }

        .btn-modern {
            padding: 0.8rem 2rem;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
            cursor: pointer;
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
            background: var(--accent-gradient);
            color: white;
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.4);
        }

        .btn-primary-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(79, 172, 254, 0.6);
            color: white;
        }

        .btn-secondary-modern {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .btn-secondary-modern:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
            color: var(--text-primary);
        }

        .btn-danger-modern {
            background: var(--danger-gradient);
            color: white;
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
        }

        .btn-danger-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(255, 107, 107, 0.6);
            color: white;
        }

        .btn-danger-modern:disabled {
            background: rgba(255, 107, 107, 0.3);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .alert-modern {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: var(--text-primary);
            margin-bottom: 2rem;
        }

        .alert-danger-modern {
            border-left: 4px solid #f87171;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 2rem;
        }

        .floating-elements {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        .floating-element {
            position: absolute;
            background: rgba(255, 107, 107, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .floating-element:nth-child(1) {
            width: 80px;
            height: 80px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-element:nth-child(2) {
            width: 120px;
            height: 120px;
            top: 60%;
            right: 10%;
            animation-delay: 2s;
        }

        .floating-element:nth-child(3) {
            width: 60px;
            height: 60px;
            bottom: 20%;
            left: 20%;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        @media (max-width: 768px) {
            .danger-title {
                font-size: 1.5rem;
            }
            
            .danger-icon {
                width: 100px;
                height: 100px;
                font-size: 3rem;
            }
            
            .form-actions {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-modern {
                width: 100%;
                max-width: 300px;
            }
            
            .form-control-modern {
                padding: 0.8rem 0.8rem 0.8rem 2.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Floating Background Elements -->
    <div class="floating-elements">
        <div class="floating-element"></div>
        <div class="floating-element"></div>
        <div class="floating-element"></div>
    </div>

    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-globe-americas me-2"></i>LandSales Portal
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/">
                    <i class="fas fa-home me-1"></i>Home
                </a>
                <a class="nav-link" href="/profile">
                    <i class="fas fa-user me-1"></i>Profile
                </a>
                <a class="nav-link" href="/logout">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container delete-container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="glass-card">
                    <!-- Danger Header -->
                    <div class="danger-header">
                        <div class="danger-icon">
                            <i class="fas fa-user-times"></i>
                        </div>
                        <h1 class="danger-title">Delete Account</h1>
                        <p class="danger-subtitle">This action cannot be undone</p>
                    </div>

                    <!-- Form Section -->
                    <div class="form-section">
                        <!-- Display Messages -->
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-modern alert-danger-modern alert-dismissible fade show">
                                <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <!-- Warning Box -->
                        <div class="warning-box">
                            <div class="warning-header">
                                <i class="fas fa-info-circle"></i>
                                What will be deleted:
                            </div>
                            <ul class="warning-list">
                                <li>Your profile information</li>
                                <li>All your land listings</li>
                                <li>Your booking history</li>
                                <li>Payment plans and transactions</li>
                                <li>Reviews and feedback</li>
                            </ul>
                        </div>

                        <form action="/profile/delete" method="post" id="deleteAccountForm">
                            <p class="text-center mb-4" style="color: var(--text-primary); font-weight: 600;">
                                To confirm deletion, please enter your email and password:
                            </p>

                            <div class="form-group">
                                <label for="confirmEmail" class="form-label">Email Address</label>
                                <div class="input-group-modern">
                                    <i class="fas fa-envelope input-icon"></i>
                                    <input type="email" class="form-control-modern" id="confirmEmail" name="confirmEmail" 
                                           placeholder="Enter your email" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Password</label>
                                <div class="input-group-modern">
                                    <i class="fas fa-lock input-icon"></i>
                                    <input type="password" class="form-control-modern" id="confirmPassword" name="confirmPassword" 
                                           placeholder="Enter your password" required>
                                </div>
                            </div>

                            <!-- Confirmation Checkbox -->
                            <div class="checkbox-modern">
                                <input class="form-check-input" type="checkbox" id="confirmDelete" required>
                                <label class="form-check-label" for="confirmDelete">
                                    <strong>I understand that this action cannot be undone</strong>
                                </label>
                            </div>

                            <!-- Form Actions -->
                            <div class="form-actions">
                                <a href="/profile" class="btn-modern btn-secondary-modern">
                                    <i class="fas fa-arrow-left me-2"></i>Cancel
                                </a>
                                <button type="submit" class="btn-modern btn-danger-modern" id="deleteButton" disabled>
                                    <i class="fas fa-trash me-2"></i>Delete My Account
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Enhanced JavaScript for Modern Delete Account Interactions -->
    <script>
        // Enable delete button only when checkbox is checked with enhanced animation
        document.getElementById('confirmDelete').addEventListener('change', function() {
            const deleteButton = document.getElementById('deleteButton');
            const checkboxContainer = this.closest('.checkbox-modern');
            
            if (this.checked) {
                deleteButton.disabled = false;
                deleteButton.style.transform = 'scale(1.05)';
                checkboxContainer.style.background = 'rgba(255, 107, 107, 0.2)';
                checkboxContainer.style.borderColor = 'rgba(255, 107, 107, 0.5)';
                
                // Add pulsing effect to delete button
                deleteButton.style.animation = 'pulse 1s infinite';
            } else {
                deleteButton.disabled = true;
                deleteButton.style.transform = 'scale(1)';
                deleteButton.style.animation = 'none';
                checkboxContainer.style.background = 'rgba(255, 107, 107, 0.1)';
                checkboxContainer.style.borderColor = 'rgba(255, 107, 107, 0.3)';
            }
        });

        // Enhanced confirmation dialog before submission
        document.getElementById('deleteAccountForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Create custom confirmation modal
            const confirmationModal = document.createElement('div');
            confirmationModal.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.8);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 10000;
                backdrop-filter: blur(10px);
            `;
            
            confirmationModal.innerHTML = `
                <div style="
                    background: var(--glass-bg);
                    backdrop-filter: blur(20px);
                    border: 1px solid var(--glass-border);
                    border-radius: 20px;
                    padding: 2rem;
                    max-width: 500px;
                    width: 90%;
                    text-align: center;
                    box-shadow: var(--danger-glow);
                ">
                    <div style="font-size: 4rem; color: #ff6b6b; margin-bottom: 1rem;">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <h3 style="color: var(--text-primary); margin-bottom: 1rem;">Final Confirmation</h3>
                    <p style="color: var(--text-secondary); margin-bottom: 2rem; line-height: 1.6;">
                        Are you absolutely sure you want to delete your account?<br>
                        <strong style="color: #ff6b6b;">This action cannot be undone!</strong>
                    </p>
                    <div style="display: flex; gap: 1rem; justify-content: center;">
                        <button id="cancelDelete" style="
                            padding: 0.8rem 2rem;
                            background: rgba(255, 255, 255, 0.1);
                            color: var(--text-primary);
                            border: 1px solid rgba(255, 255, 255, 0.3);
                            border-radius: 25px;
                            cursor: pointer;
                            font-weight: 600;
                        ">Cancel</button>
                        <button id="confirmDeleteFinal" style="
                            padding: 0.8rem 2rem;
                            background: var(--danger-gradient);
                            color: white;
                            border: none;
                            border-radius: 25px;
                            cursor: pointer;
                            font-weight: 600;
                            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
                        ">Yes, Delete Account</button>
                    </div>
                </div>
            `;
            
            document.body.appendChild(confirmationModal);
            
            // Handle cancel
            document.getElementById('cancelDelete').addEventListener('click', function() {
                document.body.removeChild(confirmationModal);
            });
            
            // Handle final confirmation
            document.getElementById('confirmDeleteFinal').addEventListener('click', function() {
                // Remove modal and submit form
                document.body.removeChild(confirmationModal);
                document.getElementById('deleteAccountForm').submit();
            });
        });

        // Auto-hide alerts after 4 seconds with enhanced animation
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert-modern');
            alerts.forEach(function(alert) {
                alert.style.transition = 'all 0.5s ease';
                alert.style.transform = 'translateX(100%)';
                alert.style.opacity = '0';
                setTimeout(function() {
                    alert.remove();
                }, 500);
            });
        }, 4000);

        // Enhanced form interactions
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('deleteAccountForm');
            const inputs = form.querySelectorAll('.form-control-modern');
            
            inputs.forEach(input => {
                // Add focus/blur animations
                input.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                    this.parentElement.style.transition = 'all 0.3s ease';
                });
                
                input.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });

                // Real-time validation feedback
                input.addEventListener('input', function() {
                    if (this.checkValidity()) {
                        this.style.borderColor = 'rgba(74, 222, 128, 0.5)';
                        this.style.boxShadow = '0 0 20px rgba(74, 222, 128, 0.3)';
                    } else {
                        this.style.borderColor = 'rgba(248, 113, 113, 0.5)';
                        this.style.boxShadow = '0 0 20px rgba(248, 113, 113, 0.3)';
                    }
                });
            });

            // Enhanced button interactions
            const buttons = document.querySelectorAll('.btn-modern');
            
            buttons.forEach(button => {
                button.addEventListener('mouseenter', function() {
                    if (!this.disabled) {
                        this.style.transform = 'translateY(-3px) scale(1.05)';
                    }
                });
                
                button.addEventListener('mouseleave', function() {
                    if (!this.disabled) {
                        this.style.transform = 'translateY(0) scale(1)';
                    }
                });

                // Add ripple effect to buttons
                button.addEventListener('click', function(e) {
                    if (!this.disabled) {
                        const ripple = document.createElement('span');
                        const rect = this.getBoundingClientRect();
                        const size = Math.max(rect.width, rect.height);
                        const x = e.clientX - rect.left - size / 2;
                        const y = e.clientY - rect.top - size / 2;
                        
                        ripple.style.width = ripple.style.height = size + 'px';
                        ripple.style.left = x + 'px';
                        ripple.style.top = y + 'px';
                        ripple.classList.add('ripple');
                        
                        this.appendChild(ripple);
                        
                        setTimeout(() => {
                            ripple.remove();
                        }, 600);
                    }
                });
            });

            // Enhanced input focus effects
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    const icon = this.parentElement.querySelector('.input-icon');
                    if (icon) {
                        icon.style.color = 'rgba(255, 107, 107, 0.8)';
                        icon.style.transform = 'translateY(-50%) scale(1.1)';
                    }
                });
                
                input.addEventListener('blur', function() {
                    const icon = this.parentElement.querySelector('.input-icon');
                    if (icon) {
                        icon.style.color = 'rgba(255, 255, 255, 0.8)';
                        icon.style.transform = 'translateY(-50%) scale(1)';
                    }
                });
            });
        });

        // Add CSS for ripple effect
        const style = document.createElement('style');
        style.textContent = `
            .btn-modern {
                position: relative;
                overflow: hidden;
            }
            
            .ripple {
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                transform: scale(0);
                animation: ripple-animation 0.6s linear;
                pointer-events: none;
            }
            
            @keyframes ripple-animation {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        // Parallax effect for floating elements
        window.addEventListener('scroll', function() {
            const scrolled = window.pageYOffset;
            const parallaxElements = document.querySelectorAll('.floating-element');
            
            parallaxElements.forEach((element, index) => {
                const speed = 0.5 + (index * 0.1);
                element.style.transform = `translateY(${scrolled * speed}px) rotate(${scrolled * 0.1}deg)`;
            });
        });

        // Add smooth scroll behavior
        document.documentElement.style.scrollBehavior = 'smooth';

        // Add typing animation to danger title
        function typeWriter(element, text, speed = 100) {
            let i = 0;
            element.innerHTML = '';
            
            function type() {
                if (i < text.length) {
                    element.innerHTML += text.charAt(i);
                    i++;
                    setTimeout(type, speed);
                }
            }
            
            type();
        }

        // Initialize typing animation when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const dangerTitle = document.querySelector('.danger-title');
            if (dangerTitle) {
                const originalText = dangerTitle.textContent;
                setTimeout(() => {
                    typeWriter(dangerTitle, originalText, 150);
                }, 1000);
            }
        });
    </script>
</body>
</html>

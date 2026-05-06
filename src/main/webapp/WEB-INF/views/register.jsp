<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Online Land Sales System</title>
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

        .floating-circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 6s ease-in-out infinite;
        }

        .circle-1 {
            width: 100px;
            height: 100px;
            top: 15%;
            left: 8%;
            animation-delay: 0s;
        }

        .circle-2 {
            width: 80px;
            height: 80px;
            top: 70%;
            right: 12%;
            animation-delay: 2s;
        }

        .circle-3 {
            width: 60px;
            height: 60px;
            bottom: 15%;
            left: 15%;
            animation-delay: 4s;
        }

        .floating-triangle {
            position: absolute;
            width: 0;
            height: 0;
            animation: float 8s ease-in-out infinite;
        }

        .triangle-1 {
            border-left: 25px solid transparent;
            border-right: 25px solid transparent;
            border-bottom: 45px solid rgba(255, 255, 255, 0.1);
            top: 25%;
            right: 8%;
            animation-delay: 1s;
        }

        .triangle-2 {
            border-left: 15px solid transparent;
            border-right: 15px solid transparent;
            border-bottom: 30px solid rgba(255, 255, 255, 0.1);
            bottom: 25%;
            right: 25%;
            animation-delay: 3s;
        }

        .floating-square {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            animation: float 7s ease-in-out infinite;
        }

        .square-1 {
            width: 35px;
            height: 35px;
            top: 45%;
            left: 3%;
            animation-delay: 2.5s;
        }

        .square-2 {
            width: 50px;
            height: 50px;
            bottom: 35%;
            right: 3%;
            animation-delay: 5s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        /* Register Container */
        .register-container {
            position: relative;
            z-index: 10;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 2rem 0;
        }

        /* Register Card */
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 3rem;
            position: relative;
            overflow: hidden;
        }

        .register-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
            z-index: 1;
        }

        .register-card .card-content {
            position: relative;
            z-index: 2;
        }

        /* Register Header */
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .register-title {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--primary);
            margin-bottom: 0.5rem;
            text-shadow: 0 4px 8px rgba(99, 102, 241, 0.3);
        }

        .register-subtitle {
            color: var(--gray-600);
            font-size: 1.125rem;
            font-weight: 500;
        }

        /* Role Cards */
        .role-card {
            border: 2px solid rgba(99, 102, 241, 0.1);
            border-radius: 1.5rem;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            margin-bottom: 1rem;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            padding: 1.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .role-card::before {
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

        .role-card:hover::before {
            opacity: 1;
        }

        .role-card:hover {
            border-color: var(--primary);
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.2);
        }

        .role-card.selected {
            border-color: var(--primary);
            background: rgba(99, 102, 241, 0.1);
            transform: translateY(-3px) scale(1.01);
            box-shadow: 0 15px 30px rgba(99, 102, 241, 0.3);
        }

        .role-card .role-content {
            position: relative;
            z-index: 2;
        }

        .role-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            filter: drop-shadow(0 4px 8px rgba(0, 0, 0, 0.2));
        }

        .role-title {
            font-weight: 800;
            font-size: 1.125rem;
            margin-bottom: 0.5rem;
            color: var(--gray-800);
        }

        .role-description {
            font-size: 0.875rem;
            color: var(--gray-600);
            font-weight: 500;
        }

        /* Form Elements */
        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 700;
            color: var(--gray-700);
            margin-bottom: 0.75rem;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            border: 2px solid rgba(99, 102, 241, 0.1);
            border-radius: 1rem;
            padding: 1rem 1.25rem;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(99, 102, 241, 0.25);
            background: rgba(255, 255, 255, 0.95);
            transform: translateY(-2px);
        }

        .form-control::placeholder {
            color: var(--gray-400);
            font-weight: 400;
        }

        .input-group-text {
            background: rgba(99, 102, 241, 0.1);
            border: 2px solid rgba(99, 102, 241, 0.1);
            border-radius: 1rem 0 0 1rem;
            color: var(--primary);
            font-weight: 600;
        }

        /* Password Requirements */
        .password-requirements {
            list-style: none;
            padding: 0;
        }

        .password-requirements li {
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .password-requirements li.requirement.text-success {
            color: var(--success) !important;
        }

        .password-requirements li.requirement.text-muted {
            color: var(--gray-500) !important;
        }

        .progress {
            height: 8px;
            border-radius: 50px;
            background: rgba(99, 102, 241, 0.1);
            overflow: hidden;
        }

        .progress-bar {
            border-radius: 50px;
            transition: width 0.6s ease;
        }

        /* Register Button */
        .btn-register {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border: none;
            border-radius: 1rem;
            padding: 1rem 2rem;
            font-size: 1.125rem;
            font-weight: 700;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
            width: 100%;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.3);
        }

        .btn-register::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-register:hover::before {
            left: 100%;
        }

        .btn-register:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.4);
        }

        .btn-register:active {
            transform: translateY(-2px) scale(1.01);
        }

        /* Alerts */
        .alert {
            border: none;
            border-radius: 1rem;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
            backdrop-filter: blur(10px);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        /* Links */
        .register-links {
            text-align: center;
            margin-top: 2rem;
        }

        .register-links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
        }

        .register-links a::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.3s ease;
        }

        .register-links a:hover::after {
            width: 100%;
        }

        .register-links a:hover {
            color: var(--secondary);
            transform: translateY(-2px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .register-card {
                padding: 2rem;
                margin: 1rem;
            }
            
            .register-title {
                font-size: 2rem;
            }
        }

        /* Animation Classes */
        .fade-in {
            animation: fadeInUp 0.8s ease-out;
        }

        @keyframes fadeInUp {
            from { 
                opacity: 0;
                transform: translateY(60px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <!-- Floating Elements -->
    <div class="floating-elements">
        <div class="floating-circle circle-1"></div>
        <div class="floating-circle circle-2"></div>
        <div class="floating-circle circle-3"></div>
        <div class="floating-triangle triangle-1"></div>
        <div class="floating-triangle triangle-2"></div>
        <div class="floating-square square-1"></div>
        <div class="floating-square square-2"></div>
    </div>

    <div class="register-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="register-card fade-in">
                        <div class="card-content">
                            <div class="register-header">
                                <h1 class="register-title">
                                    <i class="fas fa-user-plus"></i> Create Account
                                </h1>
                                <p class="register-subtitle">Join our land sales platform</p>
                            </div>

                            <!-- Display Messages -->
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success alert-dismissible fade show">
                                    <i class="fas fa-check-circle"></i> ${successMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger alert-dismissible fade show">
                                    <i class="fas fa-exclamation-triangle"></i> ${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="/register" method="post" id="registerForm">
                                <!-- Role Selection -->
                                <div class="form-group">
                                    <label class="form-label">Select Your Role</label>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="role-card" data-role="ADMIN">
                                                <div class="role-content">
                                                    <div class="role-icon text-danger">
                                                        <i class="fas fa-user-shield"></i>
                                                    </div>
                                                    <h6 class="role-title">Admin</h6>
                                                    <small class="role-description">Manage entire system</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="role-card" data-role="BUYER">
                                                <div class="role-content">
                                                    <div class="role-icon text-success">
                                                        <i class="fas fa-user"></i>
                                                    </div>
                                                    <h6 class="role-title">Buyer</h6>
                                                    <small class="role-description">Purchase land properties</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="role-card" data-role="SELLER">
                                                <div class="role-content">
                                                    <div class="role-icon text-warning">
                                                        <i class="fas fa-user-tie"></i>
                                                    </div>
                                                    <h6 class="role-title">Seller</h6>
                                                    <small class="role-description">Sell land properties</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="role-card" data-role="STAFF">
                                                <div class="role-content">
                                                    <div class="role-icon text-info">
                                                        <i class="fas fa-users"></i>
                                                    </div>
                                                    <h6 class="role-title">Staff</h6>
                                                    <small class="role-description">Support and assistance</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" id="selectedRole" name="role" required>
                                    <div class="invalid-feedback" id="roleError">
                                        Please select a role.
                                    </div>
                                </div>

                                <!-- Role Passcode Field (for Admin/Staff only) -->
                                <div class="form-group" id="passcodeSection" style="display:none;">
                                    <label for="passcode" class="form-label">Role Passcode</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-key"></i></span>
                                        <input type="password" class="form-control" id="passcode" name="passcode" placeholder="Enter role passcode">
                                    </div>
                                </div>

                                <!-- User Information -->
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label for="name" class="form-label">Full Name</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-user"></i>
                                            </span>
                                            <input type="text" class="form-control" id="name" name="name" 
                                                   placeholder="Enter your full name" required>
                                        </div>
                                    </div>

                                    <div class="col-md-12 mb-3">
                                        <label for="email" class="form-label">Email Address</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-envelope"></i>
                                            </span>
                                            <input type="email" class="form-control" id="email" name="email" 
                                                   placeholder="Enter your email address" required>
                                        </div>
                                    </div>

                                    <div class="col-md-12 mb-4">
                                        <label for="password" class="form-label">Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="fas fa-lock"></i>
                                            </span>
                                            <input type="password" class="form-control" id="password" name="password" 
                                                   placeholder="Demo: MyPass@123" required minlength="8">
                                            <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="mt-2">
                                            <small class="text-muted d-block">
                                                <strong>Password must contain:</strong>
                                            </small>
                                            <ul class="password-requirements small text-muted mt-1 mb-0">
                                                <li id="length-req" class="requirement">
                                                    <i class="fas fa-times text-danger"></i> At least 8 characters
                                                </li>
                                                <li id="uppercase-req" class="requirement">
                                                    <i class="fas fa-times text-danger"></i> One uppercase letter (A-Z)
                                                </li>
                                                <li id="lowercase-req" class="requirement">
                                                    <i class="fas fa-times text-danger"></i> One lowercase letter (a-z)
                                                </li>
                                                <li id="number-req" class="requirement">
                                                    <i class="fas fa-times text-danger"></i> One number (0-9)
                                                </li>
                                                <li id="special-req" class="requirement">
                                                    <i class="fas fa-times text-danger"></i> One special character (@#$%^&*!)
                                                </li>
                                            </ul>
                                            <div class="progress mt-2" style="height: 6px;">
                                                <div class="progress-bar" id="passwordStrength" style="width: 0%"></div>
                                            </div>
                                            <small id="strengthText" class="text-muted">Password strength: Weak</small>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn-register">
                                        <i class="fas fa-user-plus"></i> Create Account
                                    </button>
                                </div>
                            </form>

                            <div class="register-links">
                                <p class="text-muted">
                                    Already have an account? 
                                    <a href="/login" class="text-primary fw-bold">Login here</a>
                                </p>
                                <a href="/" class="text-secondary">
                                    <i class="fas fa-arrow-left"></i> Back to Home
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Role selection functionality
        document.querySelectorAll('.role-card').forEach(card => {
            card.addEventListener('click', function() {
                // Remove selected class from all cards
                document.querySelectorAll('.role-card').forEach(c => c.classList.remove('selected'));
                
                // Add selected class to clicked card
                this.classList.add('selected');
                
                // Set hidden input value
        const selectedRole = this.dataset.role;
        document.getElementById('selectedRole').value = selectedRole;
        
        // Show passcode field only for Admin/Staff
        const passcodeSection = document.getElementById('passcodeSection');
        if (selectedRole === 'ADMIN' || selectedRole === 'STAFF') {
            passcodeSection.style.display = 'block';
        } else {
            passcodeSection.style.display = 'none';
        }
                
                // Hide error message
                document.getElementById('roleError').style.display = 'none';
            });
        });

        // Password visibility toggle
        document.getElementById('togglePassword').addEventListener('click', function() {
            const password = document.getElementById('password');
            const icon = this.querySelector('i');
            
            if (password.type === 'password') {
                password.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                password.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });

        // Password strength validation
        const passwordInput = document.getElementById('password');
        const strengthBar = document.getElementById('passwordStrength');
        const strengthText = document.getElementById('strengthText');

        passwordInput.addEventListener('input', function() {
            const password = this.value;
            validatePassword(password);
        });

        function validatePassword(password) {
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[@#$%^&*!]/.test(password)
            };

            // Update requirement indicators
            updateRequirement('length-req', requirements.length);
            updateRequirement('uppercase-req', requirements.uppercase);
            updateRequirement('lowercase-req', requirements.lowercase);
            updateRequirement('number-req', requirements.number);
            updateRequirement('special-req', requirements.special);

            // Calculate strength
            const metRequirements = Object.values(requirements).filter(Boolean).length;
            const strength = (metRequirements / 5) * 100;

            // Update progress bar
            strengthBar.style.width = strength + '%';
            
            if (strength < 40) {
                strengthBar.className = 'progress-bar bg-danger';
                strengthText.textContent = 'Password strength: Weak';
                strengthText.className = 'text-danger';
            } else if (strength < 80) {
                strengthBar.className = 'progress-bar bg-warning';
                strengthText.textContent = 'Password strength: Medium';
                strengthText.className = 'text-warning';
            } else {
                strengthBar.className = 'progress-bar bg-success';
                strengthText.textContent = 'Password strength: Strong';
                strengthText.className = 'text-success';
            }

            return metRequirements === 5;
        }

        function updateRequirement(elementId, met) {
            const element = document.getElementById(elementId);
            const icon = element.querySelector('i');
            
            if (met) {
                icon.className = 'fas fa-check text-success';
                element.className = 'requirement text-success';
            } else {
                icon.className = 'fas fa-times text-danger';
                element.className = 'requirement text-muted';
            }
        }

        // Form validation with password strength
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const selectedRole = document.getElementById('selectedRole').value;
            const password = document.getElementById('password').value;
            
            if (!selectedRole) {
                e.preventDefault();
                document.getElementById('roleError').style.display = 'block';
                return false;
            }

            if (!validatePassword(password)) {
                e.preventDefault();
                alert('Please ensure your password meets all requirements');
                return false;
            }
        });
    </script>
</body>
</html>

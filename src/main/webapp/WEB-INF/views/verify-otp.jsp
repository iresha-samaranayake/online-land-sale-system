<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Verification - Online Land Sales System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --success-gradient: linear-gradient(135deg, #4ade80 0%, #22c55e 100%);
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.8);
            --shadow-glow: 0 0 30px rgba(102, 126, 234, 0.3);
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
                radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.2) 0%, transparent 50%);
            z-index: -1;
            animation: backgroundShift 20s ease-in-out infinite;
        }

        @keyframes backgroundShift {
            0%, 100% { transform: translateX(0) translateY(0); }
            25% { transform: translateX(-20px) translateY(-10px); }
            50% { transform: translateX(20px) translateY(10px); }
            75% { transform: translateX(-10px) translateY(20px); }
        }

        .otp-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            z-index: 1;
        }

        .otp-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            box-shadow: var(--shadow-glow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .otp-card::before {
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

        .otp-content {
            position: relative;
            z-index: 2;
        }

        .otp-icon {
            width: 120px;
            height: 120px;
            background: var(--accent-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            color: var(--text-primary);
            margin: 0 auto 2rem;
            box-shadow: 0 10px 30px rgba(79, 172, 254, 0.4);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .otp-title {
            color: var(--text-primary);
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 1rem;
            text-align: center;
        }

        .otp-subtitle {
            color: var(--text-secondary);
            text-align: center;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .otp-input-container {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .otp-input {
            width: 60px;
            height: 60px;
            text-align: center;
            font-size: 1.8rem;
            font-weight: 700;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: var(--text-primary);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .otp-input:focus {
            outline: none;
            border-color: rgba(79, 172, 254, 0.5);
            box-shadow: 0 0 20px rgba(79, 172, 254, 0.3);
            background: rgba(255, 255, 255, 0.15);
            transform: scale(1.05);
        }

        .otp-input.filled {
            background: rgba(79, 172, 254, 0.2);
            border-color: rgba(79, 172, 254, 0.5);
            box-shadow: 0 0 15px rgba(79, 172, 254, 0.3);
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

        .btn-primary-modern:disabled {
            background: rgba(79, 172, 254, 0.3);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-outline-modern {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .btn-outline-modern:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
            color: var(--text-primary);
        }

        .alert-modern {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            color: var(--text-primary);
            margin-bottom: 2rem;
        }

        .alert-success-modern {
            border-left: 4px solid #4ade80;
        }

        .alert-danger-modern {
            border-left: 4px solid #f87171;
        }

        .timer-container {
            text-align: center;
            margin: 2rem 0;
        }

        .timer {
            color: var(--text-primary);
            font-weight: 700;
            font-size: 1.2rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            display: inline-block;
        }

        .timer.warning {
            color: #ffa726;
            animation: pulse 1s infinite;
        }

        .timer.danger {
            color: #f87171;
            animation: pulse 0.5s infinite;
        }

        .back-link {
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .back-link:hover {
            color: var(--text-primary);
            transform: translateX(-5px);
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
            background: rgba(255, 255, 255, 0.1);
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
            .otp-input {
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
            }
            
            .otp-input-container {
                gap: 0.5rem;
            }
            
            .otp-title {
                font-size: 1.5rem;
            }
            
            .otp-icon {
                width: 100px;
                height: 100px;
                font-size: 3rem;
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

    <div class="otp-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-8">
                    <div class="otp-card p-5">
                        <div class="otp-content">
                            <div class="text-center mb-4">
                                <div class="otp-icon">
                                    <i class="fas fa-envelope-open"></i>
                                </div>
                                <h2 class="otp-title">Verify Your Email</h2>
                                <p class="otp-subtitle">
                                    We've sent a 6-digit verification code to<br>
                                    <strong style="color: var(--text-primary);">${userEmail}</strong>
                                </p>
                            </div>

                            <!-- Display Messages -->
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-modern alert-success-modern alert-dismissible fade show">
                                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-modern alert-danger-modern alert-dismissible fade show">
                                    <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="/verify-otp" method="post" id="otpForm">
                                <div class="mb-4">
                                    <label class="form-label fw-bold text-center w-100" style="color: var(--text-primary); margin-bottom: 1rem;">
                                        <i class="fas fa-key me-2"></i>Enter 6-digit verification code
                                    </label>
                                    <div class="otp-input-container">
                                        <input type="text" class="otp-input" maxlength="1" id="otp1">
                                        <input type="text" class="otp-input" maxlength="1" id="otp2">
                                        <input type="text" class="otp-input" maxlength="1" id="otp3">
                                        <input type="text" class="otp-input" maxlength="1" id="otp4">
                                        <input type="text" class="otp-input" maxlength="1" id="otp5">
                                        <input type="text" class="otp-input" maxlength="1" id="otp6">
                                    </div>
                                    <input type="hidden" id="otpValue" name="otp">
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn-modern btn-primary-modern btn-lg" id="verifyBtn" disabled>
                                        <i class="fas fa-check-circle me-2"></i>Verify & Complete Registration
                                    </button>
                                </div>
                            </form>

                            <div class="text-center mt-4">
                                <p style="color: var(--text-secondary); margin-bottom: 1rem;">
                                    <i class="fas fa-question-circle me-1"></i>Didn't receive the code?
                                </p>
                                <form action="/resend-otp" method="post" class="d-inline">
                                    <button type="submit" class="btn-modern btn-outline-modern">
                                        <i class="fas fa-redo me-2"></i>Resend Code
                                    </button>
                                </form>
                            </div>

                            <div class="timer-container">
                                <small style="color: var(--text-secondary);">
                                    <i class="fas fa-clock me-1"></i>Code expires in <span id="timer" class="timer">5:00</span>
                                </small>
                            </div>

                            <div class="text-center mt-3">
                                <a href="/register" class="back-link">
                                    <i class="fas fa-arrow-left"></i>Back to Registration
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
        // OTP Input handling
        const otpInputs = document.querySelectorAll('.otp-input');
        const otpValue = document.getElementById('otpValue');
        const verifyBtn = document.getElementById('verifyBtn');

        otpInputs.forEach((input, index) => {
            input.addEventListener('input', function(e) {
                if (e.target.value.length === 1) {
                    if (index < otpInputs.length - 1) {
                        otpInputs[index + 1].focus();
                    }
                }
                updateOTPValue();
            });

            input.addEventListener('keydown', function(e) {
                if (e.key === 'Backspace' && e.target.value === '' && index > 0) {
                    otpInputs[index - 1].focus();
                }
            });

            input.addEventListener('paste', function(e) {
                e.preventDefault();
                const pastedData = e.clipboardData.getData('text');
                if (pastedData.match(/^\d{6}$/)) {
                    for (let i = 0; i < 6; i++) {
                        otpInputs[i].value = pastedData[i];
                        otpInputs[i].classList.add('filled');
                    }
                    updateOTPValue();
                }
            });

            input.addEventListener('input', function(e) {
                if (e.target.value) {
                    e.target.classList.add('filled');
                } else {
                    e.target.classList.remove('filled');
                }
            });
        });

        function updateOTPValue() {
            const otp = Array.from(otpInputs).map(input => input.value).join('');
            otpValue.value = otp;
            verifyBtn.disabled = otp.length !== 6;
        }

        // Timer functionality - exactly 5 minutes (300 seconds)
        let timeLeft = 300;
        const timerElement = document.getElementById('timer');
        let timerInterval;

        function updateTimer() {
            const minutes = Math.floor(timeLeft / 60);
            const seconds = timeLeft % 60;
            timerElement.textContent = `${minutes}:${seconds.toString().padStart(2, '0')}`;
            
            // Change color when time is running out
            if (timeLeft <= 60) {
                timerElement.className = 'timer warning';
            }
            if (timeLeft <= 30) {
                timerElement.className = 'timer danger';
            }
            
            if (timeLeft <= 0) {
                clearInterval(timerInterval);
                timerElement.textContent = 'EXPIRED';
                timerElement.className = 'timer danger';
                
                // Disable all inputs and buttons
                verifyBtn.disabled = true;
                verifyBtn.innerHTML = '<i class="fas fa-times-circle me-2"></i>OTP Expired';
                verifyBtn.className = 'btn-modern btn-primary-modern btn-lg';
                
                otpInputs.forEach(input => {
                    input.disabled = true;
                    input.style.background = 'rgba(255, 255, 255, 0.05)';
                    input.style.borderColor = 'rgba(255, 255, 255, 0.1)';
                });
                
                // Show expiry message
                const expiredAlert = document.createElement('div');
                expiredAlert.className = 'alert alert-modern alert-danger-modern mt-3';
                expiredAlert.innerHTML = '<i class="fas fa-clock me-2"></i>Your OTP has expired. Please go back and register again.';
                document.querySelector('.otp-content').appendChild(expiredAlert);
                
            } else {
                timeLeft--;
            }
        }

        // Start timer immediately
        timerInterval = setInterval(updateTimer, 1000);
        updateTimer(); // Call immediately to show initial time

        // Form submission with additional validation
        document.getElementById('otpForm').addEventListener('submit', function(e) {
            if (timeLeft <= 0) {
                e.preventDefault();
                alert('OTP has expired. Please register again.');
                return false;
            }
            
            const otp = otpValue.value;
            if (otp.length !== 6) {
                e.preventDefault();
                alert('Please enter complete 6-digit OTP');
                return false;
            }
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                if (alert.classList.contains('show')) {
                    alert.classList.remove('show');
                    alert.classList.add('fade');
                }
            });
        }, 5000);
    </script>
</body>
</html>
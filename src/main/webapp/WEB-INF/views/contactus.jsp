<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --accent-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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

        .hero-section {
            background: var(--primary-gradient);
            color: var(--text-primary);
            padding: 120px 0 80px 0;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
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

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            background: var(--accent-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: var(--text-secondary);
            line-height: 1.6;
        }

        .glass-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            box-shadow: var(--shadow-glow);
            transition: all 0.3s ease;
        }

        .glass-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.4);
        }

        .contact-form {
            padding: 2.5rem;
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
            border-color: rgba(79, 172, 254, 0.5);
            box-shadow: 0 0 20px rgba(79, 172, 254, 0.3);
            background: rgba(255, 255, 255, 0.15);
        }

        .form-control-modern::placeholder {
            color: rgba(255, 255, 255, 0.5);
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

        .form-control-modern:focus + .input-icon {
            color: rgba(79, 172, 254, 0.8);
            transform: translateY(-50%) scale(1.1);
        }

        .contact-info {
            padding: 2.5rem;
            background: var(--secondary-gradient);
            border-radius: 20px;
            position: relative;
            overflow: hidden;
        }

        .contact-info::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shimmer 3s infinite;
        }

        .contact-info-content {
            position: relative;
            z-index: 2;
        }

        .contact-item {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .contact-item:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateX(10px);
        }

        .contact-item i {
            font-size: 2rem;
            margin-right: 1rem;
            color: var(--text-primary);
        }

        .contact-item h5 {
            color: var(--text-primary);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .contact-item p {
            color: var(--text-secondary);
            margin: 0;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .social-link {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-primary);
            text-decoration: none;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .social-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-5px) scale(1.1);
            color: var(--text-primary);
        }

        .faq-section {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 3rem;
            margin: 3rem 0;
        }

        .faq-title {
            color: var(--text-primary);
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
        }

        .accordion-modern {
            background: transparent;
        }

        .accordion-item-modern {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 15px;
            margin-bottom: 1rem;
            backdrop-filter: blur(10px);
        }

        .accordion-button-modern {
            background: transparent;
            color: var(--text-primary);
            font-weight: 600;
            border: none;
            padding: 1.5rem;
            border-radius: 15px;
            transition: all 0.3s ease;
        }

        .accordion-button-modern:not(.collapsed) {
            background: rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }

        .accordion-button-modern:focus {
            box-shadow: 0 0 20px rgba(79, 172, 254, 0.3);
        }

        .accordion-body-modern {
            color: var(--text-secondary);
            padding: 1.5rem;
            line-height: 1.6;
        }

        .footer-modern {
            background: rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(20px);
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2rem 0;
            margin-top: 3rem;
        }

        .footer-modern h5 {
            color: var(--text-primary);
            font-weight: 700;
        }

        .footer-modern p {
            color: var(--text-secondary);
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
            .hero-title {
                font-size: 2.5rem;
            }
            
            .contact-form,
            .contact-info {
                padding: 1.5rem;
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

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="/">
                <i class="fas fa-globe-americas me-2"></i>LandSales Portal
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="/">
                        <i class="fas fa-home me-1"></i>Home
                    </a>
                    <a class="nav-link" href="/lands">
                        <i class="fas fa-search me-1"></i>Browse Lands
                    </a>
                    <a class="nav-link" href="/dashboard">
                        <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                    </a>
                    <a class="nav-link active" href="/contactus">
                        <i class="fas fa-envelope me-1"></i>Contact Us
                    </a>
                    <a href="/login" class="btn-modern btn-outline-modern me-2">
                        <i class="fas fa-sign-in-alt me-1"></i>Login
                    </a>
                    <a href="/register" class="btn-modern btn-primary-modern">
                        <i class="fas fa-user-plus me-1"></i>Register
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8 mx-auto text-center hero-content">
                    <h1 class="hero-title">Contact Us</h1>
                    <p class="hero-subtitle">Get in touch with our team for any questions or assistance regarding land sales and property management.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="py-5">
        <div class="container">
            <div class="row g-5">
                <!-- Contact Form -->
                <div class="col-lg-8">
                    <div class="glass-card contact-form">
                        <h3 class="mb-4" style="color: var(--text-primary); font-weight: 700;">
                            <i class="fas fa-paper-plane me-2"></i>Send us a Message
                        </h3>
                        <form>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="firstName" class="form-label">First Name</label>
                                        <input type="text" class="form-control-modern" id="firstName" placeholder="Enter your first name" required>
                                        <i class="fas fa-user input-icon"></i>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <input type="text" class="form-control-modern" id="lastName" placeholder="Enter your last name" required>
                                        <i class="fas fa-user input-icon"></i>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email" class="form-label">Email Address</label>
                                        <input type="email" class="form-control-modern" id="email" placeholder="Enter your email" required>
                                        <i class="fas fa-envelope input-icon"></i>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="phone" class="form-label">Phone Number</label>
                                        <input type="tel" class="form-control-modern" id="phone" placeholder="Enter your phone number">
                                        <i class="fas fa-phone input-icon"></i>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <label for="subject" class="form-label">Subject</label>
                                        <select class="form-control-modern" id="subject" required>
                                            <option value="">Choose a subject</option>
                                            <option value="general">General Inquiry</option>
                                            <option value="land-sale">Land Sale Information</option>
                                            <option value="technical">Technical Support</option>
                                            <option value="billing">Billing Question</option>
                                            <option value="other">Other</option>
                                        </select>
                                        <i class="fas fa-tag input-icon"></i>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <label for="message" class="form-label">Message</label>
                                        <textarea class="form-control-modern" id="message" rows="5" placeholder="Please describe your inquiry in detail..." required></textarea>
                                        <i class="fas fa-comment input-icon"></i>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <button type="submit" class="btn-modern btn-primary-modern btn-lg">
                                        <i class="fas fa-paper-plane me-2"></i>Send Message
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="col-lg-4">
                    <div class="contact-info">
                        <div class="contact-info-content">
                            <h3 class="mb-4">
                                <i class="fas fa-address-book me-2"></i>Get in Touch
                            </h3>
                            
                            <div class="contact-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <div>
                                    <h5>Office Address</h5>
                                    <p>123 Land Sales Street<br>Property District, City 12345</p>
                                </div>
                            </div>

                            <div class="contact-item">
                                <i class="fas fa-phone"></i>
                                <div>
                                    <h5>Phone Numbers</h5>
                                    <p>+1 (555) 123-4567<br>+1 (555) 987-6543</p>
                                </div>
                            </div>

                            <div class="contact-item">
                                <i class="fas fa-envelope"></i>
                                <div>
                                    <h5>Email Address</h5>
                                    <p>info@landsalesportal.com<br>support@landsalesportal.com</p>
                                </div>
                            </div>

                            <div class="contact-item">
                                <i class="fas fa-clock"></i>
                                <div>
                                    <h5>Business Hours</h5>
                                    <p>Monday - Friday: 9:00 AM - 6:00 PM<br>Saturday: 10:00 AM - 4:00 PM<br>Sunday: Closed</p>
                                </div>
                            </div>

                            <div class="mt-4">
                                <h5 class="mb-3" style="color: var(--text-primary);">Follow Us</h5>
                                <div class="social-links">
                                    <a href="#" class="social-link">
                                        <i class="fab fa-facebook"></i>
                                    </a>
                                    <a href="#" class="social-link">
                                        <i class="fab fa-twitter"></i>
                                    </a>
                                    <a href="#" class="social-link">
                                        <i class="fab fa-linkedin"></i>
                                    </a>
                                    <a href="#" class="social-link">
                                        <i class="fab fa-instagram"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="faq-section">
                        <h3 class="faq-title">
                            <i class="fas fa-question-circle me-2"></i>Frequently Asked Questions
                        </h3>
                        
                        <div class="accordion accordion-modern" id="faqAccordion">
                            <div class="accordion-item accordion-item-modern">
                                <h2 class="accordion-header" id="faq1">
                                    <button class="accordion-button accordion-button-modern" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1">
                                        <i class="fas fa-home me-2"></i>How do I list my land for sale?
                                    </button>
                                </h2>
                                <div id="collapse1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body accordion-body-modern">
                                        To list your land for sale, you need to create an account and register as a seller. Once registered, you can access the "Manage Lands" section from your dashboard to add new property listings with detailed information and photos.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="accordion-item accordion-item-modern">
                                <h2 class="accordion-header" id="faq2">
                                    <button class="accordion-button accordion-button-modern collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2">
                                        <i class="fas fa-credit-card me-2"></i>What payment methods do you accept?
                                    </button>
                                </h2>
                                <div id="collapse2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body accordion-body-modern">
                                        We accept various payment methods including bank transfers, credit cards, and installment plans. All transactions are secured with advanced encryption to ensure your financial information is protected.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="accordion-item accordion-item-modern">
                                <h2 class="accordion-header" id="faq3">
                                    <button class="accordion-button accordion-button-modern collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3">
                                        <i class="fas fa-search me-2"></i>How can I verify a property before purchasing?
                                    </button>
                                </h2>
                                <div id="collapse3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body accordion-body-modern">
                                        All properties listed on our platform are thoroughly verified with proper documentation. You can also schedule a site visit through our platform, and our team can assist you in arranging property inspections with certified professionals.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="accordion-item accordion-item-modern">
                                <h2 class="accordion-header" id="faq4">
                                    <button class="accordion-button accordion-button-modern collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4">
                                        <i class="fas fa-headset me-2"></i>What support do you provide after purchase?
                                    </button>
                                </h2>
                                <div id="collapse4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                    <div class="accordion-body accordion-body-modern">
                                        We provide comprehensive post-purchase support including assistance with legal documentation, property transfer processes, and ongoing customer service. Our team is available to help with any questions or concerns you may have.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer-modern">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-globe-americas me-2"></i>LandSales Portal</h5>
                    <p>Your trusted partner in land acquisition and sales.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p>&copy; 2024 Online Land Sales System. All rights reserved.</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

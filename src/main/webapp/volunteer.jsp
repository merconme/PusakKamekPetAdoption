<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Volunteer</title>
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --white: #ffffff;
            --light-bg: #fdf2f4;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
            background-color: var(--light-bg);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: var(--brand-maroon);
            color: white;
        }

        .logo-text { 
            font-weight: bold; 
            line-height: 1.2; 
            font-size: 18px; 
        }
        
        .logo-text small { 
            font-weight: normal; 
            font-size: 12px; 
        }

        .navbar nav ul {
            display: flex;
            list-style: none;
            gap: 30px;
            margin: 0;
            padding: 0;
        }

        .navbar nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            padding: 8px 16px;
            border-radius: 20px;
            transition: 0.3s;
        }

        .nav-link-active {
            background-color: rgba(0, 0, 0, 0.2);
        }

        .user-profile-icon a {
            font-size: 24px;
            text-decoration: none;
            color: white;
            cursor: pointer;
        }

        .page-wrapper {
            padding: 60px 5%;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
        }

        h1 {
            color: var(--brand-maroon);
            font-size: 42px;
            margin-bottom: 20px;
            text-align: center;
        }

        .donation-card {
            background: white;
            padding: 40px;
            border-radius: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-align: center;
        }

        .donation-header {
            color: var(--brand-maroon);
            margin-bottom: 20px;
        }

        .process-section {
            margin-top: 50px;
        }

        .section-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .process-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 25px;
        }

        .process-card {
            background: white;
            padding: 30px 20px;
            border-radius: 30px;
            text-align: center;
            position: relative;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: 0.3s;
        }

        .process-card:hover {
            transform: translateY(-5px);
        }

        .process-number {
            background: var(--brand-maroon);
            color: white;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto 15px;
            font-weight: bold;
            font-size: 20px;
        }

        .process-card h4 {
            color: var(--brand-maroon);
            margin-bottom: 10px;
        }

        .process-card p {
            font-size: 14px;
            color: #666;
            line-height: 1.4;
        }

        .btn-main {
            display: inline-block;
            background-color: var(--brand-maroon);
            color: white;
            padding: 15px 35px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-main:hover {
            background-color: #5a0012;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .navbar nav { display: none; }
            h1 { font-size: 32px; }
        }
    </style>
</head>
<body>

    <header class="navbar">
        <div class="logo-text">
            PUSAK KAMEK<br>
            <small>Rescue - Rehome - Rebuild</small>
        </div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="stories.jsp">Stories</a></li>
                <li><a href="petbrowse.jsp">Pet</a></li>
                <li><a href="adopt.jsp">Adopt</a></li>
                <li><a href="foster-details.jsp">Foster</a></li>
                <li><a href="donation.jsp">Donate</a></li>
                <li><a href="volunteer.jsp" class="nav-link-active">Volunteer</a></li>
            </ul>
        </nav>
        <div class="user-profile-icon">
            <a href="profile.jsp">👤</a>
        </div>
    </header>

    <main class="page-wrapper">
        <div class="container">
            
            <h1>Join Our Team!</h1>

            <div class="donation-card" style="margin-bottom: 30px;">
                <h2 class="donation-header" style="font-size: 28px;">Why Volunteer with Pusak Kamek</h2>
                <p style="color: #444; font-size: 18px; line-height: 1.6; max-width: 900px; margin: 0 auto;">
                    Volunteering is the heart of our shelter. As a volunteer, you directly contribute to the 
                    <strong>happiness and rehabilitation</strong> of our animals. Your commitment ensures pets 
                    receive the care, socialization, and attention they need to find their forever homes.
                </p>
            </div>

            <div class="process-section">
                <h3 class="section-title" style="font-size: 24px; color: #333;">The 4-Step Volunteer Process</h3>
                <div class="process-grid">
                    
                    <div class="process-card">
                        <span class="process-number">1</span>
                        <h4>Apply Online</h4>
                        <p>Submit your basic info and availability through our portal.</p>
                    </div>

                    <div class="process-card">
                        <span class="process-number">2</span>
                        <h4>Orientation</h4>
                        <p>Attend a mandatory introductory session at our shelter.</p>
                    </div>

                    <div class="process-card">
                        <span class="process-number">3</span>
                        <h4>Training</h4>
                        <p>Receive hands-on training for your specific assigned role.</p>
                    </div>

                    <div class="process-card">
                        <span class="process-number">4</span>
                        <h4>Get Started!</h4>
                        <p>Begin your rewarding work with our rescued animals.</p>
                    </div>
                </div>

                <div style="text-align: center; margin-top: 40px;">
                    <a href="volunteer-details.jsp" class="btn-main">View Requirements & Roles</a>
                </div>
            </div>

        </div>
    </main>

    <footer class="bottom-bar"></footer>

</body>
</html>

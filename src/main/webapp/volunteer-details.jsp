<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Volunteer Details</title>
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --white: #ffffff;
            --light-peach: #fff5f6;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
            background-color: var(--light-peach);
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
            gap: 25px;
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
            max-width: 1100px;
            margin: 0 auto;
        }

        .requirements-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .info-card {
            background: white;
            padding: 40px;
            border-radius: 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        .info-card h2 {
            color: var(--brand-maroon);
            margin-top: 0;
            font-size: 28px;
            border-bottom: 2px solid #fce8eb;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .info-card ul {
            padding-left: 20px;
        }

        .info-card li {
            margin-bottom: 15px;
            line-height: 1.6;
            color: #444;
        }

        .cta-banner {
            background-color: var(--brand-maroon);
            color: white;
            padding: 50px;
            border-radius: 40px;
            text-align: center;
        }

        .cta-banner h2 { font-size: 32px; margin-top: 0; }

        .btn-gold {
            display: inline-block;
            background: white;
            color: black;
            padding: 18px 40px;
            border-radius: 40px;
            text-decoration: none;
            font-weight: 800;
            margin-top: 20px;
            transition: 0.3s;
        }

        .btn-gold:hover {
            transform: scale(1.05);
            background-color: #f0f0f0;
        }

        @media (max-width: 850px) {
            .navbar nav { display: none; }
            .requirements-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

    <header class="navbar">
        <div class="logo-text">PUSAK KAMEK<br><small>Rescue - Rehome - Rebuild</small></div>
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
            
            <div class="requirements-grid">
                
                <div class="info-card">
                    <h2>Basic Requirements</h2>
                    <ul>
                        <li>Must be at least <strong>16 years old</strong> (or 18 for certain roles).</li>
                        <li>Commit to a <strong>minimum of 2 hours per week</strong> for 3 months.</li>
                        <li>Ability to follow instructions and safety protocols.</li>
                        <li>Comfortable with <strong>light physical activity</strong>.</li>
                        <li>Reliable transportation to and from the shelter.</li>
                    </ul>
                </div>

                <div class="info-card">
                    <h2>Types of Volunteer Roles</h2>
                    <ol style="color: #6a0016; padding-left: 20px; line-height: 1.8; font-weight: 500;">
                        <li><strong>Animal Socialization:</strong> Playing with cats and dogs to prepare them for adoption.</li>
                        <li><strong>Pets Walkers:</strong> Providing exercise and mental stimulation.</li>
                        <li><strong>Adoption Event Support:</strong> Handling animals and greeting the public.</li>
                        <li><strong>Kennel Assistants:</strong> Assisting staff with cleaning and feeding.</li>
                        <li><strong>Administrative Support:</strong> Help with data entry and records.</li>
                    </ol>
                </div>

            </div>

            <div class="cta-banner">
                <h2>Ready to Make a Difference?</h2>
                <p style="color: #fce8eb; font-size: 18px;">Your journey to helping animals starts here. Fill out the application and we'll be in touch!</p>
                <a href="volunteer-application.jsp" class="btn-gold">Start Your Volunteer Application Now</a>
            </div>

        </div>
    </main>

    <footer class="bottom-bar"></footer>
</body>
</html>

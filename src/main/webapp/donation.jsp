<%-- 
    Document   : donation
    Created on : 27 Jan 2026, 3:51:24 am
    Author     : USER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Donation Impact</title>
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --beige-bg: #FFF8DC;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
            background-color: var(--beige-bg);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: var(--brand-maroon);
            color: white;
        }

        .logo-text { font-weight: bold; line-height: 1.2; font-size: 18px; }
        .logo-text small { font-weight: normal; font-size: 12px; }

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

        .page-wrapper { padding: 60px 5%; }
        .container { max-width: 800px; margin: 0 auto; }

        h1 {
            color: var(--brand-maroon);
            font-size: 42px;
            margin-bottom: 30px;
            text-align: center;
        }

        .donation-card {
            background: white;
            padding: 40px;
            border-radius: 40px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .donation-header {
            color: var(--brand-maroon);
            margin-top: 0;
            border-bottom: 2px solid #fce8eb;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .donation-list { list-style: none; padding: 0; }

        .donation-list li {
            font-size: 18px;
            margin-bottom: 20px;
            padding-left: 35px;
            position: relative;
            color: #444;
        }

        .donation-list li::before {
            content: '❤️';
            position: absolute;
            left: 0;
            top: 2px;
        }

        @media (max-width: 768px) {
            .navbar nav { display: none; }
            h1 { font-size: 32px; }
            .donation-card { padding: 25px; }
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
            <li><a href="donation.jsp" class="nav-link-active">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>
    <div class="user-profile-icon">
        <a href="profile.jsp">👤</a>
    </div>
</header>

<main class="page-wrapper">
    <div class="container">
        <h1>How Your Donation Makes a Difference</h1>

        <div class="donation-card">
            <h2 class="donation-header">Where Your Donation Goes</h2>
            <ul class="donation-list">
                <li>Medical treatment for injured or sick animals</li>
                <li>Daily meals, treats and clean water</li>
                <li>Rescue missions for abandoned or abused pets</li>
                <li>Shelter maintenance and cleaning supplies</li>
            </ul>
        </div>
    </div>
</main>

</body>
</html>

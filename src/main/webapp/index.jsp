<%-- 
    Document   : index
    Created on : 27 Jan 2026
    Author     : USER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Home</title>
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --white: #ffffff;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
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
            gap: 20px;
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

        .auth-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-outline {
            color: white;
            text-decoration: none;
            border: 1px solid white;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-outline:hover {
            background-color: white;
            color: var(--brand-maroon);
        }

        .page-wrapper {
            background-color: var(--white);
            min-height: 80vh;
            padding: 60px 5%;
        }

        .hero-flex {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 50px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .hero-content h1 {
            font-size: 48px;
            color: var(--brand-maroon);
            margin-bottom: 20px;
        }

        .hero-content p {
            font-size: 18px;
            color: #444;
            max-width: 500px;
            margin-bottom: 30px;
        }

        .hero-actions {
            display: flex;
            gap: 20px;
        }

        .btn-main {
            padding: 15px 30px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn-view {
            background-color: var(--brand-maroon);
            color: white;
        }

        .btn-how {
            background-color: #f0f0f0;
            color: var(--brand-maroon);
        }

        .kitten-card img {
            width: 100%;
            max-width: 450px;
            border-radius: 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        @media (max-width: 900px) {
            .hero-flex {
                flex-direction: column;
                text-align: center;
            }
            .hero-actions {
                justify-content: center;
            }
            .navbar nav {
                display: none;
            }
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
            <li><a href="index.jsp" class="nav-link-active">Home</a></li>
            <li><a href="stories.jsp">Stories</a></li>
            <li><a href="petbrowse.jsp">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
            <li><a href="foster-details.jsp">Foster</a></li>
            <li><a href="donation.jsp">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>

    <div class="auth-buttons">
        <a href="login.jsp" class="btn-outline">Login</a>
        <a href="signup.jsp" class="btn-outline">Sign up</a>
    </div>
</header>

<main class="page-wrapper">
    <div class="container hero-flex">
        <div class="hero-content">
            <h1>Find Your New Best Friend</h1>
            <p>
                Adopt, don’t shop. Give a loving pet a second chance at life.
                Explore our available pets and begin your adoption today.
            </p>
            <div class="hero-actions">
                <a href="petbrowse.jsp" class="btn-main btn-view">View Pets</a>
                <a href="support.jsp" class="btn-main btn-how">How Adoption Works</a>
            </div>
        </div>

        <div class="kitten-card">
            <img src="https://images.unsplash.com/photo-1592194996308-7b43878e84a6?auto=format&fit=crop&q=80&w=800"
                 alt="Adoptable Kitten">
        </div>
    </div>
</main>

<footer class="bottom-bar"></footer>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Browse Pets</title>

    <link rel="stylesheet" href="style.css">

    <style>
        :root {
            --brand-maroon: #7a0019;
            --white: #ffffff;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: var(--brand-maroon);
            color: white;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
        }

        .page-wrapper {
            padding: 40px 5%;
        }

        .search-container {
            background: white;
            border-radius: 30px;
            padding: 10px 25px;
            display: flex;
            align-items: center;
            max-width: 600px;
            margin: 0 auto 30px;
        }

        .search-container input {
            border: none;
            outline: none;
            width: 100%;
            padding: 5px 10px;
            font-size: 16px;
        }

        .pet-category-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .pet-card {
            background: #fce8eb;
            border-radius: 20px;
            padding: 15px;
            text-align: center;
            transition: 0.3s;
        }

        .pet-card:hover {
            transform: translateY(-5px);
            background: #f8d0d6;
        }

        .pet-card-image img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 15px;
        }

        .pet-card h3 {
            color: var(--brand-maroon);
            margin-top: 10px;
            font-size: 20px;
        }

        @media (max-width: 768px) {
            .navbar nav {
                display: none;
            }
        }
    </style>
</head>

<body style="background-color:#7a0019; margin:0;">

<header class="navbar">
    <div class="logo-text">
        PUSAK KAMEK<br>
        <small>Rescue - Rehome - Rebuild</small>
    </div>

    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="stories.jsp">Stories</a></li>
            <li><a href="pet-browse.jsp" class="nav-link-active">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
            <li><a href="foster.jsp">Foster</a></li>
            <li><a href="donation.jsp">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>

    <div class="user-profile-icon">
        <a href="profile.jsp">👤</a>
    </div>
</header>

<main class="page-wrapper">

    <div class="search-container">
        🔍
        <input type="text" placeholder="Search for a specific breed or pet...">
    </div>

    <h2 style="color:white; text-align:right; margin-bottom:20px; font-weight:normal;">
        we are looking for a home
    </h2>

    <div class="pet-category-grid">

        <a href="pet-list.jsp?type=cat" style="text-decoration:none;">
            <div class="pet-card">
                <div class="pet-card-image">
                    <img src="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=500" alt="Cat">
                </div>
                <h3>Cat</h3>
            </div>
        </a>

        <a href="pet-list.jsp?type=dog" style="text-decoration:none;">
            <div class="pet-card">
                <div class="pet-card-image">
                    <img src="https://images.unsplash.com/photo-1543466835-00a7907e9de1?q=80&w=500" alt="Dog">
                </div>
                <h3>Dog</h3>
            </div>
        </a>

        <a href="pet-list.jsp?type=rabbit" style="text-decoration:none;">
            <div class="pet-card">
                <div class="pet-card-image">
                    <img src="https://images.unsplash.com/photo-1518717758536-85ae29035b6d?q=80&w=500" alt="Rabbit">
                </div>
                <h3>Rabbit</h3>
            </div>
        </a>

        <a href="pet-list.jsp?type=hamster" style="text-decoration:none;">
            <div class="pet-card">
                <div class="pet-card-image">
                    <img src="https://images.unsplash.com/photo-1548767797-d8c844163c4c?q=80&w=500" alt="Hamster">
                </div>
                <h3>Hamster</h3>
            </div>
        </a>

    </div>

    <div style="text-align:center; margin-top:40px;">
        <a href="PetBrowseServlet"
           style="background:white; color:black; padding:15px 60px;
                  border-radius:40px; text-decoration:none; font-weight:800;">
            BROWSE MORE
        </a>
    </div>

</main>

<footer class="bottom-bar"></footer>

</body>
</html>

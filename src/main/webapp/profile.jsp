<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - My Profile</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --primary-maroon: #7a0019;
        }

        body {
            background-color: var(--primary-maroon);
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* --- Navbar --- */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: #7a0019;
            color: white;
        }

        .logo-text { font-weight: bold; line-height: 1.2; }
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
            padding: 8px 16px;
            border-radius: 20px;
        }

        .user-profile-icon a {
            font-size: 24px;
            color: white;
            text-decoration: none;
        }

        /* --- Profile Container --- */
        .profile-wrapper {
            background-color: white;
            margin: 20px auto;
            width: 95%;
            max-width: 1100px;
            border-radius: 50px;
            padding: 40px;
            min-height: 80vh;
            position: relative;
        }

        .top-nav-arrow {
            position: absolute;
            right: 40px;
            top: 40px;
            font-size: 20px;
            color: #333;
            border: 1px solid #ddd;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            text-decoration: none;
        }

        .user-info-card {
            display: flex;
            align-items: center;
            gap: 40px;
            padding: 30px;
            border-radius: 30px;
            border: 1px solid #eee;
            margin: 30px 0 50px;
        }

        .profile-pic-container img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
        }

        .edit-btn {
            background-color: var(--primary-maroon);
            color: white;
            padding: 10px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 20px;
            margin: 40px 0 20px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }

        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .pet-card {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 20px;
            text-align: center;
        }

        .pet-card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
        }

        .checkin-btn {
            display: inline-block;
            margin-top: 10px;
            background-color: var(--primary-maroon);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .user-info-card { flex-direction: column; text-align: center; }
            .navbar nav { display: none; }
        }
    </style>
</head>

<body>

<header class="navbar">
    <div class="logo-text">
        PUSAK KAMEK<br><small>Rescue - Rehome - Rebuild</small>
    </div>

    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="stories.jsp">Stories</a></li>
            <li><a href="pet-browse.jsp">Pet</a></li>
            <li><a href="adopt-history.jsp">Adopt</a></li>
            <li><a href="foster.jsp">Foster</a></li>
            <li><a href="donation.jsp">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>

    <div class="user-profile-icon">
        <a href="ProfileServlet">👤</a>
    </div>
</header>

<main>
    <div class="profile-wrapper">

        <a href="pet-browse.jsp" class="top-nav-arrow">
            <i class="fa-solid fa-arrow-right"></i>
        </a>

        <h2 style="font-size:32px;">My Profile</h2>

        <!-- USER INFO -->
        <div class="user-info-card">
            <div class="profile-pic-container">
                <img src="https://images.unsplash.com/photo-1503777119540-ce54b422baff?q=80&w=200">
            </div>

            <div class="user-details">
                <p><strong>Name:</strong> Ariana Lee</p>
                <p><strong>Phone:</strong> 012-3456789</p>
                <p><strong>Email:</strong> arianalee@gmail.com</p>
                <p><strong>Address:</strong> Kuching, Sarawak</p>
            </div>

            <div>
                <a href="edit-profile.jsp" class="edit-btn">Edit Profile</a>
            </div>
        </div>

        <!-- ADOPTED PETS -->
        <div class="section-title">
            <i class="fa-solid fa-house-chimney-window"></i>
            <strong>My Adopted Pets</strong>
        </div>

        <div class="grid-container">
            <div class="pet-card">
                <img src="https://images.unsplash.com/photo-1592194996308-7b43878e84a6?q=80&w=200">
                <h4>Smiski</h4>
                <p>British Short Hair</p>
                <a href="pet-checkin.jsp" class="checkin-btn">Pet Check-in</a>
            </div>
        </div>

        <!-- FAVOURITES -->
        <div class="section-title">
            <i class="fa-solid fa-bookmark"></i>
            <strong>Saved Favourite Pets</strong>
        </div>

        <div class="grid-container">
            <div class="pet-card">
                <img src="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=200">
                <h4>Tabby</h4>
                <p>British Short Hair</p>
            </div>

            <div class="pet-card">
                <img src="https://images.unsplash.com/photo-1583337130417-3346a1be7dee?q=80&w=200">
                <h4>Mochi</h4>
                <p>White Ragdoll</p>
            </div>
        </div>

    </div>
</main>

</body>
</html>

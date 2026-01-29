<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Rabbits</title>

    <link rel="stylesheet" href="style.css">

    <style>
        :root {
            --brand-maroon: #7a0019;
            --navbar-hover: rgba(0, 0, 0, 0.2);
        }

        body {
            background-color: var(--brand-maroon);
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Navbar */
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
            gap: 25px;
            margin: 0;
            padding: 0;
        }

        .navbar nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            padding: 8px 16px;
            border-radius: 20px;
        }

        .nav-link-active { background-color: var(--navbar-hover); }

        .user-profile-icon a {
            font-size: 24px;
            color: white;
            text-decoration: none;
        }

        /* Cards */
        .pet-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .gallery-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            cursor: pointer;
            transition: 0.3s;
            position: relative;
        }

        .gallery-card:hover { transform: translateY(-5px); }

        .gallery-card-image img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .gallery-card-content {
            padding: 15px;
            color: #333;
        }

        .fav-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255,255,255,0.9);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
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
            <li><a href="pet-browse.jsp" class="nav-link-active">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
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
    <div class="pet-grid">

        <!-- SAMPLE CARD -->
        <div class="gallery-card" data-name="snowball" data-breed="holland" data-gender="female">
            <div class="fav-btn">🤍</div>
            <div class="gallery-card-image">
                <img src="https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?q=80&w=500">
            </div>
            <div class="gallery-card-content">
                <p>Name: Snowball</p>
                <p>Age: Baby</p>
                <p>Gender: Female</p>
            </div>
        </div>

        <!-- You can later replace all cards with JSTL loop -->

    </div>
</main>

</body>
</html>

<%-- 
    Document   : hamsterpage
    Created on : 27 Jan 2026, 3:52:33 am
    Author     : USER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Hamsters</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* === SAME CSS AS YOUR ORIGINAL (UNCHANGED) === */
        :root {
            --brand-maroon: #7a0019;
            --navbar-hover: rgba(0, 0, 0, 0.2);
        }
        body {
            background-color: var(--brand-maroon);
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            transition: 0.3s;
        }
        .nav-link-active { background-color: var(--navbar-hover); }
        .user-profile-icon a {
            font-size: 24px;
            text-decoration: none;
            color: white;
        }
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
        .gallery-card img { width: 100%; height: 200px; object-fit: cover; }
    </style>
</head>
<body>

<header class="navbar">
    <div class="logo-text">PUSAK KAMEK<br><small>Rescue - Rehome - Rebuild</small></div>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="stories.jsp">Stories</a></li>
            <li><a href="petbrowse.jsp" class="nav-link-active">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
            <li><a href="foster-details.jsp">Foster</a></li>
            <li><a href="donation.jsp">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>
    <div class="user-profile-icon">
        <a href="profile.jsp">👤</a>
    </div>
</header>

<main class="page-wrapper">
    <div class="container">

        <!-- Pet Switcher -->
        <div class="pet-switcher">
            <a href="catpage.jsp" class="switch-btn">Cats</a>
            <a href="dogpage.jsp" class="switch-btn">Dogs</a>
            <a href="rabbitpage.jsp" class="switch-btn">Rabbits</a>
            <a href="hamsterpage.jsp" class="switch-btn active-pet">Hamsters</a>
        </div>

        <!-- Pet Grid -->
        <div class="pet-grid">

            <div class="gallery-card">
                <img src="https://images.unsplash.com/photo-1548767797-d8c844163c4c?q=80&w=500">
                <div class="gallery-card-content">
                    <p>Name: Cheeks</p>
                    <p>Age: Young</p>
                    <p>Gender: Female</p>
                </div>
            </div>

            <div class="gallery-card">
                <img src="https://images.unsplash.com/photo-1601612620453-93668784d16d?q=80&w=500">
                <div class="gallery-card-content">
                    <p>Name: Peanut</p>
                    <p>Age: Adult</p>
                    <p>Gender: Male</p>
                </div>
            </div>

        </div>
    </div>
</main>

<!-- Modal links updated -->
<a href="vaccine-record.jsp"></a>
<a href="pet-microchip.jsp"></a>
<a href="adopt-application.jsp"></a>
<a href="foster-form.jsp"></a>

</body>
</html>

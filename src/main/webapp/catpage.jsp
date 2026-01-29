<%-- 
    Document   : catpage
    Created on : 27 Jan 2026, 3:50:53 am
    Author     : USER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Cats</title>
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --soft-pink: #FFF0F1;
            --navbar-hover: rgba(0, 0, 0, 0.2);
        }

        body {
            background-color: var(--brand-maroon);
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* --- Standardized Navbar --- */
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

        /* --- Filter Bar Styles --- */
        .filter-section {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin: 20px 0 30px 0;
            flex-wrap: wrap;
        }
        .filter-input {
            padding: 12px 20px;
            border-radius: 25px;
            border: 2px solid white;
            outline: none;
            font-size: 14px;
            width: 250px;
        }
        .filter-select {
            padding: 10px 20px;
            border-radius: 25px;
            border: 2px solid white;
            background: white;
            cursor: pointer;
        }

        /* Favorite Button Styling */
        .fav-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 255, 255, 0.9);
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            z-index: 5;
            cursor: pointer;
            transition: 0.2s;
        }
        .fav-btn:hover { transform: scale(1.2); }

        /* Grid Styling */
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
        .gallery-card-image img { width: 100%; height: 200px; object-fit: cover; }
        .gallery-card-content { padding: 15px; color: #333; }

        /* --- Modal Styles --- */
        .modal-overlay { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.85); backdrop-filter: blur(8px); overflow-y: auto; }
        .modal-content { background-color: white; margin: 50px auto; width: 90%; max-width: 1000px; border-radius: 40px; padding: 20px; position: relative; animation: slideUp 0.4s ease-out; }
        @keyframes slideUp { from { transform: translateY(50px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        .close-btn { position: absolute; right: 30px; top: 20px; font-size: 40px; cursor: pointer; color: var(--brand-maroon); z-index: 10; }
        
        .profile-card { display: flex; gap: 30px; padding: 20px; }
        .image-section { flex: 1; }
        .image-section img { width: 100%; border-radius: 20px; object-fit: cover; height: 450px; }
        .details-section { flex: 1.2; background: #fdf0f1; padding: 25px; border-radius: 20px; color: #333; }
        
        .pill-container { display: flex; gap: 10px; margin: 15px 0; }
        .pill-link { border: 2px solid #d67a8b; color: #d67a8b; padding: 8px 15px; border-radius: 12px; font-weight: bold; font-size: 13px; text-decoration: none; transition: 0.3s; }
        .pill-link:hover { background: #d67a8b; color: white; }

        .info-box { background: white; padding: 15px; border-radius: 15px; margin-bottom: 15px; border-left: 8px solid var(--brand-maroon); }
        .action-buttons { display: flex; gap: 15px; margin-top: 20px; }
        .btn { flex: 1; padding: 12px; border-radius: 20px; text-align: center; text-decoration: none; font-weight: bold; cursor: pointer; border: none; }
        .btn-adopt { background: var(--brand-maroon); color: white; }
        .btn-foster { background: #d67a8b; color: white; }

        @media (max-width: 768px) {
            .profile-card { flex-direction: column; }
            .image-section img { height: 300px; }
            .action-buttons { flex-direction: column; }
            .navbar nav { display: none; }
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
                <li><a href="catpage.jsp" class="nav-link-active">Pet</a></li>
                <li><a href="adopt.jsp">Adopt</a></li>
                <li><a href="foster-details.jsp">Foster</a></li>
                <li><a href="donation.jsp">Donate</a></li>
                <li><a href="volunteer.jsp">Volunteer</a></li>
            </ul>
        </nav>
        <div class="user-profile-icon"><a href="profile.jsp">👤</a></div>
    </header>

    <main class="page-wrapper">
        <div class="container">
            <div class="pet-switcher">
                <a href="catpage.jsp" class="switch-btn active-pet">Cats</a>
                <a href="dogpage.jsp" class="switch-btn">Dogs</a>
                <a href="rabbitpage.jsp" class="switch-btn">Rabbits</a>
                <a href="hamsterpage.jsp" class="switch-btn">Hamsters</a>
            </div>

            <%-- Filter Section and Pet Grid remain unchanged for now, can be dynamically generated later using JSP loops if using a database --%>

        </div>
    </main>

    <%-- Modal and JS scripts remain unchanged --%>

</body>
</html>

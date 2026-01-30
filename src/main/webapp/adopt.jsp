<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.pusakkamek.model.User"%>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Adopt</title>
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --white: #ffffff;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--white);
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

        .profile-dropdown {
            position: relative;
            display: inline-block;
        }

        .profile-dropdown button {
            background: none;
            border: none;
            color: white;
            font-size: 24px;
            cursor: pointer;
        }

        .profile-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 150px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            border-radius: 10px;
            overflow: hidden;
            z-index: 1000;
        }

        .profile-dropdown-content a {
            color: var(--brand-maroon);
            padding: 12px 16px;
            display: block;
            text-decoration: none;
            font-weight: 500;
        }

        .profile-dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .profile-dropdown:hover .profile-dropdown-content {
            display: block;
        }

        /* Page content */
        .page-wrapper {
            padding: 60px 5%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .content-card {
            background: #fff5f6;
            border-radius: 30px;
            padding: 50px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .content-card h1 {
            color: var(--brand-maroon);
            font-size: 36px;
            margin-bottom: 20px;
        }

        .content-card p {
            font-size: 18px;
            color: #333;
            margin-bottom: 40px;
        }
    </style>
</head>

<body>

<!-- Navbar -->
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
            <li><a href="adopt.jsp" class="nav-link-active">Adopt</a></li>
            <li><a href="foster.jsp">Foster</a></li>
            <li><a href="donation.jsp">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>

    <div class="profile-dropdown">
        <button>👤</button>
        <div class="profile-dropdown-content">
            <a href="profile.jsp">Hi, <%= user.getName() %></a>
            <a href="update-profile.jsp">Update Account</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
</header>

<!-- Page Content -->
<main class="page-wrapper">
    <div class="content-card">
        <h1>Start Your Adoption Journey</h1>
        <p>
            Bringing a new family member home is a rewarding process.
            Browse available pets, submit an application, and complete the steps to adopt your perfect companion.
        </p>
        <a href="petbrowse.jsp" style="background: var(--brand-maroon); color:white; padding:15px 50px; border-radius:40px; text-decoration:none; font-weight: bold;">
            Browse Available Pets
        </a>
    </div>
</main>

</body>
</html>

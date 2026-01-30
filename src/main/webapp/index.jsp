<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pusakkamek.model.User" %>
<%
    // Get the current logged-in user from session (null if not logged in)
    User currentUser = (User) session.getAttribute("currentUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Home</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* existing CSS omitted for brevity */
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
        <% if (currentUser != null) { %>
            <!-- User is logged in -->
            <span style="color:white; margin-right:10px;">Hello, <%= currentUser.getName() %></span>
            <a href="LogoutServlet" class="btn-outline">Logout</a>
        <% } else { %>
            <!-- User is not logged in -->
            <a href="login.jsp" class="btn-outline">Login</a>
            <a href="register.jsp" class="btn-outline">Sign Up</a>
        <% } %>
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

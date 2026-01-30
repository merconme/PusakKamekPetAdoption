<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pusakkamek.dao.PetDAO" %>
<%@ page import="com.pusakkamek.model.Pet" %>
<%@ page import="com.pusakkamek.model.User" %>

<%
    // Check login
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    PetDAO petDAO = new PetDAO();
    String query = request.getParameter("search");
    List<Pet> pets;
    if (query != null && !query.isEmpty()) {
        pets = petDAO.searchPets(query);
    } else {
        pets = petDAO.getAllPets();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Pets - Pusak Kamek</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body { margin:0; font-family:'Segoe UI', sans-serif; background:#f7f7f7; }
        .navbar { display:flex; justify-content:space-between; align-items:center; padding:15px 5%; background:#7a0019; color:white; }
        .navbar nav ul { display:flex; list-style:none; gap:20px; margin:0; padding:0; }
        .navbar nav ul li a { color:white; text-decoration:none; padding:8px 16px; border-radius:20px; transition:0.3s; }
        .nav-link-active { background: rgba(0,0,0,0.2); }
        .user-profile-icon a { color:white; font-size:24px; text-decoration:none; }
        .page-wrapper { padding:40px 5%; }
        .search-container { display:flex; justify-content:center; margin-bottom:30px; }
        .search-container input { width:100%; max-width:500px; padding:10px 15px; font-size:16px; border-radius:30px; border:1px solid #ccc; outline:none; }
        .pet-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(220px,1fr)); gap:20px; }
        .pet-card { background:white; border-radius:20px; text-align:center; padding:15px; transition:0.3s; }
        .pet-card:hover { transform:translateY(-5px); box-shadow:0 10px 20px rgba(0,0,0,0.1); }
        .pet-card img { width:100%; height:160px; object-fit:cover; border-radius:15px; }
        .pet-card h3 { color:#7a0019; margin:10px 0 5px; }
        .pet-card p { margin:2px 0; color:#333; font-size:14px; }
    </style>
</head>
<body>

<header class="navbar">
    <div><strong>PUSAK KAMEK</strong><br><small>Rescue · Rehome · Rebuild</small></div>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="stories.jsp">Stories</a></li>
            <li><a href="petbrowse.jsp" class="nav-link-active">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
            <li><a href="profile.jsp">👤</a></li>
        </ul>
    </nav>
    <div class="user-profile-icon"><a href="profile.jsp">👤</a></div>
</header>

<main class="page-wrapper">
    <!-- Search -->
    <form class="search-container" method="get">
        <input type="text" name="search" placeholder="Search by name, species or breed..." value="<%= query != null ? query : "" %>">
    </form>

    <!-- Pet Grid -->
    <div class="pet-grid">
        <%
            for (Pet pet : pets) {
        %>
        <div class="pet-card">
            <img src="<%= pet.getImageUrl() %>" alt="<%= pet.getName() %>">
            <h3><%= pet.getName() %></h3>
            <p>Species: <%= pet.getSpecies() %></p>
            <p>Breed: <%= pet.getBreed() %></p>
            <p>Age: <%= pet.getAge() %> years</p>
            <p>Vaccinated: <%= pet.getVaccinationStatus() %></p>
        </div>
        <%
            }
        %>
    </div>
</main>

</body>
</html>

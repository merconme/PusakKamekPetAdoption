<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.pusakkamek.model.User" %>

<%
    User admin = (User) session.getAttribute("currentUser");
    if (admin == null || !"ADMIN".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | Pusak Kamek</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
:root {
    --brand: #7a0019;
    --brand-light: #96102b;
    --shadow: 0 10px 30px rgba(0,0,0,0.15);
}
body {
    margin:0;
    font-family: 'Poppins', sans-serif;
    background: radial-gradient(circle at top, var(--brand-light), var(--brand));
    color:white;
}

/* NAVBAR */
.navbar {
    position: fixed;
    top:0; left:0;
    width:100%;
    height:80px;
    background:white;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:0 5%;
    box-shadow: var(--shadow);
    z-index:1000;
}
.logo-section {
    display:flex;
    align-items:center;
    gap:12px;
    color:var(--brand);
}
.logo-circle {
    width:35px;
    height:35px;
    border-radius:50%;
    background:var(--brand);
    color:white;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:800;
}
.logo-text {
    font-weight:800;
    line-height:1.1;
    font-size:18px;
}

.nav-links {
    list-style:none;
    display:flex;
    gap:10px;
    margin:0;
    padding:0;
}
.nav-links a {
    text-decoration:none;
    color:#555;
    font-weight:600;
    padding:10px 18px;
    border-radius:10px;
}
.nav-links a:hover,
.nav-active {
    background:var(--brand);
    color:white;
}

/* PROFILE */
.profile-wrapper {
    position:relative;
}
.profile-btn {
    display:flex;
    align-items:center;
    gap:10px;
    cursor:pointer;
    color:var(--brand);
    font-weight:700;
}
.profile-icon {
    width:40px;
    height:40px;
    border-radius:50%;
    background:#eee;
    display:flex;
    align-items:center;
    justify-content:center;
}
.profile-menu {
    position:absolute;
    right:0;
    top:55px;
    background:white;
    color:#333;
    width:180px;
    border-radius:12px;
    box-shadow:var(--shadow);
    display:none;
    overflow:hidden;
}
.profile-menu a {
    display:block;
    padding:12px 15px;
    text-decoration:none;
    color:#555;
    font-weight:600;
}
.profile-menu a:hover {
    background:#f5f5f5;
}

/* CONTENT */
.container {
    max-width:1200px;
    margin:120px auto;
    padding:0 5%;
}
.cards {
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:25px;
}
.card {
    background:white;
    color:#333;
    padding:25px;
    border-radius:20px;
    box-shadow:var(--shadow);
    transition:.3s;
}
.card:hover {
    transform:translateY(-5px);
}
.card i {
    font-size:28px;
    color:var(--brand);
    margin-bottom:10px;
}
.card h3 {
    margin:10px 0 5px;
    color:var(--brand);
}
</style>
</head>

<body>

<!-- NAVBAR -->
<header class="navbar">
    <div class="logo-section">
        <div class="logo-circle">PK</div>
        <div class="logo-text">
            PUSAK KAMEK<br>
            <small style="font-size:10px;color:#777;">ADMIN PANEL</small>
        </div>
    </div>

    <ul class="nav-links">
        <li><a href="admin-index.jsp" class="nav-active">Dashboard</a></li>
        <li><a href="add-petbrowse.jsp">Pets</a></li>
        <li><a href="upload-stories.jsp">Stories</a></li>
        <li><a href="adopt-history.jsp">Adoptions</a></li>
    </ul>

    <!-- PROFILE -->
    <div class="profile-wrapper">
        <div class="profile-btn" onclick="toggleProfile()">
            <span><%= admin.getName() %></span>
            <div class="profile-icon"><i class="fa fa-user"></i></div>
        </div>
        <div class="profile-menu" id="profileMenu">
            <a href="admin-profile.jsp"><i class="fa fa-gear"></i> Update Profile</a>
            <a href="LogoutServlet" style="color:#b00020;">
                <i class="fa fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
</header>

<!-- CONTENT -->
<div class="container">
    <h1>Welcome back, <%= admin.getName() %> 👋</h1>
    <p style="opacity:.9">Manage pets, categories, stories and adoption requests.</p>

    <div class="cards">
        <div class="card">
            <i class="fa fa-paw"></i>
            <h3>Manage Pets</h3>
            <p>Add, edit or remove pets.</p>
        </div>
        <div class="card">
            <i class="fa fa-layer-group"></i>
            <h3>Categories</h3>
            <p>Manage pet species.</p>
        </div>
        <div class="card">
            <i class="fa fa-book-open"></i>
            <h3>Stories</h3>
            <p>Upload adoption stories.</p>
        </div>
        <div class="card">
            <i class="fa fa-heart"></i>
            <h3>Adoptions</h3>
            <p>Review adoption history.</p>
        </div>
    </div>
</div>

<script>
function toggleProfile() {
    const menu = document.getElementById("profileMenu");
    menu.style.display = menu.style.display === "block" ? "none" : "block";
}

window.onclick = function(e) {
    if (!e.target.closest(".profile-wrapper")) {
        document.getElementById("profileMenu").style.display = "none";
    }
};
</script>

</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pusakkamek.model.Admin"%>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile - Pusak Kamek</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        :root {
            --admin-dark-maroon: #4a0010;
            --admin-accent-maroon: #7a0019;
            --bg-light: #f4f7f6;
            --text-grey: #666;
            --shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--bg-light);
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .sidebar {
            width: 280px;
            background-color: var(--admin-dark-maroon);
            color: white;
            display: flex;
            flex-direction: column;
        }
        .sidebar-header {
            padding: 30px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .nav-menu { flex-grow: 1; padding: 20px 0; }
        .nav-item {
            padding: 12px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
        }
        .nav-item.active, .nav-item:hover {
            background-color: var(--admin-accent-maroon);
            color: white;
            border-left: 4px solid white;
        }
        .main-content {
            flex-grow: 1;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }
        .top-bar {
            background: white;
            padding: 15px 40px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .content-padding {
            padding: 40px;
            max-width: 800px;
        }
        .profile-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: var(--shadow);
        }
        .profile-header {
            display: flex;
            gap: 30px;
            border-bottom: 1px solid #eee;
            padding-bottom: 30px;
            margin-bottom: 30px;
        }
        .profile-img-container {
            width: 120px;
            height: 120px;
            position: relative;
        }
        .profile-img-container img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
        }
        .change-img-btn {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: var(--admin-accent-maroon);
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .form-group { display: flex; flex-direction: column; gap: 6px; }
        .form-group.full { grid-column: span 2; }
        label { font-size: 12px; font-weight: bold; color: var(--text-grey); }
        input {
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ddd;
        }
        .save-btn {
            background: var(--admin-accent-maroon);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }
        .save-btn:hover {
            background: var(--admin-dark-maroon);
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-header">
        <h3>PUSAK KAMEK</h3>
        <small>Pet Adoption</small>
    </div>

    <nav class="nav-menu">
        <a href="admin-index.jsp" class="nav-item">
            <i class="fa-solid fa-gauge"></i> Dashboard
        </a>
        <a href="admin-profile.jsp" class="nav-item active">
            <i class="fa-solid fa-user-gear"></i> My Profile
        </a>
    </nav>

    <div style="padding:20px;">
        <a href="LogoutServlet" class="nav-item" style="color:#ff8a8a;">
            <i class="fa-solid fa-power-off"></i> Logout
        </a>
    </div>
</aside>

<!-- MAIN -->
<main class="main-content">
    <div class="top-bar">
        <h2>Admin Profile</h2>
    </div>

    <div class="content-padding">
        <div class="profile-card">

            <div class="profile-header">
                <div class="profile-img-container">
                    <img src="<%= admin.getProfileImage() != null ? admin.getProfileImage() : "images/default-admin.png" %>">
                    <label for="img-upload" class="change-img-btn">
                        <i class="fa-solid fa-camera"></i>
                    </label>
                </div>
                <div>
                    <h2><%= admin.getFullName() %></h2>
                    <p>Manage your admin account</p>
                </div>
            </div>

            <!-- FORM -->
            <form action="AdminProfileServlet" method="post" enctype="multipart/form-data" class="form-grid">

                <input type="hidden" name="adminId" value="<%= admin.getId() %>">

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" value="<%= admin.getFullName() %>" required>
                </div>

                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" value="<%= admin.getUsername() %>" readonly>
                </div>

                <div class="form-group full">
                    <label>Email</label>
                    <input type="email" name="email" value="<%= admin.getEmail() %>" required>
                </div>

                <div class="form-group">
                    <label>New Password</label>
                    <input type="password" name="password">
                </div>

                <div class="form-group">
                    <label>Confirm Password</label>
                    <input type="password" name="confirmPassword">
                </div>

                <div class="form-group full">
                    <label>Profile Image</label>
                    <input type="file" name="profileImage" id="img-upload">
                </div>

                <div class="form-group full">
                    <button type="submit" class="save-btn">
                        Save Changes
                    </button>
                </div>

            </form>
        </div>
    </div>
</main>

</body>
</html>

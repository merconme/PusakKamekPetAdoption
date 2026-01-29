<%-- 
    Document   : edit.profile
    Created on : 27 Jan 2026, 3:51:40 am
    Author     : USER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Edit Profile</title>
   
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --light-grey: #f4f4f4;
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
            transition: 0.3s;
        }

        .nav-link-active {
            background-color: rgba(0, 0, 0, 0.2);
        }

        .user-profile-icon a {
            font-size: 24px;
            text-decoration: none;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .edit-wrapper {
            background-color: white;
            margin: 20px auto;
            width: 90%;
            max-width: 800px;
            border-radius: 50px;
            padding: 50px;
            min-height: 70vh;
        }

        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .edit-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .profile-upload-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }

        .profile-upload-section img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--brand-maroon);
        }

        .change-photo-btn {
            background-color: var(--light-grey);
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            cursor: pointer;
            border: 1px solid #ddd;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            font-weight: bold;
            color: #555;
            margin-left: 5px;
        }

        .form-group input {
            padding: 15px 20px;
            border-radius: 30px;
            border: 1px solid #ddd;
            background-color: var(--light-grey);
            font-size: 16px;
            outline: none;
            transition: 0.3s;
        }

        .form-group input:focus {
            border-color: var(--brand-maroon);
            background-color: #fff;
            box-shadow: 0 0 8px rgba(122, 0, 25, 0.1);
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .save-btn {
            background-color: var(--brand-maroon);
            color: white;
            padding: 12px 40px;
            border-radius: 30px;
            border: none;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        .cancel-btn {
            background-color: #ccc;
            color: white;
            padding: 12px 40px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            text-align: center;
        }

        .save-btn:hover { background-color: #a00021; }

        @media (max-width: 768px) {
            .navbar nav { display: none; }
            .edit-wrapper { padding: 30px; border-radius: 30px; }
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
            <li><a href="user-pet-checkin.jsp">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
            <li><a href="foster.jsp">Foster</a></li>
            <li><a href="donate.jsp">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>
    <div class="user-profile-icon">
        <a href="profile.jsp">👤</a>
    </div>
</header>

<main>
    <div class="edit-wrapper">
        <div class="header-flex">
            <h2 style="font-size: 32px; margin: 0;">Edit Profile</h2>
            <a href="profile.jsp" style="color: #666;"><i class="fa-solid fa-xmark fa-2x"></i></a>
        </div>

        <form class="edit-form" action="profile.jsp" method="post" enctype="multipart/form-data">
            <div class="profile-upload-section">
                <img src="https://images.unsplash.com/photo-1503777119540-ce54b422baff?q=80&w=200" alt="User Image">
                <div class="change-photo-btn">Change Profile Photo</div>
            </div>

            <div class="form-group">
                <label>Full Name</label>

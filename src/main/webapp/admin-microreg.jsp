<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pusakkamek.model.Microchip"%>

<%
    Microchip m = (Microchip) request.getAttribute("microchip");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Microchip Data - Pusak Kamek Admin</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --brand-maroon: #7a0019;
            --brand-maroon-light: #96102b;
            --shadow: 0 4px 20px rgba(0,0,0,0.15);
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, var(--brand-maroon-light), var(--brand-maroon));
            color: white;
            min-height: 100vh;
        }

        /* NAVBAR */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 5%;
            height: 80px;
            background: white;
            position: fixed;
            top: 0;
            width: 100%;
            box-shadow: var(--shadow);
            z-index: 1000;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--brand-maroon);
            font-weight: 800;
        }

        .logo-circle {
            width: 35px;
            height: 35px;
            background: var(--brand-maroon);
            color: white;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .admin-profile {
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--brand-maroon);
            font-weight: 700;
        }

        /* PAGE */
        .page-header {
            margin: 120px auto 20px;
            max-width: 1100px;
            width: 90%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .back-btn {
            background: white;
            color: var(--brand-maroon);
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 600;
            box-shadow: var(--shadow);
        }

        /* CARD */
        .dashboard-card {
            background: white;
            color: #333;
            width: 90%;
            max-width: 1100px;
            margin: 0 auto 60px;
            padding: 40px;
            border-radius: 30px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            box-shadow: var(--shadow);
        }

        h3 {
            color: var(--brand-maroon);
            margin-top: 0;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
        }

        .pet-info-box {
            background: #fff5f6;
            padding: 20px;
            border-radius: 20px;
            margin-bottom: 25px;
            border: 1px solid #fce4e6;
        }

        .pet-info-box p {
            margin: 6px 0;
            font-weight: 700;
            color: var(--brand-maroon);
        }

        .pet-info-box span {
            color: #555;
            font-weight: 400;
        }

        label {
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 5px;
            display: block;
            color: #555;
        }

        input {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: 1px solid #ddd;
            margin-bottom: 15px;
            font-family: inherit;
        }

        .status-input {
            background: #f5f5f5;
            font-weight: 700;
        }

        .btn-process {
            background: var(--brand-maroon);
            color: white;
            border: none;
            padding: 15px;
            border-radius: 15px;
            font-weight: 800;
            cursor: pointer;
            width: 100%;
        }

        .btn-process:hover {
            background: #5a0012;
        }

        @media (max-width: 850px) {
            .dashboard-card {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<header class="navbar">
    <div class="logo-section">
        <div class="logo-circle">PK</div>
        PUSAK KAMEK
    </div>

    <div class="admin-profile">
        Admin <span>👤</span>
    </div>
</header>

<div class="page-header">
    <h1>Microchip Registration</h1>
    <a href="admin-index.jsp" class="back-btn">
        <i class="fa-solid fa-arrow-left"></i> Back
    </a>
</div>

<div class="dashboard-card">

    <!-- LEFT PANEL -->
    <div>
        <h3>Pet & Owner Data</h3>

        <div class="pet-info-box">
            <p>Pet Name: <span><%= m.getPetName() %></span></p>
            <p>Microchip ID: <span><%= m.getMicrochipId() %></span></p>
        </div>

        <label>Owner Name</label>
        <input type="text" value="<%= m.getOwnerName() %>" readonly>

        <label>Address</label>
        <input type="text" value="<%= m.getAddress() %>" readonly>

        <label>Phone</label>
        <input type="text" value="<%= m.getPhone() %>" readonly>

        <label>Email</label>
        <input type="text" value="<%= m.getEmail() %>" readonly>
    </div>

    <!-- RIGHT PANEL -->
    <form action="microchip" method="post">
        <h3>Shelter Processing</h3>

        <input type="hidden" name="id" value="<%= m.getId() %>">

        <label>Registration Status</label>
        <input type="text"
               class="status-input"
               value="<%= m.getRegistrationStatus() %>"
               readonly>

        <label>Date Submitted</label>
        <input type="date" name="submittedDate" required>

        <label>Current Status</label>
        <input type="text" name="petStatus"
               value="<%= m.getPetStatus() %>"
               placeholder="Active / Safe / Lost">

        <button class="btn-process">
            Update & Finalize Record
        </button>
    </form>

</div>

</body>
</html>

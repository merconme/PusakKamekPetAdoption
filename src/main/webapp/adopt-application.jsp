<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pusakkamek.model.User"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String petId = request.getParameter("petId");
    if (petId == null) {
        response.sendRedirect("petbrowse.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pusak Kamek - Adoption Application</title>

    <style>
        :root {
            --brand-maroon: #7a0019;
            --page-bg: #FFF8DC;
        }

        body {
            background-color: var(--page-bg);
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: var(--brand-maroon);
            color: white;
        }

        .navbar ul {
            display: flex;
            list-style: none;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
        }

        .nav-link-active {
            background: rgba(0,0,0,0.2);
        }

        .main-wrapper {
            padding: 60px 20px;
            display: flex;
            justify-content: center;
        }

        .form-container {
            background: white;
            border-radius: 30px;
            max-width: 600px;
            width: 100%;
            padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        h1 {
            text-align: center;
            color: var(--brand-maroon);
            margin-bottom: 30px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
            color: var(--brand-maroon);
            margin-left: 10px;
        }

        input {
            padding: 12px 20px;
            border-radius: 25px;
            border: 2px solid var(--brand-maroon);
        }

        .submit-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        button {
            background: var(--brand-maroon);
            color: white;
            border: none;
            padding: 12px 60px;
            border-radius: 25px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #912e3f;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<header class="navbar">
    <div>
        <strong>PUSAK KAMEK</strong><br>
        <small>Rescue · Rehome · Rebuild</small>
    </div>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="petbrowse.jsp">Pet</a></li>
            <li><a href="adopt.jsp" class="nav-link-active">Adopt</a></li>
            <li><a href="profile.jsp">👤</a></li>
        </ul>
    </nav>
</header>

<!-- FORM -->
<div class="main-wrapper">
    <div class="form-container">
        <h1>Adoption Application</h1>

        <form action="AdoptionApplicationServlet" method="post">

            <!-- hidden -->
            <input type="hidden" name="userId" value="<%= user.getId() %>">
            <input type="hidden" name="petId" value="<%= petId %>">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="fullName"
                       value="<%= user.getFullName() %>" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email"
                       value="<%= user.getEmail() %>" required>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone"
                       value="<%= user.getPhone() %>" required>
            </div>

            <div class="form-group">
                <label>Why do you want to adopt this pet?</label>
                <input type="text" name="reason" required>
            </div>

            <div class="form-group">
                <label>Experience with pets</label>
                <input type="text" name="experience" required>
            </div>

            <div class="submit-wrapper">
                <button type="submit">Submit Application</button>
            </div>

        </form>
    </div>
</div>

</body>
</html>

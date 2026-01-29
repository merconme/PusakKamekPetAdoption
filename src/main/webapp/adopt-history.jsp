<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.pusakkamek.model.AdoptionApplication"%>
<%@page import="com.pusakkamek.model.User"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<AdoptionApplication> applications =
            (List<AdoptionApplication>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pusak Kamek - My Adoption History</title>

    <style>
        :root {
            --maroon: #7a0019;
            --page-bg: #FFF8DC;
            --status-pending: #f39c12;
            --status-approved: #27ae60;
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
            background-color: var(--maroon);
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
            background-color: rgba(0,0,0,0.2);
        }

        .wrapper {
            padding: 40px 5%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .table-container {
            background: white;
            border-radius: 40px;
            max-width: 900px;
            width: 100%;
            padding: 35px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            color: var(--maroon);
            padding-bottom: 15px;
            border-bottom: 2px solid #f3f3f3;
        }

        td {
            padding: 18px 0;
            border-bottom: 1px solid #eee;
        }

        .status-badge {
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .pending {
            background: #fff4e5;
            color: var(--status-pending);
        }

        .approved {
            background: #e8f5e9;
            color: var(--status-approved);
        }

        .btn-checkin {
            background: var(--maroon);
            color: white;
            padding: 10px 25px;
            border-radius: 20px;
            font-weight: bold;
            text-decoration: none;
            font-size: 13px;
        }

        .btn-disabled {
            background: #eee;
            color: #aaa;
            padding: 10px 25px;
            border-radius: 20px;
            font-size: 13px;
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
            <li><a href="AdoptHistoryServlet" class="nav-link-active">Adopt</a></li>
            <li><a href="profile.jsp">👤</a></li>
        </ul>
    </nav>
</header>

<!-- CONTENT -->
<div class="wrapper">

    <h1>My Adoption History</h1>
    <p>Track your applications and manage your pets.</p>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Pet Name</th>
                    <th>Type</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>

            <% if (applications != null && !applications.isEmpty()) {
                   for (AdoptionApplication app : applications) { %>

                <tr>
                    <td><strong><%= app.getPetName() %></strong></td>
                    <td><%= app.getPetType() %></td>

                    <td>
                        <% if ("APPROVED".equals(app.getStatus())) { %>
                            <span class="status-badge approved">Approved</span>
                        <% } else { %>
                            <span class="status-badge pending">Pending</span>
                        <% } %>
                    </td>

                    <td>
                        <% if ("APPROVED".equals(app.getStatus())) { %>
                            <a class="btn-checkin"
                               href="pet-checkin.jsp?applicationId=<%= app.getApplicationId() %>">
                                Submit Pet Update
                            </a>
                        <% } else { %>
                            <span class="btn-disabled">Waiting for Approval</span>
                        <% } %>
                    </td>
                </tr>

            <% } } else { %>
                <tr>
                    <td colspan="4">No adoption applications found.</td>
                </tr>
            <% } %>

            </tbody>
        </table>
    </div>
</div>

</body>
</html>

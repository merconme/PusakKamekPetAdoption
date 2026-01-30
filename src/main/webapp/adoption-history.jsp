<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.pusakkamek.model.Adoption"%>
<%@ page import="com.pusakkamek.model.User" %>
<%
    // Check for logged-in user
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp"); // not logged in, redirect
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Pusak Kamek - My Adoption History</title>
    <link rel="stylesheet" href="style.css">
    <!-- keep your CSS exactly as it is -->
</head>
<body>

<header class="navbar">
    <div class="logo-text">PUSAK KAMEK<br><small>Rescue - Rehome - Rebuild</small></div>
</header>

<div class="wrapper">

    <div class="back-btn-container">
        <a href="adopt.jsp" class="btn-back">← Back to Adopt</a>
    </div>

    <div class="header-section">
        <h1>My Adoption History</h1>
        <p class="subtitle">Track your applications and manage your pets.</p>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Pet Name</th>
                    <th>Type</th>
                    <th>Application Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>

            <%
                List<Adoption> history =
                    (List<Adoption>) request.getAttribute("history");

                if (history == null || history.isEmpty()) {
            %>
                <tr>
                    <td colspan="4">No adoption records found.</td>
                </tr>
            <%
                } else {
                    for (Adoption a : history) {
            %>
                <tr>
                    <td><strong><%= a.getPetName() %></strong></td>
                    <td><%= a.getPetType() %></td>

                    <td>
                        <span class="status-badge
                            <%= a.getStatus().equalsIgnoreCase("Approved") ? "approved" : "pending" %>">
                            <%= a.getStatus() %>
                        </span>
                    </td>

                    <td>
                        <% if (a.getStatus().equalsIgnoreCase("Approved")) { %>
                            <a href="pet-checkin.jsp?petId=<%= a.getPetId() %>"
                               class="btn-checkin">Submit Pet Update</a>
                        <% } else { %>
                            <span class="btn-disabled">Waiting for Approval</span>
                        <% } %>
                    </td>
                </tr>
            <%
                    }
                }
            %>

            </tbody>
        </table>
    </div>
</div>

</body>
</html>

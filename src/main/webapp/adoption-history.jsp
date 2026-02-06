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
    <style>
           /* CLEAN NAVBAR – RED THEME */
header.navbar{
    position:sticky;
    top:0;
    z-index:1000;
    background:linear-gradient(135deg, var(--brand2), var(--brand));
    border-bottom:none;
    box-shadow:0 10px 28px rgba(0,0,0,.18);
}

/* keep layout exactly the same */
.nav-wrap{
    max-width:1200px;
    margin:0 auto;
    padding:12px 18px;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:16px;
}

/* brand */
.brand{
    display:flex;
    align-items:center;
    gap:12px;
    min-width:230px;
}

.logo{
    width:42px;
    height:42px;
    border-radius:16px;
    background:linear-gradient(135deg,#fff,#f4d6dc);
    box-shadow:0 10px 24px rgba(0,0,0,.25);
    position:relative;
    overflow:hidden;
}
.logo:after{
    content:"";
    position:absolute;
    width:18px;
    height:18px;
    border-radius:50%;
    background:rgba(255,255,255,.55);
    top:-6px;
    right:-6px;
}

.brand-txt b{
    display:block;
    font-size:14px;
    letter-spacing:.5px;
    color:#fff;
}
.brand-txt small{
    display:block;
    font-size:11px;
    font-weight:700;
    margin-top:3px;
    color:rgba(255,255,255,.85);
}

/* NAV LINKS */
nav.links{
    display:flex;
    gap:10px;
    flex:1;
    justify-content:center;
}

nav.links a{
    padding:10px 14px;
    font-size:12px;
    font-weight:900;
    color:#fff;
    text-decoration:none;
    border-radius:999px;
    transition:.15s;
}

nav.links a:hover{
    background:rgba(255,255,255,.18);
    color:#fff;
}

nav.links a.active{
    background:rgba(255,255,255,.30);
    color:#fff;
}
    <!-- keep your CSS exactly as it is -->
      </style>
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

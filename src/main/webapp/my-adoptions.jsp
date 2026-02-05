<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pusakkamek.model.AdoptionApplication" %>
<%@ page import="com.pusakkamek.model.User" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String cp = request.getContextPath();

    List<AdoptionApplication> apps = (List<AdoptionApplication>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Adoptions - Pusak Kamek</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

<style>
:root{
  --brand:#7a0019;
  --brand-light:#96102b;
  --shadow:0 10px 30px rgba(0,0,0,.10);
  --bg:#f7f7f7;
}
body{margin:0;font-family:'Poppins',sans-serif;background:var(--bg);}

.navbar{
  display:flex;justify-content:space-between;align-items:center;
  padding:18px 6%;
  background:linear-gradient(135deg,var(--brand-light),var(--brand));
  color:#fff;box-shadow:var(--shadow);
  position:sticky;top:0;z-index:1000;
}
.brand{font-weight:800;letter-spacing:.5px;line-height:1.2}
.brand small{display:block;font-weight:500;opacity:.9;margin-top:2px}

.navbar nav ul{display:flex;list-style:none;gap:18px;margin:0;padding:0}
.navbar nav ul a{
  color:#fff;text-decoration:none;font-weight:700;
  padding:8px 18px;border-radius:30px;transition:.2s
}
.navbar nav ul a:hover,.active{background:rgba(255,255,255,.22)}
.user-right{display:flex;align-items:center;gap:12px}
.user-chip{background:rgba(255,255,255,.18);padding:8px 12px;border-radius:999px;font-weight:700;font-size:13px}

.wrap{padding:28px 6% 60px;}
h1{margin:0 0 6px;color:#222}
.sub{margin:0 0 18px;color:#666;font-size:13px}

.card{
  background:#fff;border-radius:18px;box-shadow:var(--shadow);
  overflow:hidden
}
table{width:100%;border-collapse:collapse}
th,td{padding:14px 16px;border-bottom:1px solid #eee;text-align:left;font-size:14px}
th{background:#fdf0f1;color:var(--brand);font-weight:900}
.badge{
  display:inline-block;padding:6px 12px;border-radius:999px;
  font-weight:900;font-size:12px
}
.PENDING{background:#fff3cd;color:#8a6d00}
.APPROVED{background:#e8f7ee;color:#0b5f16}
.REJECTED{background:#fde7e7;color:#8b0000}

.empty{
  padding:22px;color:#555
}
</style>
</head>

<body>

<header class="navbar">
  <div class="brand">
    PUSAK KAMEK
    <small>Rescue · Rehome · Rebuild</small>
  </div>

  <nav>
    <ul>
      <li><a href="<%= cp %>/index.jsp">Home</a></li>
      <li><a href="<%= cp %>/stories.jsp">Stories</a></li>
      <li><a href="<%= cp %>/petbrowse.jsp">Pet</a></li>
      <li><a href="<%= cp %>/adopt.jsp">Adopt</a></li>
      <li><a class="active" href="<%= cp %>/my-adoptions">My Adoptions</a></li>
      <li><a href="<%= cp %>/profile.jsp">Profile</a></li>
    </ul>
  </nav>

  <div class="user-right">
    <div class="user-chip">Hello, <%= currentUser.getName() %></div>
    <a href="<%= cp %>/LogoutServlet" style="color:white;font-weight:900;text-decoration:none;">Logout</a>
  </div>
</header>

<main class="wrap">
  <h1>My Adoption Applications</h1>
  <p class="sub">Track your adoption requests and their status.</p>

  <div class="card">
    <%
      if (apps == null || apps.isEmpty()) {
    %>
      <div class="empty">You have no applications yet. Go to <b>Pet</b> and apply for adoption.</div>
    <%
      } else {
    %>
      <table>
        <tr>
          <th>Pet</th>
          <th>Status</th>
          <th>Reason</th>
          <th>Date</th>
        </tr>

        <%
          for (AdoptionApplication a : apps) {
              String st = (a.getStatus() != null) ? a.getStatus().toUpperCase() : "PENDING";
        %>
        <tr>
          <td><b><%= a.getPetName() %></b></td>
          <td><span class="badge <%= st %>"><%= st %></span></td>
          <td><%= a.getReason() %></td>
          <td><%= (a.getCreatedAt() != null ? a.getCreatedAt().toString() : "-") %></td>
        </tr>
        <% } %>
      </table>
    <% } %>
  </div>
</main>

</body>
</html>

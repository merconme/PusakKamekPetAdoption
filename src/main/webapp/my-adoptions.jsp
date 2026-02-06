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

/* ===== NAVBAR (MATCH INDEX/ADOPT EXACTLY) ===== */
header.navbar{
  position:sticky;
  top:0;
  z-index:1000;
  background:linear-gradient(135deg, var(--brand-light), var(--brand));
  box-shadow:0 10px 28px rgba(0,0,0,.18);
  color:#fff;
}

.nav-wrap{
  max-width:1200px;
  margin:0 auto;
  padding:12px 18px;
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:16px;
}

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

/* nav links */
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
nav.links a:hover{ background:rgba(255,255,255,.18); }
nav.links a.active{ background:rgba(255,255,255,.30); }

/* right side */
.right{
  display:flex;
  gap:10px;
  align-items:center;
  justify-content:flex-end;
  min-width:230px;
}

/* profile dropdown */
.profile{ position:relative; }

.profile-btn{
  display:flex;
  align-items:center;
  gap:10px;
  border:1px solid rgba(255,255,255,.45);
  background:rgba(255,255,255,.10);
  padding:7px 10px;
  border-radius:999px;
  cursor:pointer;
  color:#fff;
}

.avatar{
  width:34px;
  height:34px;
  border-radius:50%;
  display:flex;
  align-items:center;
  justify-content:center;
  background:rgba(255,255,255,.25);
}

.name{
  font-weight:900;
  font-size:12px;
  max-width:140px;
  overflow:hidden;
  text-overflow:ellipsis;
  white-space:nowrap;
  color:#fff;
}

.menu{
  position:absolute;
  right:0;
  top:52px;
  width:210px;
  background:#fff;
  border:1px solid #e5e7eb;
  border-radius:16px;
  box-shadow:0 12px 30px rgba(0,0,0,.25);
  overflow:hidden;
  display:none;
}

.menu a{
  display:block;
  padding:12px 14px;
  text-decoration:none;
  font-weight:900;
  font-size:13px;
  color:#444;
}
.menu a:hover{ background:#f5f5f5; }
.menu a.logout{ color:#b00020; }

@media (max-width: 900px){
  nav.links{ display:none; }
}

/* Profile */
.profile-wrapper{ position:relative; }
.profile-btn{
  display:flex;
  align-items:center;
  gap:10px;
  cursor:pointer;
  background:rgba(255,255,255,.14);
  border:1px solid rgba(255,255,255,.22);
  padding:8px 10px;
  border-radius:999px;
}
.profile-icon{
  width:34px;
  height:34px;
  border-radius:50%;
  background:rgba(255,255,255,.22);
  display:flex;
  align-items:center;
  justify-content:center;
}

.profile-menu{
  position:absolute;
  right:0;
  top:52px;
  width:190px;
  background:#fff;
  border-radius:14px;
  box-shadow:0 12px 30px rgba(0,0,0,.18);
  overflow:hidden;
  display:none;
}
.profile-menu a{
  display:block;
  padding:12px 14px;
  text-decoration:none;
  color:#444;
  font-weight:900;
  font-size:13px;
}
.profile-menu a:hover{ background:#f4f4f5; }
.profile-menu .logout{ color:#b00020; }

@media (max-width:900px){
  .nav-links{ display:none; }
}

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
    <div class="nav-wrap">

        <div class="brand">
            <div class="logo"></div>
            <div class="brand-txt">
                <b>PUSAK KAMEK</b>
                <small>Rescue · Rehome · Rebuild</small>
            </div>
        </div>

        <nav class="links">
            <a href="<%= cp %>/index.jsp">Home</a>
            <a href="<%= cp %>/stories">Stories</a>
            <a href="<%= cp %>/petbrowse.jsp">Pet</a>
            <a href="<%= cp %>/adopt.jsp">Adopt</a>
            <a href="<%= cp %>/volunteer.jsp">Volunteer</a>
            <a href="<%= cp %>/donation.jsp">Donation</a>
            <a class="active" href="<%= cp %>/my-adoptions">My Adoptions</a>
        </nav>

        <div class="right">
            <div class="profile">
                <div class="profile-btn" onclick="toggleProfileMenu()">
                    <div class="avatar">👤</div>
                    <div class="name">Hello, <%= currentUser.getName() %></div>
                </div>

                <div class="menu" id="profileMenu">
                    <a href="<%= cp %>/profile.jsp">Update Profile</a>
                    <a class="logout" href="<%= cp %>/LogoutServlet">Logout</a>
                </div>
            </div>
        </div>

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
<script>
function toggleProfileMenu(){
  const menu = document.getElementById("profileMenu");
  if(!menu) return;
  menu.style.display = (menu.style.display === "block") ? "none" : "block";
}
window.onclick = function(e){
  if(!e.target.closest(".profile")){
    const menu = document.getElementById("profileMenu");
    if(menu) menu.style.display = "none";
  }
}
</script>

</body>
</html>

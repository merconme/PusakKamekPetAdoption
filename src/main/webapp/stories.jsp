<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pusakkamek.model.Story" %>
<%@ page import="com.pusakkamek.model.User" %>

<%
    String cp = request.getContextPath();
    User currentUser = (User) session.getAttribute("currentUser"); // can be null (allow public)
    List<Story> stories = (List<Story>) request.getAttribute("stories");
    if (stories == null) stories = java.util.Collections.emptyList();
    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Stories - Pusak Kamek</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

<style>
:root{
  --brand:#7a0019;
  --brand2:#96102b;
  --bg:#f6f7fb;
  --card:#fff;
  --line:#e5e7eb;
  --shadow:0 10px 30px rgba(0,0,0,.10);
}
*{box-sizing:border-box}
body{margin:0;font-family:'Poppins',sans-serif;background:var(--bg);color:#111}

/* ===== USER NAVBAR ===== */
header.navbar{
  position:sticky;top:0;z-index:1000;
  background:linear-gradient(135deg,var(--brand2),var(--brand));
  box-shadow:0 10px 28px rgba(0,0,0,.18);
  color:#fff;
}
.nav-wrap{
  max-width:1200px;margin:0 auto;padding:12px 18px;
  display:flex;align-items:center;justify-content:space-between;gap:16px;
}
.brand{display:flex;align-items:center;gap:12px;min-width:230px;}
.logo{
  width:42px;height:42px;border-radius:16px;
  background:linear-gradient(135deg,#fff,#f4d6dc);
  box-shadow:0 10px 24px rgba(0,0,0,.25);
}
.brand-txt b{display:block;font-size:14px;letter-spacing:.5px;color:#fff;}
.brand-txt small{display:block;font-size:11px;font-weight:700;margin-top:3px;color:rgba(255,255,255,.85);}

nav.links{display:flex;gap:10px;flex:1;justify-content:center;}
nav.links a{
  padding:10px 14px;font-size:12px;font-weight:900;color:#fff;text-decoration:none;
  border-radius:999px;transition:.15s;
}
nav.links a:hover{background:rgba(255,255,255,.18);}
nav.links a.active{background:rgba(255,255,255,.30);}

.right{display:flex;gap:10px;align-items:center;justify-content:flex-end;min-width:230px;}
.profile{position:relative;}
.profile-btn{
  display:flex;align-items:center;gap:10px;
  border:1px solid rgba(255,255,255,.45);
  background:rgba(255,255,255,.10);
  padding:7px 10px;border-radius:999px;cursor:pointer;color:#fff;
}
.avatar{width:34px;height:34px;border-radius:50%;display:flex;align-items:center;justify-content:center;background:rgba(255,255,255,.25);}
.name{font-weight:900;font-size:12px;max-width:140px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:#fff;}
.menu{
  position:absolute;right:0;top:52px;width:210px;background:#fff;
  border:1px solid var(--line);border-radius:16px;box-shadow:0 12px 35px rgba(0,0,0,.12);
  overflow:hidden;display:none;
}
.menu a{display:block;padding:12px 14px;text-decoration:none;font-weight:900;font-size:13px;color:#444;}
.menu a:hover{background:#f5f5f5;}
.menu a.logout{color:#b00020;}
@media(max-width:900px){ nav.links{display:none;} }

.container{max-width:1200px;margin:0 auto;padding:26px 18px 70px;}
.hero{
  background:linear-gradient(135deg,#fff,#fff6f7);
  border:1px solid rgba(229,231,235,.8);
  border-radius:26px;box-shadow:var(--shadow);
  padding:22px;
}
.hero h1{margin:0 0 6px;color:var(--brand);font-weight:900;}
.hero p{margin:0;color:#555;font-weight:600;font-size:13px;line-height:1.7}

.grid{
  margin-top:16px;
  display:grid;
  grid-template-columns:repeat(3,minmax(0,1fr));
  gap:14px;
}
@media(max-width:900px){ .grid{grid-template-columns:1fr;} }

.story-card{
  background:var(--card);
  border:1px solid rgba(229,231,235,.85);
  border-radius:22px;
  box-shadow:0 10px 25px rgba(0,0,0,.06);
  overflow:hidden;
}
.story-img{
  width:100%;height:180px;object-fit:cover;background:#eee;display:block;
}
.story-body{padding:16px;}
.story-body h3{margin:0 0 8px;color:var(--brand);font-size:16px;font-weight:900;}
.story-body p{margin:0;color:#555;font-weight:600;font-size:13px;line-height:1.7;white-space:pre-line}
.bad{
  display:inline-block;margin-top:10px;
  padding:6px 10px;border-radius:999px;
  background:#fdf0f1;color:var(--brand);font-weight:900;font-size:11px;border:1px solid rgba(122,0,25,.12);
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
      <a class="active" href="<%= cp %>/stories">Stories</a>
      <a href="<%= cp %>/petbrowse.jsp">Pet</a>
      <a href="<%= cp %>/adopt.jsp">Adopt</a>
      <a href="<%= cp %>/volunteer.jsp">Volunteer</a>
      <a href="<%= cp %>/donation.jsp">Donation</a>
      <a href="<%= cp %>/my-adoptions">My Adoptions</a>
    </nav>

    <div class="right">
      <div class="profile">
        <div class="profile-btn" onclick="toggleProfileMenu()">
          <div class="avatar">👤</div>
          <div class="name">
            <%= (currentUser != null ? "Hello, " + currentUser.getName() : "Guest") %>
          </div>
        </div>

        <div class="menu" id="profileMenu">
          <% if(currentUser != null){ %>
            <a href="<%= cp %>/profile.jsp">Update Profile</a>
            <a class="logout" href="<%= cp %>/LogoutServlet">Logout</a>
          <% } else { %>
            <a href="<%= cp %>/login.jsp">Login</a>
            <a href="<%= cp %>/register.jsp">Register</a>
          <% } %>
        </div>
      </div>
    </div>
  </div>
</header>

<main class="container">
  <section class="hero">
    <h1>Success Stories</h1>
    <p>Read updates and happy endings shared by our admin team. Every adoption matters.</p>
  </section>

  <% if(error != null){ %>
    <div style="margin-top:14px;padding:12px 14px;border-radius:14px;background:#fde7e7;color:#8b0000;font-weight:900;border:1px solid rgba(139,0,0,.15);">
      <%= error %>
    </div>
  <% } %>

  <section class="grid">
    <% if(stories.isEmpty()){ %>

      <div class="story-card" style="grid-column:1/-1;padding:18px;">
        No stories yet.
      </div>

    <% } else {
         for(Story s : stories){
           String img = s.getImageFile();  // ✅ FIX: model uses getImageFile()
           boolean hasImg = (img != null && !img.trim().isEmpty());
    %>

      <div class="story-card">
        <% if(hasImg){ %>
          <!-- ✅ FIX: show via servlet -->
          <img class="story-img" src="<%= cp %>/story-image?file=<%= img %>" alt="story">
        <% } %>

        <div class="story-body">
          <h3><%= s.getTitle() %></h3>
          <p><%= s.getContent() %></p>
          <div class="bad">Published</div>
        </div>
      </div>

    <% } } %>
  </section>
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

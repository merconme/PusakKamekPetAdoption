<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pusakkamek.model.Admin" %>
<%@ page import="com.pusakkamek.model.Story" %>

<%
    String cp = request.getContextPath();
    Admin admin = (Admin) session.getAttribute("adminUser");
    if (admin == null) {
        response.sendRedirect(cp + "/admin-login.jsp");
        return;
    }

    String adminDisplay = "Admin";
    try { adminDisplay = admin.getUsername(); } catch(Exception e){}

    List<Story> stories = (List<Story>) request.getAttribute("stories");
    if (stories == null) stories = java.util.Collections.emptyList();

    String error = (String) request.getAttribute("error");

    String msg = (String) session.getAttribute("adminStoryMsg");
    if (msg != null) session.removeAttribute("adminStoryMsg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Stories - Pusak Kamek</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
:root{
  --brand:#7a0019;
  --brand2:#96102b;
  --shadow:0 10px 30px rgba(0,0,0,.10);
  --bg:#f7f7f7;
}
*{box-sizing:border-box}
body{margin:0;font-family:'Poppins',sans-serif;background:var(--bg);}

/* layout */
.shell{display:flex;min-height:100vh}
.sidebar{
  width:260px;background:linear-gradient(135deg,var(--brand2),var(--brand));
  color:#fff;padding:18px 16px;position:sticky;top:0;height:100vh
}
.side-brand{display:flex;gap:12px;align-items:center;padding:10px 10px 16px;border-bottom:1px solid rgba(255,255,255,.18)}
.logo{width:44px;height:44px;border-radius:16px;background:#fff}
.side-links{margin-top:14px;display:flex;flex-direction:column;gap:8px}
.side-links a{
  display:flex;align-items:center;gap:10px;
  padding:11px 12px;border-radius:14px;
  text-decoration:none;color:#fff;font-weight:900;font-size:13px;
  background:rgba(255,255,255,.08)
}
.side-links a.active{background:rgba(255,255,255,.28)}
.side-bottom{margin-top:auto;padding-top:14px;border-top:1px solid rgba(255,255,255,.18)}
.side-user{display:flex;gap:10px;align-items:center;background:rgba(255,255,255,.1);padding:10px;border-radius:14px;font-weight:900;font-size:12px}
.logout{display:block;margin-top:10px;text-align:center;padding:10px;border-radius:14px;background:rgba(255,255,255,.1);color:#fff;text-decoration:none;font-weight:900}

.content{flex:1;padding:22px 28px 60px}
h1{margin:0}
.sub{color:#666;font-size:13px;margin-bottom:18px}

.msg{padding:10px 14px;border-radius:14px;font-weight:900;font-size:13px;margin-bottom:14px}
.msg.ok{background:#e8f7ee;color:#0b5f16}
.msg.err{background:#fde7e7;color:#8b0000}

.grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
@media(max-width:900px){.grid{grid-template-columns:1fr}}

.card{background:#fff;border-radius:18px;box-shadow:var(--shadow);border:1px solid #eee}
.cardHead{padding:14px 16px;font-weight:900;border-bottom:1px solid #eee}
.cardBody{padding:16px}

label{font-size:12px;font-weight:900;color:#666}
input,textarea{width:100%;padding:11px;border-radius:12px;border:1px solid #ddd}
textarea{min-height:140px}
.row{margin-bottom:12px}

.btn{border:none;padding:10px 14px;border-radius:12px;font-weight:900;cursor:pointer}
.btn-primary{background:var(--brand);color:#fff}
.btn-soft{background:#f3f3f4}

.story{padding:14px 16px;border-bottom:1px solid #eee}
.story:last-child{border-bottom:none}
.story h3{margin:0;color:var(--brand)}
.story-img{width:100%;max-height:170px;object-fit:cover;border-radius:14px;margin-top:10px;border:1px solid #eee}
.actions{margin-top:10px}
</style>
</head>

<body>
<div class="shell">

<!-- SIDEBAR -->
<aside class="sidebar">
  <div class="side-brand">
    <div class="logo"></div>
    <div>
      <b>PUSAK KAMEK</b>
      <small>ADMIN PANEL</small>
    </div>
  </div>

  <nav class="side-links">
    <a href="<%= cp %>/admin/index"><i class="fa fa-gauge"></i> Dashboard</a>
    <a href="<%= cp %>/admin/adoptions"><i class="fa fa-file"></i> Adoptions</a>
    <a href="<%= cp %>/add-petbrowse.jsp"><i class="fa fa-paw"></i> Pets</a>
    <a class="active" href="<%= cp %>/admin/stories"><i class="fa fa-book"></i> Stories</a>
    <a href="<%= cp %>/admin/volunteers"><i class="fa fa-heart"></i> Volunteers</a>
    <a href="<%= cp %>/admin/donations"><i class="fa fa-dollar"></i> Donations</a>
  </nav>

  <div class="side-bottom">
    <div class="side-user">👤 <%= adminDisplay %></div>
    <a class="logout" href="<%= cp %>/adminLogout">Logout</a>
  </div>
</aside>

<!-- CONTENT -->
<main class="content">
  <h1>Stories</h1>
  <p class="sub">Admin creates stories. Users can read them.</p>

  <% if (msg != null) { %>
    <div class="msg <%= msg.startsWith("✅") ? "ok" : "err" %>"><%= msg %></div>
  <% } %>

  <% if (error != null) { %>
    <div class="msg err"><%= error %></div>
  <% } %>

  <div class="grid">

    <!-- ADD STORY -->
    <div class="card">
      <div class="cardHead">Add New Story</div>
      <div class="cardBody">
        <form method="post" action="<%= cp %>/admin/stories" enctype="multipart/form-data">
          <div class="row">
            <label>Title</label>
            <input name="title" required>
          </div>
          <div class="row">
            <label>Image (optional)</label>
            <input type="file" name="image" accept="image/*">
          </div>
          <div class="row">
            <label>Content</label>
            <textarea name="content" required></textarea>
          </div>
          <button class="btn btn-primary">Publish Story</button>
        </form>
      </div>
    </div>

<!-- STORY LIST -->
<div class="card">
  <div class="cardHead">All Stories</div>

  <% if (stories.isEmpty()) { %>
    <div class="story">No stories yet.</div>
  <% } else {
       for (Story s : stories) {

         String img = s.getImageFile(); // ✅ CORRECT getter
  %>

  <div class="story">
    <h3><%= s.getTitle() %></h3>

    <div class="small">
      <%= s.getContent().length() > 140
            ? s.getContent().substring(0,140) + "..."
            : s.getContent() %>
    </div>

    <% if (img != null && !img.trim().isEmpty()) { %>
      <img class="story-img"
           src="<%= cp %>/story-image?file=<%= img %>"
           alt="story image">
    <% } %>

    <div class="actions">
      <form method="post"
            action="<%= cp %>/admin/stories/delete"
            onsubmit="return confirm('Delete this story?')">
        <input type="hidden" name="id" value="<%= s.getId() %>">
        <button class="btn btn-soft" style="color:#b00020">Delete</button>
      </form>
    </div>
  </div>

  <% } } %>
</div>

  </div>
</main>

</div>
</body>
</html>

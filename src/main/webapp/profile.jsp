<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pusakkamek.model.User" %>
<%
    String cp = request.getContextPath();

    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(cp + "/login.jsp");
        return;
    }

    String success = (String) session.getAttribute("profileSuccess");
    String error = (String) session.getAttribute("profileError");
    if (success != null) session.removeAttribute("profileSuccess");
    if (error != null) session.removeAttribute("profileError");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Pusak Kamek - Update Profile</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brand2:#96102b;
            --bg:#f6f7fb;
            --text:#111827;
            --line:#e5e7eb;
            --shadow:0 12px 35px rgba(0,0,0,.10);
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family:'Poppins',system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
            background:var(--bg);
            color:var(--text);
        }

        /* NAVBAR SAME STYLE */
        header.navbar{
            position:sticky; top:0; z-index:1000;
            background:linear-gradient(135deg, var(--brand2), var(--brand));
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
            display:flex; align-items:center; gap:12px;
            min-width:230px;
        }
        .logo{
            width:42px;height:42px;border-radius:16px;
            background:linear-gradient(135deg,#fff,#f4d6dc);
            box-shadow:0 10px 24px rgba(0,0,0,.25);
            position:relative; overflow:hidden;
        }
        .logo:after{
            content:""; position:absolute; width:18px;height:18px;border-radius:50%;
            background:rgba(255,255,255,.55); top:-6px; right:-6px;
        }
        .brand-txt b{ display:block; font-size:14px; letter-spacing:.5px; color:#fff; }
        .brand-txt small{ display:block; font-size:11px; font-weight:700; margin-top:3px; color:rgba(255,255,255,.85); }

        nav.links{ display:flex; gap:10px; flex:1; justify-content:center; }
        nav.links a{
            padding:10px 14px;
            font-size:12px; font-weight:900;
            color:#fff; text-decoration:none;
            border-radius:999px; transition:.15s;
        }
        nav.links a:hover{ background:rgba(255,255,255,.18); }
        nav.links a.active{ background:rgba(255,255,255,.30); }

        .right{ display:flex; gap:10px; align-items:center; justify-content:flex-end; min-width:230px; }
        .profile{ position:relative; }
        .profile-btn{
            display:flex; align-items:center; gap:10px;
            border:1px solid rgba(255,255,255,.45);
            background:rgba(255,255,255,.10);
            padding:7px 10px; border-radius:999px;
            cursor:pointer; color:#fff;
        }
        .avatar{
            width:34px;height:34px;border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            background:rgba(255,255,255,.25);
        }
        .name{
            font-weight:900; font-size:12px;
            max-width:140px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
            color:#fff;
        }
        .menu{
            position:absolute; right:0; top:52px;
            width:210px; background:#fff;
            border:1px solid var(--line);
            border-radius:16px; box-shadow:0 12px 30px rgba(0,0,0,.25);
            overflow:hidden; display:none;
        }
        .menu a{
            display:block; padding:12px 14px;
            text-decoration:none; font-weight:900; font-size:13px;
            color:#444;
        }
        .menu a:hover{ background:#f5f5f5; }
        .menu a.logout{ color:#b00020; }
        @media (max-width: 1000px){ nav.links{ display:none; } }

        /* TOAST */
        .toast{
            max-width:1200px;
            margin:14px auto 0;
            padding:14px 16px;
            border-radius:16px;
            font-weight:900;
            font-size:13px;
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:12px;
            box-shadow:0 12px 28px rgba(0,0,0,.10);
            border:1px solid transparent;
        }
        .toast button{
            border:none;background:transparent;cursor:pointer;
            font-weight:900;font-size:14px;opacity:.8;
        }
        .toast button:hover{ opacity:1; }
        .toast-success{ background:linear-gradient(135deg,#e8f7ee,#f4fbf7); color:#0b5f16; border-color:rgba(11,95,22,.15); }
        .toast-error{ background:linear-gradient(135deg,#fde7e7,#fff3f3); color:#8b0000; border-color:rgba(139,0,0,.15); }

        /* PAGE */
        .container{
            max-width:1200px;
            margin:0 auto;
            padding:24px 18px 70px;
        }
        .head{ text-align:center; margin:10px 0 18px; }
        .head h1{ margin:0 0 6px; font-size:28px; }
        .head p{ margin:0; color:#666; font-weight:700; font-size:13px; }

        .card{
            max-width:700px;
            margin:0 auto;
            background:#fff;
            border:1px solid rgba(229,231,235,.85);
            border-radius:22px;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            padding:18px;
        }
        label{ display:block; font-weight:900; font-size:12px; color:#333; margin:12px 0 6px; }
        input{
            width:100%;
            padding:12px 12px;
            border-radius:14px;
            border:1px solid #e5e7eb;
            outline:none;
            font-family:inherit;
            font-size:13px;
        }
        .btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            padding:12px 18px;
            border-radius:999px;
            font-weight:900;
            font-size:13px;
            border:none;
            cursor:pointer;
            width:100%;
            margin-top:14px;
            background:linear-gradient(135deg,var(--brand2),var(--brand));
            color:#fff;
            box-shadow:0 12px 26px rgba(122,0,25,.18);
        }
        .hint{ margin-top:10px; color:#666; font-weight:700; font-size:12px; line-height:1.6; }
        .two{ display:grid; grid-template-columns:1fr 1fr; gap:12px; }
        @media(max-width:700px){ .two{ grid-template-columns:1fr; } }
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
            <a href="<%= cp %>/stories.jsp">Stories</a>
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
                    <div class="name">Hello, <%= currentUser.getName() %></div>
                </div>
                <div class="menu" id="profileMenu">
                    <a class="active" href="<%= cp %>/profile.jsp">Update Profile</a>
                    <a class="logout" href="<%= cp %>/LogoutServlet">Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<% if (success != null) { %>
<div class="toast toast-success" id="toastMsg">
    <span><%= success %></span>
    <button type="button" onclick="closeToast()">✕</button>
</div>
<% } %>

<% if (error != null) { %>
<div class="toast toast-error" id="toastMsg">
    <span><%= error %></span>
    <button type="button" onclick="closeToast()">✕</button>
</div>
<% } %>

<main class="container">
    <div class="head">
        <h1>Update Profile</h1>
        <p>Edit your name, email, phone (and password if you want).</p>
    </div>

    <div class="card">
        <form method="post" action="<%= cp %>/update-profile">

            <label>Full Name *</label>
            <input type="text" name="name" value="<%= currentUser.getName() %>" required>

            <label>Email *</label>
            <input type="email" name="email" value="<%= currentUser.getEmail() %>" required>

            <label>Phone</label>
            <input type="text" name="phone" value="<%= currentUser.getPhone() != null ? currentUser.getPhone() : "" %>" placeholder="01x-xxxxxxx">

            <label style="margin-top:16px;">Change Password (optional)</label>
            <div class="two">
                <input type="password" name="new_password" placeholder="New password (leave empty if not change)">
                <input type="password" name="confirm_password" placeholder="Confirm new password">
            </div>

            <button class="btn" type="submit">Save Changes</button>

            <div class="hint">
                If you don’t want to change password, leave both password boxes empty.
            </div>
        </form>
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
function closeToast(){
    const t = document.getElementById("toastMsg");
    if(t) t.style.display = "none";
}
setTimeout(closeToast, 3000);
</script>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pusakkamek.model.User" %>
<%
    String cp = request.getContextPath();

    // ✅ Require login
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(cp + "/login.jsp");
        return;
    }

    String success = (String) session.getAttribute("volunteerSuccess");
    String error = (String) session.getAttribute("volunteerError");
    if (success != null) session.removeAttribute("volunteerSuccess");
    if (error != null) session.removeAttribute("volunteerError");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Volunteer</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brand2:#96102b;
            --bg:#fdf2f4;
            --line:#e5e7eb;
            --shadow:0 10px 30px rgba(0,0,0,0.12);
        }

        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family:'Poppins',system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
            background:var(--bg);
        }

        /* ===== NAVBAR (MATCH ADOPT/INDEX) ===== */
        header.navbar{
            position:sticky;
            top:0;
            z-index:1000;
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
            display:flex;
            align-items:center;
            gap:12px;
            min-width:230px;
        }
        .logo{
            width:42px;height:42px;border-radius:16px;
            background:linear-gradient(135deg,#fff,#f4d6dc);
            box-shadow:0 10px 24px rgba(0,0,0,.25);
            position:relative; overflow:hidden;
        }
        .logo:after{
            content:"";
            position:absolute;
            width:18px;height:18px;border-radius:50%;
            background:rgba(255,255,255,.55);
            top:-6px; right:-6px;
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

        .right{
            display:flex;
            gap:10px;
            align-items:center;
            justify-content:flex-end;
            min-width:230px;
        }
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
            width:34px;height:34px;border-radius:50%;
            display:flex;align-items:center;justify-content:center;
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
            border:1px solid var(--line);
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

        /* ✅ Toast (same style) */
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
            animation:toastDrop .35s ease;
        }
        .toast button{
            border:none;background:transparent;cursor:pointer;
            font-weight:900;font-size:14px;opacity:.8;
        }
        .toast button:hover{ opacity:1; }
        .toast-success{
            background:linear-gradient(135deg,#e8f7ee,#f4fbf7);
            color:#0b5f16;
            border-color:rgba(11,95,22,.15);
        }
        .toast-error{
            background:linear-gradient(135deg,#fde7e7,#fff3f3);
            color:#8b0000;
            border-color:rgba(139,0,0,.15);
        }
        @keyframes toastDrop{
            from{ opacity:0; transform:translateY(-10px); }
            to{ opacity:1; transform:translateY(0); }
        }

        /* ===== your page styling (keep yours) ===== */
        .page-wrapper { padding: 60px 5%; }
        .container { max-width: 1000px; margin: 0 auto; }
        h1 { color: var(--brand); font-size: 42px; margin-bottom: 20px; text-align: center; }
        .donation-card { background: white; padding: 40px; border-radius: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); text-align: center; }
        .donation-header { color: var(--brand); margin-bottom: 20px; }
        .process-section { margin-top: 50px; }
        .section-title { text-align: center; margin-bottom: 40px; }
        .process-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 25px; }
        .process-card { background: white; padding: 30px 20px; border-radius: 30px; text-align: center; box-shadow: 0 5px 15px rgba(0,0,0,0.05); transition: 0.3s; }
        .process-card:hover { transform: translateY(-5px); }
        .process-number { background: var(--brand); color: white; width: 40px; height: 40px; display: flex; align-items: center; justify-content: center; border-radius: 50%; margin: 0 auto 15px; font-weight: bold; font-size: 20px; }
        .process-card h4 { color: var(--brand); margin-bottom: 10px; }
        .process-card p { font-size: 14px; color: #666; line-height: 1.4; }
        .btn-main { display: inline-block; background-color: var(--brand); color: white; padding: 15px 35px; border-radius: 30px; text-decoration: none; font-weight: bold; transition: 0.3s; }
        .btn-main:hover { background-color: #5a0012; transform: scale(1.05); }
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
            <a class="active" href="<%= cp %>/volunteer.jsp">Volunteer</a>
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
                    <a href="<%= cp %>/profile.jsp">Update Profile</a>
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

<main class="page-wrapper">
    <div class="container">
        <h1>Join Our Team!</h1>

        <div class="donation-card" style="margin-bottom: 30px;">
            <h2 class="donation-header" style="font-size: 28px;">Why Volunteer with Pusak Kamek</h2>
            <p style="color: #444; font-size: 18px; line-height: 1.6; max-width: 900px; margin: 0 auto;">
                Volunteering is the heart of our shelter. As a volunteer, you directly contribute to the
                <strong>happiness and rehabilitation</strong> of our animals.
            </p>
        </div>

        <div class="process-section">
            <h3 class="section-title" style="font-size: 24px; color: #333;">The 4-Step Volunteer Process</h3>
            <div class="process-grid">
                <div class="process-card">
                    <span class="process-number">1</span>
                    <h4>Apply Online</h4>
                    <p>Submit your basic info and availability through our portal.</p>
                </div>
                <div class="process-card">
                    <span class="process-number">2</span>
                    <h4>Orientation</h4>
                    <p>Attend a mandatory introductory session at our shelter.</p>
                </div>
                <div class="process-card">
                    <span class="process-number">3</span>
                    <h4>Training</h4>
                    <p>Receive hands-on training for your specific assigned role.</p>
                </div>
                <div class="process-card">
                    <span class="process-number">4</span>
                    <h4>Get Started!</h4>
                    <p>Begin your rewarding work with our rescued animals.</p>
                </div>
            </div>

            <div style="text-align: center; margin-top: 40px;">
                <a href="<%= cp %>/volunteer-form.jsp" class="btn-main">
                    Submit Your Application, Requirements & Roles
                </a>
            </div>
        </div>
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

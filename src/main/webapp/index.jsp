<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pusakkamek.model.User" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Home</title>

    <link rel="stylesheet" href="<%= cp %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brandLight:#96102b;
            --shadow:0 10px 30px rgba(0,0,0,0.14);
            --soft:rgba(255,255,255,0.18);
        }

        body{
            margin:0;
            font-family:'Poppins','Segoe UI',sans-serif;
            background:#f7f7f7;
        }

        /* ===== NAVBAR (shared style) ===== */
        .navbar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding:14px 6%;
            background:linear-gradient(135deg,var(--brandLight),var(--brand));
            color:#fff;
            box-shadow:var(--shadow);
            position:sticky;
            top:0;
            z-index:1000;
        }

        .logo-text{
            font-weight:800;
            font-size:16px;
            line-height:1.05;
            letter-spacing:.3px;
        }
        .logo-text small{
            display:block;
            font-weight:500;
            font-size:11px;
            opacity:.9;
            margin-top:3px;
        }

        .nav-links{
            list-style:none;
            display:flex;
            gap:14px;
            margin:0;
            padding:0;
            align-items:center;
        }
        .nav-links a{
            color:white;
            text-decoration:none;
            font-weight:600;
            font-size:13px;
            padding:8px 14px;
            border-radius:999px;
            transition:.25s;
            white-space:nowrap;
        }
        .nav-links a:hover{
            background:var(--soft);
        }
        .nav-link-active{
            background:rgba(255,255,255,0.26);
        }

        /* Right area */
        .right-area{
            display:flex;
            align-items:center;
            gap:10px;
        }

        .btn-outline{
            padding:8px 14px;
            border-radius:999px;
            border:1px solid rgba(255,255,255,0.65);
            color:white;
            text-decoration:none;
            font-weight:700;
            font-size:12px;
            transition:.25s;
            white-space:nowrap;
        }
        .btn-outline:hover{
            background:white;
            color:var(--brand);
        }

        /* Profile dropdown */
        .profile-wrapper{ position:relative; }
        .profile-btn{
            display:flex;
            align-items:center;
            gap:10px;
            cursor:pointer;
            padding:6px 10px;
            border-radius:999px;
            transition:.25s;
            user-select:none;
        }
        .profile-btn:hover{ background:var(--soft); }

        .profile-name{
            font-weight:700;
            font-size:12.5px;
            white-space:nowrap;
        }

        .profile-icon{
            width:34px;
            height:34px;
            border-radius:50%;
            background:rgba(255,255,255,0.22);
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:16px;
        }

        .profile-menu{
            position:absolute;
            right:0;
            top:48px;
            background:#fff;
            width:190px;
            border-radius:14px;
            box-shadow:var(--shadow);
            overflow:hidden;
            display:none;
        }
        .profile-menu a{
            display:block;
            padding:12px 14px;
            text-decoration:none;
            color:#555;
            font-weight:700;
            font-size:13px;
        }
        .profile-menu a:hover{ background:#f5f5f5; }
        .profile-menu .logout{ color:#b00020; }

        /* ===== Your existing page layout can stay ===== */
        /* If your style.css already has hero styles, keep them. */
        .page-wrapper{ padding:30px 6% 60px; }
    </style>
</head>

<body>

<header class="navbar">
    <div class="logo-text">
        PUSAK KAMEK
        <small>Rescue · Rehome · Rebuild</small>
    </div>

    <nav>
        <ul class="nav-links">
            <li><a href="<%= cp %>/index.jsp" class="nav-link-active">Home</a></li>
            <li><a href="<%= cp %>/stories.jsp">Stories</a></li>
            <li><a href="<%= cp %>/petbrowse.jsp">Pet</a></li>
            <li><a href="<%= cp %>/adopt.jsp">Adopt</a></li>
            <li><a href="<%= cp %>/volunteer.jsp">Volunteer</a></li>
            <li><a href="<%= cp %>/my-adoptions">My Adoptions</a></li>

        </ul>
    </nav>

    <div class="right-area">
        <% if (currentUser != null) { %>
            <div class="profile-wrapper">
                <div class="profile-btn" onclick="toggleProfileMenu()">
                    <span class="profile-name">Hello, <%= currentUser.getName() %></span>
                    <div class="profile-icon">👤</div>
                </div>

                <div class="profile-menu" id="profileMenu">
                    <a href="<%= cp %>/profile.jsp">Update Profile</a>
                    <a href="<%= cp %>/LogoutServlet" class="logout">Logout</a>
                </div>
            </div>
        <% } else { %>
            <a href="<%= cp %>/login.jsp" class="btn-outline">Login</a>
            <a href="<%= cp %>/register.jsp" class="btn-outline">Sign Up</a>
        <% } %>
    </div>
</header>

<!-- ===== Your existing homepage content ===== -->
<main class="page-wrapper">
    <!-- keep your existing hero-flex / kitten-card / buttons from your old index.jsp -->
    <!-- If you want, paste your old hero section here unchanged -->
</main>

<footer class="bottom-bar"></footer>

<script>
function toggleProfileMenu(){
    const menu = document.getElementById("profileMenu");
    if(!menu) return;
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}
window.onclick = function(e){
    if(!e.target.closest(".profile-wrapper")){
        const menu = document.getElementById("profileMenu");
        if(menu) menu.style.display = "none";
    }
}
</script>

</body>
</html>

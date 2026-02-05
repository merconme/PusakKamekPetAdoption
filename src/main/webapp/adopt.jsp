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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Pusak Kamek - Adopt</title>
    <link rel="stylesheet" href="<%= cp %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brand-light:#96102b;
            --bg:#f7f7f7;
            --card:#ffffff;
            --shadow:0 10px 30px rgba(0,0,0,0.12);
        }

        body{
            margin:0;
            font-family:'Poppins','Segoe UI',sans-serif;
            background:var(--bg);
            color:#222;
        }

        /* NAVBAR (same style) */
        .navbar {
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding:18px 6%;
            background:linear-gradient(135deg,var(--brand-light),var(--brand));
            color:white;
            box-shadow:var(--shadow);
            position:sticky;
            top:0;
            z-index:1000;
        }

        .logo-text {
            font-weight:800;
            line-height:1.1;
            font-size:18px;
        }
        .logo-text small{
            font-weight:500;
            font-size:11px;
            opacity:.9;
        }

        .navbar nav ul{
            list-style:none;
            display:flex;
            gap:18px;
            margin:0;
            padding:0;
        }
        .navbar nav ul li a{
            color:white;
            text-decoration:none;
            font-weight:600;
            padding:8px 18px;
            border-radius:25px;
            transition:.25s;
        }
        .navbar nav ul li a:hover,
        .nav-link-active{
            background:rgba(255,255,255,0.22);
        }

        /* PROFILE DROPDOWN */
        .profile-wrapper{ position:relative; }
        .profile-btn{
            display:flex;
            align-items:center;
            gap:10px;
            cursor:pointer;
            font-weight:600;
            user-select:none;
        }
        .profile-icon{
            width:36px;
            height:36px;
            border-radius:50%;
            background:rgba(255,255,255,0.2);
            display:flex;
            align-items:center;
            justify-content:center;
        }
        .profile-menu{
            position:absolute;
            right:0;
            top:55px;
            background:white;
            color:#333;
            width:190px;
            border-radius:14px;
            box-shadow:0 10px 30px rgba(0,0,0,0.18);
            display:none;
            overflow:hidden;
        }
        .profile-menu a{
            display:block;
            padding:12px 16px;
            text-decoration:none;
            color:#555;
            font-weight:600;
        }
        .profile-menu a:hover{ background:#f5f5f5; }
        .profile-menu .logout{ color:#b00020; }

        /* PAGE */
        .page-wrapper{
            padding:35px 6% 70px;
        }

        .hero{
            background:linear-gradient(135deg, #ffffff, #fff6f7);
            border-radius:26px;
            box-shadow:var(--shadow);
            padding:28px;
            display:grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap:24px;
            overflow:hidden;
        }

        .hero h1{
            margin:0 0 10px;
            font-size:34px;
            color:var(--brand);
            font-weight:800;
        }

        .hero p{
            margin:0 0 18px;
            color:#555;
            line-height:1.6;
            font-size:14px;
        }

        .hero-actions{
            display:flex;
            gap:12px;
            flex-wrap:wrap;
            margin-top:8px;
        }

        .btn-main{
            display:inline-block;
            padding:12px 18px;
            border-radius:999px;
            text-decoration:none;
            font-weight:800;
            transition:.25s;
        }

        .btn-primary{
            background:var(--brand);
            color:white;
        }
        .btn-primary:hover{ background:var(--brand-light); }

        .btn-ghost{
            border:1px solid rgba(122,0,25,0.35);
            color:var(--brand);
            background:white;
        }
        .btn-ghost:hover{
            background:#fff0f2;
        }

        .hero-card{
            background:radial-gradient(circle at top, var(--brand-light), var(--brand));
            color:white;
            border-radius:22px;
            padding:18px;
            box-shadow:var(--shadow);
            display:flex;
            flex-direction:column;
            justify-content:space-between;
        }
        .hero-card h3{
            margin:0 0 8px;
            font-size:16px;
            font-weight:800;
        }
        .hero-card ul{
            margin:0;
            padding-left:18px;
            font-size:13px;
            line-height:1.6;
            opacity:.95;
        }

        .grid{
            margin-top:22px;
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap:18px;
        }

        .card{
            background:var(--card);
            border-radius:22px;
            box-shadow:var(--shadow);
            padding:18px;
        }

        .card h3{
            margin:0 0 8px;
            color:var(--brand);
            font-size:16px;
            font-weight:800;
        }

        .card p{
            margin:0;
            color:#555;
            font-size:13px;
            line-height:1.6;
        }

        .steps{
            margin-top:22px;
            background:white;
            border-radius:22px;
            box-shadow:var(--shadow);
            padding:18px;
        }

        .steps h2{
            margin:0 0 10px;
            color:var(--brand);
            font-size:18px;
            font-weight:800;
        }

        .step-list{
            display:grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap:14px;
            margin-top:12px;
        }

        .step{
            border:1px solid #eee;
            border-radius:18px;
            padding:14px;
            background:#fff;
        }

        .badge{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            width:28px;
            height:28px;
            border-radius:50%;
            background:#fff0f2;
            color:var(--brand);
            font-weight:800;
            margin-bottom:8px;
        }

        .footer-note{
            margin-top:18px;
            color:#666;
            font-size:12px;
        }

        @media (max-width: 900px){
            .hero{ grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

<!-- ✅ NAVBAR -->
<header class="navbar">
    <div class="logo-text">
        PUSAK KAMEK<br>
        <small>Rescue · Rehome · Rebuild</small>
    </div>

    <nav>
        <ul>
            <li><a href="<%= cp %>/index.jsp">Home</a></li>
            <li><a href="<%= cp %>/stories.jsp">Stories</a></li>
            <li><a href="<%= cp %>/petbrowse.jsp">Pet</a></li>
            <li><a href="<%= cp %>/adopt.jsp" class="nav-link-active">Adopt</a></li>
            <li><a href="<%= cp %>/volunteer.jsp">Volunteer</a></li>
            <li><a href="<%= cp %>/my-adoptions">My Adoptions</a></li>
        </ul>
    </nav>

    <div class="profile-wrapper">
        <div class="profile-btn" onclick="toggleProfile()">
            <span>Hello, <%= currentUser.getName() %></span>
            <div class="profile-icon">👤</div>
        </div>
        <div class="profile-menu" id="profileMenu">
            <a href="<%= cp %>/profile.jsp">Update Profile</a>
            <a href="<%= cp %>/LogoutServlet" class="logout">Logout</a>
        </div>
    </div>
</header>

<main class="page-wrapper">

    <!-- HERO -->
    <section class="hero">
        <div>
            <h1>Adopt a Pet</h1>
            <p>
                Thank you for choosing adoption. When you adopt, you’re giving a rescued pet a second chance at a safe and loving home.
                Follow the steps below, browse pets, and submit your application.
            </p>

            <div class="hero-actions">
                <a class="btn-main btn-primary" href="<%= cp %>/petbrowse.jsp">Browse Pets</a>
                <a class="btn-main btn-ghost" href="<%= cp %>/stories.jsp">Read Success Stories</a>
            </div>

            <div class="footer-note">
                Logged in as <b><%= currentUser.getName() %></b>. Need to update your details? Go to <b>Update Profile</b> in the menu.
            </div>
        </div>

        <div class="hero-card">
            <div>
                <h3>Adoption Requirements</h3>
                <ul>
                    <li>Be responsible and committed</li>
                    <li>Provide safe home environment</li>
                    <li>Agree to follow-up checks</li>
                    <li>Pay adoption fee (if any)</li>
                </ul>
            </div>
            <div style="opacity:.95; font-size:12px; margin-top:10px;">
                Tip: Make sure your contact details are correct before applying.
            </div>
        </div>
    </section>

    <!-- QUICK INFO CARDS -->
    <section class="grid">
        <div class="card">
            <h3>Why Adopt?</h3>
            <p>Adoption saves lives, reduces stray population, and gives animals the care they deserve.</p>
        </div>
        <div class="card">
            <h3>After Adoption</h3>
            <p>We may contact you for updates. Please be open to guidance on feeding, grooming, and health care.</p>
        </div>
        <div class="card">
            <h3>Need Help?</h3>
            <p>If you’re unsure which pet fits your lifestyle, browse pets and message us via your profile/contact page.</p>
        </div>
    </section>

    <!-- STEPS -->
    <section class="steps">
        <h2>How Adoption Works</h2>

        <div class="step-list">
            <div class="step">
                <div class="badge">1</div>
                <div style="font-weight:800;color:#222;margin-bottom:6px;">Browse Pets</div>
                <div style="font-size:13px;color:#555;line-height:1.6;">
                    Go to the pet list and choose a pet you want to adopt.
                </div>
            </div>

            <div class="step">
                <div class="badge">2</div>
                <div style="font-weight:800;color:#222;margin-bottom:6px;">Check Details</div>
                <div style="font-size:13px;color:#555;line-height:1.6;">
                    View pet info such as age, breed, vaccination, and condition.
                </div>
            </div>

            <div class="step">
                <div class="badge">3</div>
                <div style="font-weight:800;color:#222;margin-bottom:6px;">Submit Application</div>
                <div style="font-size:13px;color:#555;line-height:1.6;">
                    Fill in the adoption form (you can link this to your application servlet/page).
                </div>
            </div>

            <div class="step">
                <div class="badge">4</div>
                <div style="font-weight:800;color:#222;margin-bottom:6px;">Review & Approval</div>
                <div style="font-size:13px;color:#555;line-height:1.6;">
                    Admin reviews the application. You’ll be contacted if approved.
                </div>
            </div>
        </div>

        <!-- OPTIONAL BUTTON to your adopt form page -->
        <div style="margin-top:16px; display:flex; gap:12px; flex-wrap:wrap;">
            <a class="btn-main btn-primary" href="<%= cp %>/petbrowse.jsp">Start Adoption</a>
            <!-- If you have a form page later, change this link:
                 <a class="btn-main btn-ghost" href="<%= cp %>/adopt-form.jsp">Adoption Form</a>
            -->
        </div>
    </section>

</main>

<script>
function toggleProfile() {
    const menu = document.getElementById("profileMenu");
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}
window.onclick = function(e) {
    if (!e.target.closest(".profile-wrapper")) {
        const menu = document.getElementById("profileMenu");
        if (menu) menu.style.display = "none";
    }
};
</script>

</body>
</html>

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

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brand2:#96102b;
            --bg:#f6f7fb;
            --card:#ffffff;
            --text:#111827;
            --muted:#6b7280;
            --line:#e5e7eb;
            --shadow:0 10px 30px rgba(0,0,0,0.12);
        }

        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family:'Poppins',system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
            background:var(--bg);
            color:var(--text);
        }

/* ===== NAVBAR (SAME AS INDEX) ===== */
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

nav.links a:hover{
    background:rgba(255,255,255,.18);
    color:#fff;
}

nav.links a.active{
    background:rgba(255,255,255,.30);
    color:#fff;
}

/* right side */
.right{
    display:flex;
    gap:10px;
    align-items:center;
    justify-content:flex-end;
    min-width:230px;
}

/* profile */
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

/* dropdown */
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

@media (max-width: 1000px){
    nav.links{ display:none; } /* hide menu on small screens */
}


        /* ✅ PAGE WRAPPER */
        .container{
            max-width:1200px;
            margin:0 auto;
            padding:26px 18px 70px;
        }

        /* ✅ HERO */
        .hero{
            background:linear-gradient(135deg, #ffffff, #fff6f7);
            border:1px solid rgba(229,231,235,.8);
            border-radius:26px;
            box-shadow:var(--shadow);
            padding:26px;
            display:grid;
            grid-template-columns: 1.15fr 0.85fr;
            gap:18px;
        }
        .hero h1{
            margin:0 0 10px;
            font-size:34px;
            color:var(--brand);
            font-weight:900;
        }
        .hero p{
            margin:0 0 16px;
            color:#555;
            line-height:1.7;
            font-size:14px;
            font-weight:600;
            max-width:65ch;
        }

        .hero-actions{
            display:flex; gap:12px; flex-wrap:wrap;
            margin-top:10px;
        }
        .btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            padding:12px 18px;
            border-radius:999px;
            text-decoration:none;
            font-weight:900;
            font-size:13px;
            transition:.2s;
            border:1px solid transparent;
            cursor:pointer;
        }
        .btn.primary{
            background:linear-gradient(135deg,var(--brand2),var(--brand));
            color:#fff;
            box-shadow:0 12px 26px rgba(122,0,25,.18);
        }
        .btn.primary:hover{ transform:translateY(-1px); }
        .btn.ghost{
            background:#fff;
            border-color:rgba(122,0,25,.30);
            color:var(--brand);
        }
        .btn.ghost:hover{ background:#fff0f2; }

        .note{
            margin-top:14px;
            color:#6b7280;
            font-size:12px;
            font-weight:700;
        }

        /* ✅ RIGHT PANEL (no giant empty maroon) */
        .hero-card{
            background:linear-gradient(135deg,var(--brand2),var(--brand));
            color:#fff;
            border-radius:22px;
            padding:18px;
            box-shadow:var(--shadow);
            border:1px solid rgba(255,255,255,.12);
            display:flex;
            flex-direction:column;
            gap:10px;
            height:100%;
        }
        .hero-card h3{
            margin:0;
            font-size:16px;
            font-weight:900;
        }
        .hero-card ul{
            margin:0;
            padding-left:18px;
            font-size:13px;
            line-height:1.7;
            opacity:.95;
        }
        .hero-tip{
            margin-top:auto;
            font-size:12px;
            opacity:.95;
            background:rgba(255,255,255,.10);
            border:1px solid rgba(255,255,255,.16);
            padding:10px 12px;
            border-radius:14px;
        }

        /* ✅ INFO CARDS */
        .grid{
            margin-top:18px;
            display:grid;
            grid-template-columns:repeat(3, minmax(0,1fr));
            gap:14px;
        }
        .card{
            background:var(--card);
            border:1px solid rgba(229,231,235,.85);
            border-radius:22px;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            padding:18px;
        }
        .card h3{
            margin:0 0 8px;
            color:var(--brand);
            font-size:16px;
            font-weight:900;
        }
        .card p{
            margin:0;
            color:#555;
            font-size:13px;
            line-height:1.7;
            font-weight:600;
        }

        /* ✅ STEPS */
        .steps{
            margin-top:18px;
            background:#fff;
            border:1px solid rgba(229,231,235,.85);
            border-radius:22px;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            padding:18px;
        }
        .steps h2{
            margin:0 0 12px;
            color:var(--brand);
            font-size:18px;
            font-weight:900;
        }
        .step-list{
            display:grid;
            grid-template-columns:repeat(4, minmax(0,1fr));
            gap:14px;
        }
        .step{
            border:1px solid #eee;
            border-radius:18px;
            padding:14px;
            background:#fff;
            min-height:120px;
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
            font-weight:900;
            margin-bottom:8px;
        }
        .step b{ display:block; margin-bottom:6px; }
        .step span{ display:block; font-size:13px; color:#555; line-height:1.6; font-weight:600; }

        .bottom-actions{
            margin-top:14px;
            display:flex;
            gap:12px;
            flex-wrap:wrap;
        }

        @media (max-width: 1000px){
            .hero{ grid-template-columns:1fr; }
            .grid{ grid-template-columns:1fr; }
            .step-list{ grid-template-columns:1fr; }
            .links{ display:none; } /* simple mobile */
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
            <a class="active" href="<%= cp %>/adopt.jsp">Adopt</a>
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
                    <a href="<%= cp %>/profile.jsp">Update Profile</a>
                    <a class="logout" href="<%= cp %>/LogoutServlet">Logout</a>
                </div>
            </div>
        </div>

    </div>
</header>


<main class="container">

    <!-- HERO -->
    <section class="hero">
        <div>
            <h1>Adopt a Pet</h1>
            <p>
                Thank you for choosing adoption. When you adopt, you’re giving a rescued pet a second chance at a safe and loving home.
                Browse pets, choose your favourite, and submit your application.
            </p>

            <div class="hero-actions">
                <a class="btn primary" href="<%= cp %>/petbrowse.jsp">🐾 Browse Pets</a>
                <a class="btn ghost" href="<%= cp %>/stories.jsp">📖 Read Success Stories</a>
            </div>

            <div class="note">
                Logged in as <b><%= currentUser.getName() %></b>. Update your info in <b>Update Profile</b>.
            </div>
        </div>

        <aside class="hero-card">
            <h3>Adoption Requirements</h3>
            <ul>
                <li>Be responsible and committed</li>
                <li>Provide a safe home environment</li>
                <li>Agree to follow-up checks</li>
                <li>Pay adoption fee (if any)</li>
            </ul>

            <div class="hero-tip">
                Tip: Make sure your contact details are correct before applying.
            </div>
        </aside>
    </section>

    <!-- QUICK INFO -->
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
            <p>If you’re unsure which pet fits your lifestyle, browse pets and contact us from your profile/contact page.</p>
        </div>
    </section>

    <!-- STEPS -->
    <section class="steps">
        <h2>How Adoption Works</h2>

        <div class="step-list">
            <div class="step">
                <div class="badge">1</div>
                <b>Browse Pets</b>
                <span>Go to the pet list and choose a pet you want to adopt.</span>
            </div>

            <div class="step">
                <div class="badge">2</div>
                <b>Check Details</b>
                <span>View pet info such as age, breed, vaccination, and condition.</span>
            </div>

            <div class="step">
                <div class="badge">3</div>
                <b>Submit Application</b>
                <span>Fill in the adoption form and submit your request.</span>
            </div>

            <div class="step">
                <div class="badge">4</div>
                <b>Review & Approval</b>
                <span>Admin reviews the application. You’ll be contacted if approved.</span>
            </div>
        </div>

        <div class="bottom-actions">
            <a class="btn primary" href="<%= cp %>/petbrowse.jsp">Start Adoption</a>
        </div>
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

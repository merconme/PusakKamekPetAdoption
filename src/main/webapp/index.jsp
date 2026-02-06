<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.pusakkamek.model.User" %>
<%@ page import="com.pusakkamek.model.Pet" %>
<%@ page import="com.pusakkamek.dao.PetDAO" %>
<%@ page import="com.pusakkamek.dao.AdoptionDAO" %>
<%@ page import="com.pusakkamek.dao.VolunteerDAO" %>

<%
    String cp = request.getContextPath();
    User currentUser = (User) session.getAttribute("currentUser");

    // ✅ Build hero image URL once (more reliable in CSS)
    String heroImg = cp + "/images/img1.png";

    // success toast
    String loginMsg = (String) session.getAttribute("loginSuccess");
    if (loginMsg != null) session.removeAttribute("loginSuccess");

    int availablePets = 0;
    int successfulAdoptions = 0;
    int activeVolunteers = 0;
    List<Pet> featuredPets = new ArrayList<>();

    try {
        PetDAO petDAO = new PetDAO();
        AdoptionDAO adoptionDAO = new AdoptionDAO();
        VolunteerDAO volunteerDAO = new VolunteerDAO();

        availablePets = petDAO.countAvailablePets();
        successfulAdoptions = adoptionDAO.countSuccessfulAdoptions();
        // activeVolunteers = volunteerDAO.countActiveVolunteers(); // enable when you have DAO method

        featuredPets = petDAO.getLatestAvailablePets(6);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Home</title>
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
            --shadow:0 12px 35px rgba(0,0,0,.10);
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family:'Poppins',system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
            background:var(--bg);
            color:var(--text);
        }

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

/* RIGHT SIDE */
.right{
    display:flex;
    gap:10px;
    align-items:center;
    justify-content:flex-end;
    min-width:230px;
}

/* BUTTONS */
.btn{
    border:1px solid rgba(255,255,255,.45);
    background:transparent;
    padding:10px 14px;
    border-radius:999px;
    font-weight:900;
    font-size:12px;
    text-decoration:none;
    color:#fff;
    transition:.15s;
}

.btn:hover{
    background:rgba(255,255,255,.20);
    border-color:rgba(255,255,255,.75);
}

.btn.primary{
    background:#fff;
    color:var(--brand);
    border-color:#fff;
    box-shadow:0 8px 22px rgba(0,0,0,.25);
}

/* PROFILE */
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

/* DROPDOWN MENU (keep white for contrast) */
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

        /* CONTENT */
        .container{
            max-width:1200px;
            margin:0 auto;
            padding:22px 18px 70px;
        }

        /* ✅ SUCCESS TOAST */
        .toast{
            max-width:1200px;
            margin:14px auto 0;
            padding:14px 16px;
            border-radius:16px;
            background:linear-gradient(135deg,#e8f7ee,#f4fbf7);
            color:#0b5f16;
            font-weight:900;
            font-size:13px;
            border:1px solid rgba(11,95,22,.15);
            box-shadow:0 12px 28px rgba(0,0,0,.10);
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:12px;
            animation:toastDrop .35s ease;
        }
        .toast .left{ display:flex; align-items:center; gap:10px; }
        .toast .icon{
            width:30px;height:30px;border-radius:10px;
            display:flex;align-items:center;justify-content:center;
            background:rgba(11,95,22,.10);
            font-size:14px;
        }
        .toast .close{
            border:none;background:transparent;cursor:pointer;
            font-weight:900;font-size:14px;color:#0b5f16;
            opacity:.7;padding:6px 8px;border-radius:10px;
        }
        .toast .close:hover{ opacity:1; background:rgba(11,95,22,.08); }
        @keyframes toastDrop{
            from{ opacity:0; transform:translateY(-10px); }
            to{ opacity:1; transform:translateY(0); }
        }

        /* ✅ HERO (image fixed) */
        .hero{
            border-radius:26px;
            overflow:hidden;
            box-shadow:var(--shadow);
            min-height:54vh;

 background-image:
  linear-gradient(90deg, rgba(0,0,0,.35), rgba(0,0,0,.10)),
  url('<%= cp %>/images/img1.png');


            background-size:cover;
            background-position:center;
            background-repeat:no-repeat;

            position:relative;
        }

        .hero-inner{ padding:64px 6%; max-width:760px; color:#fff; }
        .badge{
            display:inline-flex; align-items:center; gap:10px;
            padding:10px 14px; border-radius:999px;
            background:rgba(255,255,255,.18);
            border:1px solid rgba(255,255,255,.24);
            font-weight:900; font-size:12px;
        }
        .dot{ width:10px;height:10px;border-radius:50%;background:#fff; box-shadow:0 0 0 6px rgba(255,255,255,.10); }
        .hero h1{ margin:16px 0 10px; font-size:44px; line-height:1.05; font-weight:900; }
        .hero p{ margin:0; font-size:15px; line-height:1.7; font-weight:600; opacity:.95; }
        .hero-actions{ margin-top:22px; display:flex; gap:12px; flex-wrap:wrap; }
        .cta{
            display:inline-flex; align-items:center; gap:10px;
            padding:12px 18px; border-radius:999px;
            font-weight:900; font-size:13px; text-decoration:none;
            transition:.15s;
        }
        .cta.primary{ background:linear-gradient(135deg,var(--brand2),var(--brand)); color:#fff; box-shadow:0 12px 26px rgba(122,0,25,.20); }
        .cta.ghost{ background:rgba(255,255,255,.90); color:var(--brand); }
        .cta:hover{ transform:translateY(-1px); }

        .stats{
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(210px,1fr));
            gap:14px;
            margin-top:18px;
        }
        .stat{
            background:#fff;
            border:1px solid var(--line);
            border-radius:20px;
            padding:22px;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            text-align:center;
        }
        .stat b{ display:block; font-size:28px; color:var(--brand); letter-spacing:.4px; }
        .stat span{ display:block; margin-top:6px; font-weight:900; color:#666; font-size:12px; }

        .head{ text-align:center; margin:56px 0 18px; }
        .head h2{ margin:0 0 8px; font-size:28px; }
        .head p{ margin:0; color:#666; font-weight:700; font-size:13px; }

        .grid2{ display:grid; grid-template-columns:1fr 1fr; gap:16px; }
        .card{
            background:#fff; border:1px solid var(--line);
            border-radius:22px; padding:26px;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
        }
        .card h3{ margin:0 0 10px; color:var(--brand); font-size:18px; }
        .card p{ margin:0; color:#555; font-weight:600; line-height:1.7; font-size:13px; }

        .pet-grid{
            display:grid;
            grid-template-columns:repeat(auto-fit, minmax(240px,1fr));
            gap:16px;
        }
        .pet-card{
            background:#fff; border:1px solid var(--line);
            border-radius:22px; overflow:hidden;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            transition:.18s;
        }
        .pet-card:hover{ transform:translateY(-4px); }
        .pet-card img{ width:100%; height:200px; object-fit:cover; background:#eee; }
        .pet-info{ padding:18px; }
        .pet-info h3{ margin:0 0 8px; color:var(--brand); }
        .meta{ margin:0 0 12px; color:#666; font-weight:900; font-size:12px; }
        .pill{
            display:inline-flex; padding:10px 14px;
            border-radius:999px; font-weight:900; font-size:12px;
            text-decoration:none; color:var(--brand);
            border:1px solid rgba(122,0,25,.22);
        }
        .pill:hover{ background:#fdf0f1; }
        .center{ display:flex; justify-content:center; margin-top:18px; }

        .footer{ margin-top:34px; text-align:center; color:#777; font-weight:700; font-size:12px; }

        @media(max-width: 900px){
            .grid2{ grid-template-columns:1fr; }
            .hero h1{ font-size:34px; }
            nav.links{ display:none; }
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
            <a class="active" href="<%= cp %>/index.jsp">Home</a>
            <a href="<%= cp %>/stories">Stories</a>
            <a href="<%= cp %>/petbrowse.jsp">Pet</a>
            <a href="<%= cp %>/adopt.jsp">Adopt</a>
            <a href="<%= cp %>/volunteer.jsp">Volunteer</a>
            <a href="<%= cp %>/donation.jsp">Donation</a>
            <a href="<%= cp %>/my-adoptions">My Adoptions</a>
        </nav>

        <div class="right">
            <% if (currentUser != null) { %>
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
            <% } else { %>
                <a class="btn" href="<%= cp %>/login.jsp">Login</a>
                <a class="btn primary" href="<%= cp %>/register.jsp">Sign Up</a>
            <% } %>
        </div>
    </div>
</header>

<% if (loginMsg != null) { %>
    <div class="toast" id="toastSuccess">
        <div class="left">
            <div class="icon">✅</div>
            <div><%= loginMsg %></div>
        </div>
        <button class="close" type="button" onclick="closeToast()">✕</button>
    </div>
<% } %>

<div class="container">

    <!-- Optional Debug (uncomment to verify hero image URL) -->
    <%-- <p>Hero URL: <%= heroImg %></p> --%>
    <%-- <img src="<%= heroImg %>" style="width:220px;border:4px solid lime;"> --%>

    <section class="hero">
        <div class="hero-inner">
            <div class="badge"><span class="dot"></span> PUSAK KAMEK • ADOPTION & CARE</div>
            <h1>Give them a second chance at life.</h1>
            <p>
                We rescue abandoned animals, provide medical care and rehabilitation,
                then match them with loving forever homes.
            </p>
            <div class="hero-actions">
                <a class="cta primary" href="<%= cp %>/petbrowse.jsp">🐾 Browse Pets</a>
                <a class="cta ghost" href="<%= cp %>/adopt.jsp">📄 Adopt Now</a>
                <a class="cta ghost" href="<%= cp %>/volunteer.jsp">🤍 Volunteer</a>
            </div>
        </div>
    </section>

    <section class="stats">
        <div class="stat"><b><%= availablePets %></b><span>Pets Available</span></div>
        <div class="stat"><b><%= successfulAdoptions %></b><span>Successful Adoptions</span></div>
        <div class="stat"><b><%= activeVolunteers %></b><span>Active Volunteers</span></div>
        <div class="stat"><b><%= (availablePets + successfulAdoptions) %></b><span>Total Listings</span></div>
    </section>

    <div class="head">
        <h2>What We Stand For</h2>
        <p>Rescue with love. Rehome with care. Rebuild hope.</p>
    </div>

    <section class="grid2">
        <div class="card">
            <h3>🌱 Our Mission</h3>
            <p>
                To rescue abandoned and abused animals, provide medical care and rehabilitation,
                and place them into safe and loving forever homes.
            </p>
        </div>
        <div class="card">
            <h3>🌍 Our Vision</h3>
            <p>
                A compassionate community where every animal is treated with dignity,
                kindness, and respect — and no life is left behind.
            </p>
        </div>
    </section>

    <div class="head">
        <h2>Pets Available Right Now</h2>
        <p>Latest available pets pulled from your database.</p>
    </div>

    <section class="pet-grid">
        <%
            if (featuredPets == null || featuredPets.isEmpty()) {
        %>
            <div class="card" style="grid-column:1/-1; text-align:center;">
                <h3 style="margin-bottom:6px;">No pets available</h3>
                <p>When admin adds pets with status AVAILABLE, they will appear here automatically.</p>
            </div>
        <%
            } else {
                for (Pet p : featuredPets) {
                    String img = (p.getImageUrl() == null || p.getImageUrl().trim().isEmpty())
                            ? "no-image.png"
                            : p.getImageUrl();
        %>
            <div class="pet-card">
                <img src="<%= cp %>/images/<%= img %>" alt="<%= p.getName() %>">
                <div class="pet-info">
                    <h3><%= p.getName() %></h3>
                    <p class="meta">
                        <%= p.getSpecies() %>
                        <% if (p.getBreed() != null && !p.getBreed().trim().isEmpty()) { %>
                            · <%= p.getBreed() %>
                        <% } %>
                        · Age: <%= p.getAge() %>
                    </p>
                    <a class="pill" href="<%= cp %>/petbrowse.jsp">View Details →</a>
                </div>
            </div>
        <%
                }
            }
        %>
    </section>

    <div class="center">
        <a class="btn primary" href="<%= cp %>/petbrowse.jsp">See All Pets</a>
    </div>

    <div class="footer">
        © <%= java.time.Year.now() %> Pusak Kamek • Rescue · Rehome · Rebuild
    </div>

</div>

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

/* ✅ Toast close + auto hide */
function closeToast(){
    const t = document.getElementById("toastSuccess");
    if(t) t.style.display = "none";
}
setTimeout(() => closeToast(), 3000);
</script>

</body>
</html>

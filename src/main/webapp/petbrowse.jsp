<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.pusakkamek.dao.PetDAO" %>
<%@ page import="com.pusakkamek.model.Pet" %>
<%@ page import="com.pusakkamek.model.User" %>

<%
    // ✅ Login check
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String cp = request.getContextPath();

    PetDAO petDAO = new PetDAO();
    String query = request.getParameter("search");
    List<Pet> pets;

    if (query != null && !query.trim().isEmpty()) {
        pets = petDAO.searchPets(query.trim());
    } else {
        pets = petDAO.getAllPets();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Pets - Pusak Kamek</title>
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
            background:
                radial-gradient(900px 520px at 18% 10%, rgba(122,0,25,.08), transparent 60%),
                radial-gradient(900px 520px at 85% 15%, rgba(150,16,43,.06), transparent 55%),
                linear-gradient(180deg, #fafafa, var(--bg));
            color:var(--text);
        }

        /* ===== NAVBAR (SAME LAYOUT AS INDEX) ===== */
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
        .brandBox{
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
            content:""; position:absolute;
            width:18px;height:18px;border-radius:50%;
            background:rgba(255,255,255,.55);
            top:-6px; right:-6px;
        }
        .brand-txt b{
            display:block; font-size:14px; letter-spacing:.5px; color:#fff;
        }
        .brand-txt small{
            display:block; font-size:11px; font-weight:700;
            margin-top:3px; color:rgba(255,255,255,.85);
        }

        nav.links{ display:flex; gap:10px; flex:1; justify-content:center; }
        nav.links a{
            padding:10px 14px;
            font-size:12px; font-weight:900;
            color:#fff; text-decoration:none;
            border-radius:999px; transition:.15s;
        }
        nav.links a:hover{ background:rgba(255,255,255,.18); }
        nav.links a.active{ background:rgba(255,255,255,.30); }

        .right{
            display:flex; gap:10px; align-items:center; justify-content:flex-end;
            min-width:230px;
        }

        .profile{ position:relative; }
        .profile-btn{
            display:flex; align-items:center; gap:10px;
            border:1px solid rgba(255,255,255,.45);
            background:rgba(255,255,255,.10);
            padding:7px 10px;
            border-radius:999px;
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
            border-radius:16px; box-shadow:var(--shadow);
            overflow:hidden; display:none;
        }
        .menu a{
            display:block; padding:12px 14px;
            text-decoration:none; font-weight:900; font-size:13px;
            color:#444;
        }
        .menu a:hover{ background:#f5f5f5; }
        .menu a.logout{ color:#b00020; }

        /* ===== PAGE ===== */
        .container{
            max-width:1200px;
            margin:0 auto;
            padding:22px 18px 70px;
        }

        .topbar{
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            gap:14px;
            margin:8px 0 18px;
        }

        .title h1{
            margin:0;
            font-size:30px;
            font-weight:900;
            letter-spacing:.2px;
        }
        .title p{
            margin:6px 0 0;
            color:var(--muted);
            font-weight:700;
            font-size:13px;
        }

        /* Search bar */
        .searchWrap{
            margin-top:14px;
            background:#fff;
            border:1px solid rgba(229,231,235,.9);
            border-radius:18px;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            padding:14px;
            display:flex;
            gap:12px;
            align-items:center;
        }
        .searchWrap .icon{
            width:42px;height:42px;border-radius:14px;
            display:flex;align-items:center;justify-content:center;
            background:rgba(122,0,25,.08);
            font-size:18px;
        }
        .searchWrap input{
            width:100%;
            border:none;
            outline:none;
            font-size:14px;
            font-weight:700;
        }
        .searchWrap button{
            border:none;
            cursor:pointer;
            background:linear-gradient(135deg,var(--brand2),var(--brand));
            color:#fff;
            font-weight:900;
            padding:12px 18px;
            border-radius:999px;
            transition:.2s;
            box-shadow:0 12px 26px rgba(122,0,25,.18);
            white-space:nowrap;
        }
        .searchWrap button:hover{ transform:translateY(-1px); }
        .clearLink{
            text-decoration:none;
            font-weight:900;
            font-size:12px;
            color:var(--brand);
            padding:10px 12px;
            border-radius:999px;
            border:1px solid rgba(122,0,25,.20);
            background:#fff;
            white-space:nowrap;
        }
        .clearLink:hover{ background:#fff0f2; }

        /* Pets grid */
        .pet-grid{
            display:grid;
            grid-template-columns:repeat(auto-fill, minmax(260px, 1fr));
            gap:18px;
            margin-top:18px;
        }
        .pet-card{
            background:var(--card);
            border-radius:22px;
            overflow:hidden;
            border:1px solid rgba(229,231,235,.9);
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            transition:.18s;
            text-decoration:none;
            color:inherit;
            display:flex;
            flex-direction:column;
        }
        .pet-card:hover{ transform:translateY(-5px); box-shadow:0 16px 35px rgba(0,0,0,.10); }

        .pet-card img{
            width:100%;
            height:200px;
            object-fit:cover;
            background:#eee;
            display:block;
        }
        .pet-body{ padding:16px; display:flex; flex-direction:column; gap:10px; }
        .pet-name{
            margin:0;
            font-size:18px;
            font-weight:900;
            color:var(--brand);
            text-transform:capitalize;
        }
        .tags{ display:flex; flex-wrap:wrap; gap:8px; }
        .tag{
            display:inline-flex;
            align-items:center;
            gap:6px;
            padding:6px 10px;
            border-radius:999px;
            font-size:11px;
            font-weight:900;
            background:#f3f4f6;
            color:#111;
        }
        .meta{
            font-size:13px;
            color:#555;
            font-weight:700;
            line-height:1.6;
        }
        .viewBtn{
            margin-top:auto;
            display:inline-flex;
            justify-content:center;
            align-items:center;
            gap:8px;
            padding:11px 14px;
            border-radius:14px;
            font-weight:900;
            font-size:12px;
            border:1px solid rgba(122,0,25,.22);
            color:var(--brand);
            background:#fff;
            text-decoration:none;
            transition:.15s;
        }
        .pet-card:hover .viewBtn{ background:#fff0f2; }

        .empty{
            margin-top:18px;
            background:#fff;
            border-radius:18px;
            padding:18px;
            border:1px solid rgba(229,231,235,.9);
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            color:#555;
            font-weight:700;
        }
        .empty b{ color:var(--brand); }

        @media (max-width: 1000px){
            nav.links{ display:none; }
            .topbar{ flex-direction:column; align-items:flex-start; }
        }
    </style>
</head>

<body>

<header class="navbar">
    <div class="nav-wrap">
        <div class="brandBox">
            <div class="logo"></div>
            <div class="brand-txt">
                <b>PUSAK KAMEK</b>
                <small>Rescue · Rehome · Rebuild</small>
            </div>
        </div>

        <nav class="links">
            <a href="<%= cp %>/index.jsp">Home</a>
            <a href="<%= cp %>/stories">Stories</a>
            <a class="active" href="<%= cp %>/petbrowse.jsp">Pet</a>
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
                    <a href="<%= cp %>/profile.jsp">Update Profile</a>
                    <a class="logout" href="<%= cp %>/LogoutServlet">Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<main class="container">

    <div class="topbar">
        <div class="title">
            <h1>Browse Pets</h1>
            <p>Search and view adoptable pets available right now.</p>
        </div>
    </div>

    <!-- Search -->
    <form method="get" action="<%= cp %>/petbrowse.jsp" class="searchWrap">
        <div class="icon">🔎</div>

        <input type="text" name="search"
               placeholder="Search by name, species or breed..."
               value="<%= (query != null) ? query : "" %>">

        <% if (query != null && !query.trim().isEmpty()) { %>
            <a class="clearLink" href="<%= cp %>/petbrowse.jsp">Clear</a>
        <% } %>

        <button type="submit">Search</button>
    </form>

    <!-- Pets -->
    <% if (pets == null || pets.isEmpty()) { %>
        <div class="empty">
            No pets found for <b><%= (query != null && !query.trim().isEmpty()) ? query : "your search" %></b>.
            Try another keyword.
        </div>
    <% } else { %>
        <div class="pet-grid">
            <% for (Pet pet : pets) {

                String safeImg = (pet.getImageUrl() == null) ? "" : pet.getImageUrl().trim();
                if (safeImg.isEmpty()) safeImg = "no-image.png";
            %>

            <a class="pet-card" href="<%= cp %>/pet?id=<%= pet.getId() %>">

                <img src="<%= cp %>/images/<%= URLEncoder.encode(safeImg, "UTF-8") %>"
                     alt="<%= pet.getName() %>"
                     onerror="this.onerror=null;this.src='<%= cp %>/images/no-image.png';">

                <div class="pet-body">
                    <h3 class="pet-name"><%= pet.getName() %></h3>

                    <div class="tags">
                        <span class="tag">🐾 <%= pet.getSpecies() %></span>
                        <span class="tag">🎂 <%= pet.getAge() %> years</span>
                        <% if (pet.getVaccinationStatus() != null && !pet.getVaccinationStatus().trim().isEmpty()) { %>
                            <span class="tag">💉 <%= pet.getVaccinationStatus() %></span>
                        <% } %>
                    </div>

                    <div class="meta">
                        Breed: <%= (pet.getBreed() != null && !pet.getBreed().trim().isEmpty()) ? pet.getBreed() : "-" %>
                    </div>

                    <span class="viewBtn">View Details →</span>
                </div>

            </a>
            <% } %>
        </div>
    <% } %>

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

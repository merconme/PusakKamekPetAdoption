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
            --brandLight:#96102b;
            --bg:#f7f7f7;
            --card:#ffffff;
            --shadow:0 10px 30px rgba(0,0,0,0.12);
            --soft:rgba(255,255,255,0.18);
        }

        body{
            margin:0;
            font-family:'Poppins','Segoe UI',sans-serif;
            background:var(--bg);
        }

        /* ===== NAVBAR ===== */
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
        .nav-links a:hover{ background:var(--soft); }
        .nav-link-active{ background:rgba(255,255,255,0.26); }

        .right-area{
            display:flex;
            align-items:center;
            gap:10px;
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
        .profile-name{ font-weight:700; font-size:12.5px; white-space:nowrap; }

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

        /* ===== PAGE ===== */
        .page-wrapper{
            padding:28px 6% 55px;
        }

        .page-title{
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            gap:15px;
            margin:10px 0 18px;
        }
        .page-title h1{
            margin:0;
            color:#222;
            font-size:28px;
            font-weight:800;
        }
        .page-title p{
            margin:6px 0 0;
            color:#666;
            font-size:13px;
        }

        /* Search */
        .search-container{
            display:flex;
            justify-content:center;
            margin:22px 0 30px;
        }
        .search-box{
            width:100%;
            max-width:560px;
            display:flex;
            gap:10px;
            align-items:center;
            background:white;
            padding:10px 12px;
            border-radius:45px;
            box-shadow:var(--shadow);
        }
        .search-box input{
            width:100%;
            border:none;
            outline:none;
            font-size:14px;
            padding:10px 10px;
        }
        .search-box button{
            border:none;
            cursor:pointer;
            background:var(--brand);
            color:white;
            font-weight:800;
            padding:10px 16px;
            border-radius:35px;
            transition:.25s;
        }
        .search-box button:hover{ background:var(--brandLight); }

        /* Grid */
        .pet-grid{
            display:grid;
            grid-template-columns:repeat(auto-fill, minmax(260px, 1fr));
            gap:28px;
        }

        .pet-card{
            background:var(--card);
            border-radius:24px;
            overflow:hidden;
            box-shadow:var(--shadow);
            transition:.25s;
        }
        .pet-card:hover{ transform:translateY(-6px); }

        .pet-card img{
            width:100%;
            height:200px;
            object-fit:cover;
            background:#eee;
            display:block;
        }

        .pet-card-content{
            padding:18px;
        }

        .pet-card h3{
            margin:0 0 10px;
            color:var(--brand);
            font-size:18px;
            font-weight:800;
            text-transform:capitalize;
        }

        .pet-meta{
            font-size:13px;
            color:#555;
            margin-bottom:6px;
        }

        .pet-tag{
            display:inline-block;
            padding:5px 12px;
            border-radius:999px;
            font-size:11px;
            font-weight:800;
            background:#f2f2f2;
            margin-right:6px;
            margin-bottom:6px;
        }

        .empty{
            background:white;
            border-radius:20px;
            padding:24px;
            box-shadow:var(--shadow);
            color:#555;
        }
        .empty b{ color:var(--brand); }
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
         <li><a href="<%= cp %>/index.jsp">Home</a></li>
            <li><a href="<%= cp %>/stories.jsp">Stories</a></li>
            <li><a href="<%= cp %>/petbrowse.jsp">Pet</a></li>
            <li><a href="<%= cp %>/adopt.jsp" class="nav-link-active">Adopt</a></li>
            <li><a href="<%= cp %>/volunteer.jsp">Volunteer</a></li>
            <li><a href="<%= cp %>/my-adoptions">My Adoptions</a></li>
        </ul>
    </nav>

    <div class="right-area">
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
    </div>
</header>

<main class="page-wrapper">

    <div class="page-title">
        <div>
            <h1>Browse Pets</h1>
            <p>Search and view adoptable pets available right now.</p>
        </div>
        <div style="color:#666;font-size:13px;">
            Logged in as <b><%= currentUser.getName() %></b>
        </div>
    </div>

    <!-- ✅ Search -->
    <form class="search-container" method="get" action="<%= cp %>/petbrowse.jsp">
        <div class="search-box">
            <input type="text" name="search"
                   placeholder="Search by name, species or breed..."
                   value="<%= (query != null) ? query : "" %>">
            <button type="submit">Search</button>
        </div>
    </form>

    <!-- ✅ Pets -->
    <% if (pets == null || pets.isEmpty()) { %>
        <div class="empty">
            No pets found for <b><%= (query != null && !query.isEmpty()) ? query : "your search" %></b>.
            Try another keyword.
        </div>
    <% } else { %>
        <div class="pet-grid">
            <% for (Pet pet : pets) { %>
            <a href="<%= cp %>/pet?id=<%= pet.getId() %>" style="text-decoration:none; color:inherit;">

                <div class="pet-card">
                    <!-- ✅ FIXED: use your ImageServlet mapping /images/* -->
                    <img src="<%= cp %>/images/<%= URLEncoder.encode(pet.getImageUrl(), "UTF-8") %>"
                         alt="<%= pet.getName() %>">

                    <div class="pet-card-content">
                        <h3><%= pet.getName() %></h3>

                        <div class="pet-meta">
                            <span class="pet-tag"><%= pet.getSpecies() %></span>
                            <span class="pet-tag"><%= pet.getAge() %> years</span>
                        </div>

                        <div class="pet-meta">Breed: <%= (pet.getBreed() != null && !pet.getBreed().isEmpty()) ? pet.getBreed() : "-" %></div>
                        <div class="pet-meta">Vaccinated: <%= (pet.getVaccinationStatus() != null && !pet.getVaccinationStatus().isEmpty()) ? pet.getVaccinationStatus() : "-" %></div>
                    </div>
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
    if(!e.target.closest(".profile-wrapper")){
        const menu = document.getElementById("profileMenu");
        if(menu) menu.style.display = "none";
    }
}
</script>

</body>
</html>

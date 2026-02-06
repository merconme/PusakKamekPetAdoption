<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pusakkamek.model.User" %>
<%@ page import="com.pusakkamek.model.Pet" %>
<%@ page import="java.net.URLEncoder" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if(currentUser == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String cp = request.getContextPath();
    Pet pet = (Pet) request.getAttribute("pet");
    if(pet == null){
        response.sendRedirect(cp + "/petbrowse.jsp");
        return;
    }

    String ok = request.getParameter("ok");
    String err = request.getParameter("err");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adopt <%= pet.getName() %> - Pusak Kamek</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brandLight:#96102b;
            --shadow:0 10px 30px rgba(0,0,0,0.12);
            --soft:rgba(255,255,255,0.18);
        }
        body{ margin:0; font-family:'Poppins',sans-serif; background:#f7f7f7; }

        /* Navbar */
        .navbar{
            display:flex; justify-content:space-between; align-items:center;
            padding:14px 6%;
            background:linear-gradient(135deg,var(--brandLight),var(--brand));
            color:#fff; box-shadow:var(--shadow);
            position:sticky; top:0; z-index:1000;
        }
        .logo-text{ font-weight:800; font-size:16px; line-height:1.05; }
        .logo-text small{ display:block; font-weight:500; font-size:11px; opacity:.9; margin-top:3px; }
        .nav-links{ list-style:none; display:flex; gap:14px; margin:0; padding:0; }
        .nav-links a{
            color:white; text-decoration:none; font-weight:600; font-size:13px;
            padding:8px 14px; border-radius:999px; transition:.25s;
        }
        .nav-links a:hover{ background:var(--soft); }
        .nav-link-active{ background:rgba(255,255,255,0.26); }

        /* Layout */
        .wrap{ padding:26px 6% 60px; }
        .grid{
            display:grid;
            grid-template-columns: 1.1fr 0.9fr;
            gap:24px;
            align-items:start;
        }
        .card{
            background:#fff;
            border-radius:22px;
            box-shadow:var(--shadow);
            overflow:hidden;
        }
        .pet-img{
            width:100%;
            height:360px;
            object-fit:cover;
            display:block;
            background:#eee;
        }
        .pet-info{ padding:18px; }
        .pet-info h1{ margin:0 0 10px; color:var(--brand); font-size:28px; }
        .tag{
            display:inline-block;
            padding:6px 12px;
            border-radius:999px;
            background:#f2f2f2;
            font-size:12px;
            font-weight:800;
            margin-right:8px;
            margin-bottom:8px;
        }
        .meta{ color:#555; font-size:14px; margin:6px 0; }

        /* Form */
        .form{ padding:18px; }
        .form h2{ margin:0 0 10px; color:#222; font-size:18px; }
        .row{ display:grid; grid-template-columns:1fr 1fr; gap:12px; }
        .group{ margin:10px 0; }
        label{ display:block; font-size:12px; font-weight:800; color:#777; margin-bottom:6px; text-transform:uppercase; }
        input, textarea{
            width:100%;
            padding:12px;
            border-radius:12px;
            border:1px solid #ddd;
            font-family:inherit;
            outline:none;
        }
        textarea{ min-height:120px; resize:vertical; }
        input:focus, textarea:focus{
            border-color:var(--brand);
            box-shadow:0 0 0 2px rgba(122,0,25,0.12);
        }
        .btn{
            width:100%;
            border:none;
            background:var(--brand);
            color:white;
            padding:14px;
            border-radius:14px;
            font-weight:900;
            cursor:pointer;
            transition:.25s;
            margin-top:6px;
        }
        .btn:hover{ background:var(--brandLight); }

        .msg{
            margin:0 0 12px;
            padding:12px 14px;
            border-radius:14px;
            font-weight:800;
        }
        .ok{ background:rgba(0,255,0,0.12); border:1px solid rgba(0,255,0,0.2); color:#0b5f16; }
        .bad{ background:rgba(255,0,0,0.12); border:1px solid rgba(255,0,0,0.2); color:#8b0000; }

        @media(max-width:900px){
            .grid{ grid-template-columns:1fr; }
            .pet-img{ height:260px; }
            .row{ grid-template-columns:1fr; }
        }
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
            <a href="<%= cp %>/donation.jsp">Donation</a>
            <li><a href="<%= cp %>/my-adoptions">My Adoptions</a></li>
        </ul>
    </nav>
</header>

<div class="wrap">

    <div style="margin-bottom:14px;">
        <a href="<%= cp %>/petbrowse.jsp" style="text-decoration:none;color:var(--brand);font-weight:900;">← Back to Pet Browse</a>
    </div>

    <div class="grid">

        <!-- LEFT: Pet Details -->
        <div class="card">
            <img class="pet-img"
                 src="<%= cp %>/images/<%= URLEncoder.encode(pet.getImageUrl(), "UTF-8") %>"
                 alt="<%= pet.getName() %>">

            <div class="pet-info">
                <h1><%= pet.getName() %></h1>

                <span class="tag"><%= pet.getSpecies() %></span>
                <span class="tag"><%= pet.getAge() %> years</span>
                <span class="tag"><%= pet.getStatus() %></span>

                <div class="meta"><b>Breed:</b> <%= (pet.getBreed()!=null && !pet.getBreed().isEmpty()) ? pet.getBreed() : "-" %></div>
                <div class="meta"><b>Vaccination:</b> <%= (pet.getVaccinationStatus()!=null && !pet.getVaccinationStatus().isEmpty()) ? pet.getVaccinationStatus() : "-" %></div>
                <div class="meta"><b>Condition:</b> <%= (pet.getCondition()!=null && !pet.getCondition().isEmpty()) ? pet.getCondition() : "-" %></div>
                <div class="meta"><b>Neutered:</b> <%= (pet.getNeutered()!=null && !pet.getNeutered().isEmpty()) ? pet.getNeutered() : "-" %></div>
                <div class="meta"><b>Color:</b> <%= (pet.getColor()!=null && !pet.getColor().isEmpty()) ? pet.getColor() : "-" %></div>
            </div>
        </div>

        <!-- RIGHT: Adoption Form -->
        <div class="card">
            <div class="form">

                <% if(ok != null){ %>
                    <div class="msg ok">✅ Application submitted! Status: PENDING</div>
                <% } %>
                <% if(err != null){ %>
                    <div class="msg bad">❌ Failed to submit application. Try again.</div>
                <% } %>

                <h2>Adoption Application</h2>
                <p style="margin:0 0 14px;color:#666;font-size:13px;">
                    Fill in the form below to apply to adopt <b><%= pet.getName() %></b>.
                </p>

                <form action="<%= cp %>/adopt/apply" method="post">
                    <input type="hidden" name="petId" value="<%= pet.getId() %>">

                    <div class="group">
                        <label>Full Name</label>
                        <input type="text" name="fullName" required value="<%= currentUser.getName() %>">
                    </div>

                    <div class="row">
                        <div class="group">
                            <label>Phone</label>
                            <input type="text" name="phone" required>
                        </div>
                        <div class="group">
                            <label>Email</label>
                            <input type="email" name="email" required value="<%= currentUser.getEmail() %>">
                        </div>
                    </div>

                    <div class="group">
                        <label>Address</label>
                        <input type="text" name="address" required>
                    </div>

                    <div class="group">
                        <label>Why do you want to adopt?</label>
                        <textarea name="reason" required placeholder="Tell us about your home environment and why you want this pet..."></textarea>
                    </div>

                    <button class="btn" type="submit">Submit Application</button>
                </form>

            </div>
        </div>

    </div>
</div>

</body>
</html>

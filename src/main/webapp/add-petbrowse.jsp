<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pusakkamek.dao.PetDAO"%>
<%@ page import="com.pusakkamek.model.Pet"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pusakkamek.model.Admin"%>

<%
    String cp = request.getContextPath();

    // ✅ Admin guard
    Admin admin = (Admin) session.getAttribute("adminUser");
    if (admin == null) {
        response.sendRedirect(cp + "/admin-login.jsp");
        return;
    }

    // ✅ Load pets
    List<Pet> pets;
    try {
        PetDAO petDAO = new PetDAO();
        pets = petDAO.getAllPets();
    } catch (Exception e) {
        pets = java.util.Collections.emptyList();
    }

    String ok = request.getParameter("ok");
    String err = request.getParameter("err");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Management - Pusak Kamek Admin</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --brand-maroon: #7a0019;
            --brand-maroon-light: #96102b;
            --shadow: 0 10px 30px rgba(0,0,0,0.10);
            --bg: #f7f7f7;
        }

        /* ✅ match admin-adoptions look: light background */
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: var(--bg);
            color: #222;
            min-height: 100vh;
        }

        /* ✅ NAVBAR (SAME AS admin-adoptions.jsp) */
        .navbar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding:18px 6%;
            background:#fff;
            box-shadow:var(--shadow);
        }
        .brand{ font-weight:900; color:var(--brand-maroon); line-height:1.1; }
        .brand small{ display:block; font-weight:600; color:#777; margin-top:2px; font-size:11px; }

        .nav a{
            margin-left:12px;
            text-decoration:none;
            color:#555;
            font-weight:800;
            padding:8px 14px;
            border-radius:999px;
            transition:.2s;
        }
        .nav a:hover{ background:#fdf0f1; color:var(--brand-maroon); }
        .nav a.active{ background:var(--brand-maroon); color:#fff !important; }

        /* content wrap */
        .container {
            max-width: 1400px;
            margin: 22px auto 60px;
            padding: 0 6%;
        }

        .btn-back {
            background: #fff;
            color: var(--brand-maroon);
            padding: 10px 14px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 800;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--shadow);
            border: 1px solid #eee;
            margin: 8px 0 16px;
            transition: .2s;
        }
        .btn-back:hover { transform: translateY(-1px); background:#fdf0f1; }

        .section-title {
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            margin: 26px 0 14px;
        }
        .section-title h2 { margin:0; color:#111; }
        .section-title small { color:#777; font-weight:700; }

        .category-scroll {
            display:flex;
            gap:16px;
            overflow-x:auto;
            padding: 10px 0 18px;
            scrollbar-width:none;
        }
        .category-scroll::-webkit-scrollbar { display:none; }

        .mini-cat-card {
            flex:0 0 160px;
            background:#fff;
            color:#333;
            border-radius:18px;
            text-align:center;
            padding:14px;
            cursor:pointer;
            transition:0.25s;
            box-shadow:var(--shadow);
            border:1px solid #eee;
        }
        .mini-cat-card:hover { transform:translateY(-4px); background:#fdf0f1; }
        .mini-cat-card h4 { margin:0; font-size:16px; color:var(--brand-maroon); }

        /* pets grid */
        .pet-grid {
            display:grid;
            grid-template-columns:repeat(auto-fill, minmax(280px, 1fr));
            gap:22px;
            margin-top: 14px;
        }

        .pet-card {
            background:#fff;
            color:#333;
            border-radius:22px;
            overflow:hidden;
            box-shadow:var(--shadow);
            border:1px solid #eee;
            transition:0.25s;
        }
        .pet-card:hover { transform: translateY(-5px); }

        .pet-card img {
            width:100%;
            height:200px;
            object-fit:cover;
            background:#eee;
        }

        .pet-info { padding:18px; }
        .pet-info h3 { margin:0 0 10px; color:var(--brand-maroon); }

        .pet-tag {
            display:inline-block;
            padding:4px 12px;
            border-radius:20px;
            font-size:11px;
            font-weight:800;
            background:#f3f3f4;
            margin-right:6px;
            margin-bottom:6px;
        }

        .edit-btn {
            width:100%;
            padding:10px;
            border-radius:12px;
            border:1px solid var(--brand-maroon);
            color:var(--brand-maroon);
            background:none;
            font-weight:900;
            cursor:pointer;
            transition:0.25s;
        }
        .edit-btn:hover { background:var(--brand-maroon); color:#fff; }

        .floating-add {
            background: var(--brand-maroon);
            color: #fff;
            padding: 10px 16px;
            border-radius: 999px;
            font-weight: 900;
            display:flex;
            align-items:center;
            gap:10px;
            cursor:pointer;
            box-shadow: var(--shadow);
            transition: .2s;
        }
        .floating-add:hover { background: var(--brand-maroon-light); transform: translateY(-1px); }

        /* alerts */
        .alert {
            margin: 12px 0 18px;
            padding: 10px 14px;
            border-radius: 14px;
            font-weight: 900;
            font-size: 13px;
            display:inline-block;
        }
        .alert.ok { background:#e8f7ee; color:#0b5f16; border:1px solid rgba(11,95,22,.15); }
        .alert.err { background:#fde7e7; color:#8b0000; border:1px solid rgba(139,0,0,.15); }

        .empty {
            background:#fff;
            padding:18px;
            border-radius:18px;
            box-shadow:var(--shadow);
            border:1px solid #eee;
            color:#555;
        }
        .empty b { color: var(--brand-maroon); }

        /* modal (kept your style) */
        .modal-overlay {
            position:fixed; top:0; left:0; width:100%; height:100%;
            background:rgba(0,0,0,0.85);
            backdrop-filter:blur(8px);
            display:none;
            justify-content:center;
            align-items:center;
            z-index:2000;
        }
        .modal-content {
            background:#fff; color:#333;
            padding:36px;
            border-radius:26px;
            width:90%;
            max-width:900px;
            display:flex;
            gap:26px;
            position:relative;
            max-height:90vh;
            overflow-y:auto;
        }
        .close-btn {
            position:absolute; top:18px; right:22px;
            cursor:pointer; font-size:28px; color:#ccc; transition:0.3s;
        }
        .close-btn:hover { color:var(--brand-maroon); }

        .form-grid { display:grid; grid-template-columns:1fr 1fr; gap:14px; flex:1; }
        .form-group { display:flex; flex-direction:column; }
        .form-group label {
            font-size:12px; font-weight:900; color:#777;
            margin-bottom:6px; text-transform:uppercase;
        }
        .form-group input, .form-group select {
            padding:12px; border-radius:12px; border:1px solid #ddd; font-family:inherit;
            outline:none;
        }
        .form-group input:focus, .form-group select:focus {
            border-color:#caa1aa;
            box-shadow:0 0 0 3px rgba(122,0,25,.10);
        }

        .submit-btn {
            grid-column:span 2;
            background:var(--brand-maroon);
            color:#fff;
            border:none;
            padding:14px;
            border-radius:14px;
            font-weight:900;
            cursor:pointer;
            margin-top:8px;
            transition:0.25s;
        }
        .submit-btn:hover { background:var(--brand-maroon-light); }

        .upload-area { flex:0 0 220px; display:flex; flex-direction:column; align-items:center; }
        .upload-placeholder {
            width:180px; height:180px;
            background:#f9f9f9;
            border:2px dashed #ddd;
            border-radius:22px;
            display:flex;
            flex-direction:column;
            align-items:center;
            justify-content:center;
            cursor:pointer;
            color:#aaa;
            text-align:center;
            padding:12px;
        }
    </style>
</head>
<body>

<!-- Navbar now matches admin-adoptions.jsp -->
<header class="navbar">
    <div class="brand">
        PUSAK KAMEK
        <small>ADMIN PANEL</small>
    </div>

    <div class="nav">
        <a href="<%= cp %>/admin/index">Dashboard</a>
        <a href="<%= cp %>/admin/adoptions">Adoptions</a>
        <a class="active" href="<%= cp %>/add-petbrowse.jsp">Pets</a>
        <a href="<%= cp %>/LogoutServlet" style="color:#b00020;">Logout</a>
    </div>
</header>

<div class="container">
    <a href="<%= cp %>/admin/index" class="btn-back">
        <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
    </a>

    <% if (ok != null) { %>
        <div class="alert ok">✅ Pet saved successfully!</div>
    <% } %>
    <% if (err != null) { %>
        <div class="alert err">❌ Failed to save pet. (Check GlassFish log for details.)</div>
    <% } %>

    <!-- Pets -->
    <div class="section-title">
        <h2>Current Residents</h2>
        <div class="floating-add" onclick="toggleModal('petModal', true)">
            <i class="fa-solid fa-plus"></i> Add New Pet
        </div>
    </div>

    <% if (pets == null || pets.isEmpty()) { %>
        <div class="empty">
            No pets found. Click <b>Add New Pet</b> to create your first listing.
        </div>
    <% } else { %>
        <div class="pet-grid">
            <% for(Pet p : pets) { %>
                <div class="pet-card">
                    <!-- ✅ ImageServlet -->
                    <img src="<%= cp %>/images/<%= p.getImageUrl() %>" alt="<%= p.getName() %>">

                    <div class="pet-info">
                        <h3><%= p.getName() %></h3>

                        <div style="margin-bottom:12px;">
                            <span class="pet-tag"><%= p.getSpecies() %></span>
                            <span class="pet-tag"><%= p.getAge() %> YEARS</span>
                            <span class="pet-tag"><%= p.getStatus() %></span>
                        </div>

                        <button class="edit-btn" type="button" onclick="toggleModal('petModal', true)">
                            Add Another
                        </button>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<!-- Add Pet Modal -->
<div class="modal-overlay" id="petModal">
    <div class="modal-content">
        <span class="close-btn" onclick="toggleModal('petModal', false)">&times;</span>

        <div class="upload-area">
            <div class="upload-placeholder">
                <i class="fa-solid fa-camera" style="font-size:30px; margin-bottom:10px;"></i>
                <p style="font-size:11px; font-weight:900; margin:0;">PHOTO</p>
                <p style="font-size:11px; margin:6px 0 0;">Select file in form</p>
            </div>
        </div>

        <form action="<%= cp %>/AddPetServlet" method="post" enctype="multipart/form-data" class="form-grid">
            <h2 style="grid-column: span 2; margin:0; color:var(--brand-maroon);">Pet Information</h2>

            <div class="form-group">
                <label>Species</label>
                <select name="species" required>
                    <option value="Cat">Cat</option>
                    <option value="Dog">Dog</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label>Pet Name</label>
                <input type="text" name="name" placeholder="e.g. Luna" required>
            </div>

            <div class="form-group">
                <label>Age</label>
                <input type="number" name="age" min="0" placeholder="e.g. 1" required>
            </div>

            <div class="form-group">
                <label>Breed</label>
                <input type="text" name="breed" placeholder="e.g. Persian">
            </div>

            <div class="form-group">
                <label>Vaccination Status</label>
                <input type="text" name="vaccinationStatus" placeholder="Yes/No">
            </div>

            <div class="form-group">
                <label>Condition</label>
                <input type="text" name="condition" placeholder="Healthy">
            </div>

            <div class="form-group">
                <label>Neutered</label>
                <input type="text" name="neutered" placeholder="Yes/No">
            </div>

            <div class="form-group">
                <label>Color</label>
                <input type="text" name="color" placeholder="White/Brown">
            </div>

            <div class="form-group" style="grid-column: span 2;">
                <label>Photo</label>
                <input type="file" name="image" accept="image/*" required>
            </div>

            <button type="submit" class="submit-btn">Save Pet Entry</button>
        </form>
    </div>
</div>

<script>
function toggleModal(modalId, show) {
    const modal = document.getElementById(modalId);
    if (show) { modal.style.display = 'flex'; document.body.style.overflow='hidden'; }
    else { modal.style.display = 'none'; document.body.style.overflow='auto'; }
}
window.onclick = function(event) {
    if(event.target.classList.contains('modal-overlay')) {
        event.target.style.display='none';
        document.body.style.overflow='auto';
    }
}
</script>

</body>
</html>

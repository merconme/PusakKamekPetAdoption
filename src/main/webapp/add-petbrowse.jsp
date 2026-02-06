<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pusakkamek.dao.PetDAO"%>
<%@ page import="com.pusakkamek.model.Pet"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pusakkamek.model.Admin"%>

<%!
    // ✅ Escape for HTML attribute (data-xxx="...")
    private String escAttr(String s) {
        if (s == null) return "";
        return s.replace("&","&amp;")
                .replace("\"","&quot;")
                .replace("'","&#39;")
                .replace("<","&lt;")
                .replace(">","&gt;");
    }
%>

<%
    String cp = request.getContextPath();

    // ✅ Admin guard
    Admin admin = (Admin) session.getAttribute("adminUser");
    if (admin == null) {
        response.sendRedirect(cp + "/admin-login.jsp");
        return;
    }

    String adminDisplay = "Admin";
    try { adminDisplay = admin.getUsername(); } catch (Exception e) { adminDisplay = "Admin"; }

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
        :root{
          --brand:#7a0019;
          --brand2:#96102b;
          --shadow:0 10px 30px rgba(0,0,0,.10);
          --bg:#f7f7f7;
          --line:#e5e7eb;
          --danger:#b00020;
        }
        *{box-sizing:border-box}
        body{
          margin:0;
          font-family:'Poppins',sans-serif;
          background:var(--bg);
          color:#222;
          min-height:100vh;
        }

        .shell{ display:flex; min-height:100vh; }

        .sidebar{
          width:260px;
          background:linear-gradient(135deg,var(--brand2),var(--brand));
          color:#fff;
          padding:18px 16px;
          position:sticky;
          top:0;
          height:100vh;
        }

        .side-brand{
          display:flex; gap:12px; align-items:center;
          padding:10px 10px 16px;
          border-bottom:1px solid rgba(255,255,255,.18);
        }

        .logo{
          width:44px;height:44px;border-radius:16px;
          background:linear-gradient(135deg,#fff,#f4d6dc);
          box-shadow:0 10px 24px rgba(0,0,0,.25);
        }

        .side-brand b{display:block;font-size:14px;letter-spacing:.5px;}
        .side-brand small{display:block;font-size:11px;font-weight:700;opacity:.9;margin-top:2px;}

        .side-links{ margin-top:14px; display:flex; flex-direction:column; gap:8px; }
        .side-links a{
          display:flex; align-items:center; gap:10px;
          padding:11px 12px;
          border-radius:14px;
          text-decoration:none;
          color:#fff;
          font-weight:900;
          font-size:13px;
          background:rgba(255,255,255,.08);
          border:1px solid rgba(255,255,255,.10);
          transition:.15s;
        }
        .side-links a:hover{ background:rgba(255,255,255,.16); transform:translateY(-1px); }
        .side-links a.active{ background:rgba(255,255,255,.28); }
        .side-links i{ width:18px; text-align:center; }

        .side-bottom{
          margin-top:auto;
          padding-top:14px;
          border-top:1px solid rgba(255,255,255,.18);
        }
        .side-user{
          display:flex; align-items:center; gap:10px;
          padding:10px 12px;
          border-radius:14px;
          background:rgba(255,255,255,.10);
          border:1px solid rgba(255,255,255,.14);
          font-weight:900; font-size:12.5px;
        }
        .side-user .av{
          width:34px;height:34px;border-radius:50%;
          display:flex;align-items:center;justify-content:center;
          background:rgba(255,255,255,.18);
        }
        .logout{
          margin-top:10px;
          display:block;
          text-align:center;
          padding:10px 12px;
          border-radius:14px;
          background:rgba(255,255,255,.10);
          border:1px solid rgba(255,255,255,.14);
          color:#fff;
          text-decoration:none;
          font-weight:900;
        }
        .logout:hover{ background:rgba(255,255,255,.18); }

        .content{ flex:1; padding:22px 28px 60px; }

        .btn-back {
            background: #fff;
            color: var(--brand);
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
            margin: 18px 0 14px;
        }
        .section-title h2 { margin:0; color:#111; }

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
        .pet-info h3 { margin:0 0 10px; color:var(--brand); }

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

        .btn-row{ display:flex; gap:10px; margin-top:12px; }
        .btn{
            flex:1;
            padding:10px;
            border-radius:12px;
            border:1px solid var(--brand);
            color:var(--brand);
            background:none;
            font-weight:900;
            cursor:pointer;
            transition:0.25s;
        }
        .btn:hover { background:var(--brand); color:#fff; }
        .btn.danger{ border-color:var(--danger); color:var(--danger); }
        .btn.danger:hover{ background:var(--danger); color:#fff; }

        .floating-add {
            background: var(--brand);
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
        .floating-add:hover { background: var(--brand2); transform: translateY(-1px); }

        .alert {
            margin: 12px 0 18px;
            padding: 10px 14px;
            border-radius: 14px;
            font-weight: 900;
            font-size: 13px;
            display:inline-block;
            border:1px solid transparent;
        }
        .alert.ok { background:#e8f7ee; color:#0b5f16; border-color:rgba(11,95,22,.15); }
        .alert.err { background:#fde7e7; color:#8b0000; border-color:rgba(139,0,0,.15); }

        .empty {
            background:#fff;
            padding:18px;
            border-radius:18px;
            box-shadow:var(--shadow);
            border:1px solid #eee;
            color:#555;
        }
        .empty b { color: var(--brand); }

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
        .close-btn:hover { color:var(--brand); }

        .form-grid { display:grid; grid-template-columns:1fr 1fr; gap:14px; flex:1; }
        .form-group { display:flex; flex-direction:column; }
        .form-group label {
            font-size:12px; font-weight:900; color:#777;
            margin-bottom:6px; text-transform:uppercase;
        }
        .form-group input, .form-group select, .form-group textarea {
            padding:12px; border-radius:12px; border:1px solid #ddd; font-family:inherit;
            outline:none;
        }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border-color:#caa1aa;
            box-shadow:0 0 0 3px rgba(122,0,25,.10);
        }

        .submit-btn {
            grid-column:span 2;
            background:var(--brand);
            color:#fff;
            border:none;
            padding:14px;
            border-radius:14px;
            font-weight:900;
            cursor:pointer;
            margin-top:8px;
            transition:0.25s;
        }
        .submit-btn:hover { background:var(--brand2); }

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

        @media (max-width:1100px){ .sidebar{width:240px;} }
        @media (max-width:800px){
          .shell{flex-direction:column;}
          .sidebar{width:100%;height:auto;position:relative;}
          .btn-row{flex-direction:column;}
        }
    </style>
</head>
<body>

<div class="shell">

  <aside class="sidebar">
    <div class="side-brand">
      <div class="logo"></div>
      <div>
        <b>PUSAK KAMEK</b>
        <small>ADMIN PANEL</small>
      </div>
    </div>

    <nav class="side-links">
      <a href="<%= cp %>/admin/index"><i class="fa-solid fa-gauge"></i> Dashboard</a>
      <a href="<%= cp %>/admin/adoptions"><i class="fa-solid fa-file-lines"></i> Adoptions</a>
      <a class="active" href="<%= cp %>/add-petbrowse.jsp"><i class="fa-solid fa-paw"></i> Pets</a>
      <a href="<%= cp %>/admin/stories"><i class="fa-solid fa-book"></i> Stories</a>
      <a href="<%= cp %>/admin/volunteers"><i class="fa-solid fa-hand-holding-heart"></i> Volunteers</a>
      <a href="<%= cp %>/admin/donations"><i class="fa-solid fa-hand-holding-dollar"></i> Donations</a>
    </nav>

    <div class="side-bottom">
      <div class="side-user">
        <div class="av">👤</div>
        <div>Welcome, <%= adminDisplay %></div>
      </div>
      <a class="logout" href="<%= cp %>/adminLogout">Logout</a>
    </div>
  </aside>

  <main class="content">

    <a href="<%= cp %>/admin/index" class="btn-back">
        <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
    </a>

    <%-- ✅ Alerts --%>
    <% if ("deleted".equals(ok)) { %>
        <div class="alert ok">✅ Pet deleted successfully!</div>
    <% } else if ("updated".equals(ok)) { %>
        <div class="alert ok">✅ Pet updated successfully!</div>
    <% } else if (ok != null) { %>
        <div class="alert ok">✅ Pet saved successfully!</div>
    <% } %>

    <% if ("delete".equals(err)) { %>
        <div class="alert err">❌ Failed to delete pet.</div>
    <% } else if ("update".equals(err)) { %>
        <div class="alert err">❌ Failed to update pet.</div>
    <% } else if (err != null) { %>
        <div class="alert err">❌ Failed to save pet. (Check GlassFish log for details.)</div>
    <% } %>

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

                    <%
                        String img = (p.getImageUrl() == null || p.getImageUrl().trim().isEmpty())
                                ? "no-image.png"
                                : p.getImageUrl();
                    %>

                    <img src="<%= cp %>/images/<%= escAttr(img) %>" alt="<%= escAttr(p.getName()) %>">

                    <div class="pet-info">
                        <h3><%= escAttr(p.getName()) %></h3>

                        <div style="margin-bottom:12px;">
                            <span class="pet-tag"><%= escAttr(p.getSpecies()) %></span>
                            <span class="pet-tag"><%= p.getAge() %> YEARS</span>
                            <span class="pet-tag"><%= escAttr(p.getStatus()) %></span>
                        </div>

                        <% if (p.getDescription() != null && !p.getDescription().trim().isEmpty()) { %>
                            <p style="margin:0; font-size:12px; color:#555; line-height:1.45;">
                                <b>Description:</b> <%= escAttr(p.getDescription()) %>
                            </p>
                        <% } %>

                        <div class="btn-row">
                            <%-- ✅ Edit button: NO onclick parameters. Use dataset. --%>
                            <button class="btn" type="button"
                                data-id="<%= p.getId() %>"
                                data-species="<%= escAttr(p.getSpecies()) %>"
                                data-name="<%= escAttr(p.getName()) %>"
                                data-age="<%= p.getAge() %>"
                                data-breed="<%= escAttr(p.getBreed()) %>"
                                data-vaccination="<%= escAttr(p.getVaccinationStatus()) %>"
                                data-condition="<%= escAttr(p.getCondition()) %>"
                                data-neutered="<%= escAttr(p.getNeutered()) %>"
                                data-color="<%= escAttr(p.getColor()) %>"
                                data-description="<%= escAttr(p.getDescription()) %>"
                                data-imageurl="<%= escAttr(p.getImageUrl()) %>"
                                data-status="<%= escAttr(p.getStatus()) %>"
                                onclick="openEditFromButton(this)">
                                ✏️ Edit
                            </button>

                            <form action="<%= cp %>/DeletePetServlet" method="post"
                                  onsubmit="return confirm('Delete this pet? This cannot be undone.');"
                                  style="margin:0; flex:1;">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <button class="btn danger" type="submit">🗑️ Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>

  </main>

</div>

<!-- ===================== ADD PET MODAL ===================== -->
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
            <h2 style="grid-column: span 2; margin:0; color:var(--brand);">Pet Information</h2>

            <div class="form-group">
                <label>Species</label>
                <input type="text" name="species" placeholder="e.g. Cat, Dog, Rabbit" list="speciesList" required>
                <datalist id="speciesList">
                    <option value="Cat">
                    <option value="Dog">
                    <option value="Rabbit">
                    <option value="Bird">
                </datalist>
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
                <label>Description</label>
                <textarea name="description" rows="3"
                          placeholder="e.g. Friendly, rescued, likes kids, special needs..."></textarea>
            </div>

            <div class="form-group" style="grid-column: span 2;">
                <label>Photo</label>
                <input type="file" name="image" accept="image/*" required>
            </div>

            <button type="submit" class="submit-btn">Save Pet Entry</button>
        </form>
    </div>
</div>

<!-- ===================== EDIT PET MODAL ===================== -->
<div class="modal-overlay" id="editPetModal">
  <div class="modal-content">
    <span class="close-btn" onclick="toggleModal('editPetModal', false)">&times;</span>

    <div class="upload-area">
      <div class="upload-placeholder">
        <i class="fa-solid fa-pen-to-square" style="font-size:30px; margin-bottom:10px;"></i>
        <p style="font-size:11px; font-weight:900; margin:0;">EDIT PET</p>
        <p style="font-size:11px; margin:6px 0 0;">Image optional</p>
      </div>
    </div>

    <form action="<%= cp %>/UpdatePetServlet" method="post" enctype="multipart/form-data" class="form-grid">
      <h2 style="grid-column: span 2; margin:0; color:var(--brand);">Edit Pet</h2>

      <input type="hidden" name="id" id="edit_id">
      <input type="hidden" name="oldImageUrl" id="edit_oldImageUrl">

      <div class="form-group">
        <label>Species</label>
        <input type="text" name="species" id="edit_species" required>
      </div>

      <div class="form-group">
        <label>Pet Name</label>
        <input type="text" name="name" id="edit_name" required>
      </div>

      <div class="form-group">
        <label>Age</label>
        <input type="number" name="age" id="edit_age" min="0" required>
      </div>

      <div class="form-group">
        <label>Breed</label>
        <input type="text" name="breed" id="edit_breed">
      </div>

      <div class="form-group">
        <label>Vaccination Status</label>
        <input type="text" name="vaccinationStatus" id="edit_vaccinationStatus">
      </div>

      <div class="form-group">
        <label>Condition</label>
        <input type="text" name="condition" id="edit_condition">
      </div>

      <div class="form-group">
        <label>Neutered</label>
        <input type="text" name="neutered" id="edit_neutered">
      </div>

      <div class="form-group">
        <label>Color</label>
        <input type="text" name="color" id="edit_color">
      </div>

      <div class="form-group" style="grid-column: span 2;">
        <label>Description</label>
        <textarea name="description" id="edit_description" rows="3"></textarea>
      </div>

      <div class="form-group">
        <label>Status</label>
        <select name="status" id="edit_status" required>
          <option value="AVAILABLE">AVAILABLE</option>
          <option value="ADOPTED">ADOPTED</option>
        </select>
      </div>

      <div class="form-group">
        <label>New Photo (optional)</label>
        <input type="file" name="image" accept="image/*">
      </div>

      <button type="submit" class="submit-btn">Update Pet</button>
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
    if(event.target.classList && event.target.classList.contains('modal-overlay')) {
        event.target.style.display='none';
        document.body.style.overflow='auto';
    }
}

// ✅ Read from data-* attributes (no JSP escaping problems)
function openEditFromButton(btn) {
    document.getElementById("edit_id").value = btn.dataset.id || "";
    document.getElementById("edit_species").value = btn.dataset.species || "";
    document.getElementById("edit_name").value = btn.dataset.name || "";
    document.getElementById("edit_age").value = btn.dataset.age || "0";
    document.getElementById("edit_breed").value = btn.dataset.breed || "";
    document.getElementById("edit_vaccinationStatus").value = btn.dataset.vaccination || "";
    document.getElementById("edit_condition").value = btn.dataset.condition || "";
    document.getElementById("edit_neutered").value = btn.dataset.neutered || "";
    document.getElementById("edit_color").value = btn.dataset.color || "";
    document.getElementById("edit_description").value = btn.dataset.description || "";
    document.getElementById("edit_oldImageUrl").value = btn.dataset.imageurl || "";
    document.getElementById("edit_status").value = (btn.dataset.status && btn.dataset.status.trim() !== "") ? btn.dataset.status : "AVAILABLE";

    toggleModal("editPetModal", true);
}
</script>

</body>
</html>

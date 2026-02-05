<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pusakkamek.model.Admin" %>
<%
    String cp = request.getContextPath();
    Admin admin = (Admin) session.getAttribute("adminUser");

    if (admin == null) {
        response.sendRedirect(cp + "/admin-login.jsp");
        return;
    }

    Integer availablePets = (Integer) request.getAttribute("availablePets");
    Integer adoptedPets   = (Integer) request.getAttribute("adoptedPets");
    Integer pendingApps   = (Integer) request.getAttribute("pendingApps");

    if (availablePets == null) availablePets = 0;
    if (adoptedPets == null) adoptedPets = 0;
    if (pendingApps == null) pendingApps = 0;

    String adminDisplay = "Admin";
    try { adminDisplay = admin.getUsername(); } catch (Exception e) { adminDisplay = "Admin"; }

    String ok = request.getParameter("ok");
    String err = request.getParameter("err");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - Pusak Kamek</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
:root{
  --brand:#7a0019;
  --brand-light:#96102b;
  --shadow:0 10px 30px rgba(0,0,0,.10);
  --bg:#f7f7f7;
}
body{margin:0;font-family:'Poppins',sans-serif;background:var(--bg);}

/* ✅ NAVBAR = SAME AS YOUR admin-adoptions.jsp */
.navbar{
  display:flex;justify-content:space-between;align-items:center;
  padding:18px 6%;
  background:#fff;box-shadow:var(--shadow);
}
.brand{font-weight:900;color:var(--brand);line-height:1.1}
.brand small{display:block;font-weight:600;color:#777;margin-top:2px;font-size:11px}
.nav a{
  margin-left:12px;text-decoration:none;color:#555;font-weight:800;
  padding:8px 14px;border-radius:999px
}
.nav a:hover{background:#fdf0f1;color:var(--brand)}
.active{background:var(--brand);color:#fff !important}

/* page */
.wrap{padding:22px 6% 60px;}
h1{margin:0 0 6px;color:#222}
.sub{margin:0 0 18px;color:#666;font-size:13px}

/* messages like your style */
.msg{
  display:inline-block;
  margin:10px 0 18px;
  padding:10px 14px;
  border-radius:14px;
  font-weight:900;
  font-size:13px;
}
.msg.ok{background:#e8f7ee;color:#0b5f16;border:1px solid rgba(11,95,22,.15)}
.msg.err{background:#fde7e7;color:#8b0000;border:1px solid rgba(139,0,0,.15)}

/* cards */
.grid{
  display:grid;
  grid-template-columns:repeat(12, 1fr);
  gap:16px;
  margin-top:16px;
}
.card{
  background:#fff;border-radius:18px;box-shadow:var(--shadow);
  padding:18px; border:1px solid #eee;
}
.stat{grid-column:span 3; min-height:140px;}
@media (max-width:1100px){ .stat{grid-column:span 6;} }
@media (max-width:700px){ .stat{grid-column:span 12;} }

.icon{
  width:44px;height:44px;border-radius:14px;
  display:flex;align-items:center;justify-content:center;
  background:#fdf0f1; color:var(--brand);
  font-size:18px; margin-bottom:10px;
}
.card h3{margin:0;color:var(--brand);font-size:14px;font-weight:900}
.num{font-size:34px;font-weight:900;color:#111;margin-top:8px}
.small{color:#666;font-size:12px;margin-top:4px;font-weight:600}

/* quick actions row */
.actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:14px}
.btn{
  border:none;cursor:pointer;font-weight:900;
  padding:10px 14px;border-radius:12px;
}
.btn-primary{background:var(--brand);color:#fff}
.btn-primary:hover{background:var(--brand-light)}
.btn-soft{background:#f3f3f4;color:#111}
.btn-soft:hover{background:#e9e9ea}

/* modal */
.modal{
  display:none;position:fixed;inset:0;
  background:rgba(0,0,0,0.55);
  justify-content:center;align-items:center;
  z-index:2000;
}
.modal-box{
  width:min(820px, 92vw);
  background:#fff;border-radius:18px;
  box-shadow:0 20px 60px rgba(0,0,0,.22);
  overflow:hidden;
}
.modal-head{
  display:flex;justify-content:space-between;align-items:center;
  padding:14px 16px;border-bottom:1px solid #eee;
}
.modal-head h2{margin:0;color:var(--brand);font-size:18px;font-weight:900}
.close-btn{cursor:pointer;font-size:22px;font-weight:900;color:#777}
.close-btn:hover{color:#111}
.form{padding:16px}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
@media (max-width:720px){ .form-grid{grid-template-columns:1fr;} }
.fg label{display:block;font-weight:900;font-size:12px;color:#666;text-transform:uppercase;margin-bottom:6px}
.fg input{width:100%;padding:10px;border-radius:12px;border:1px solid #ddd;font-family:inherit;outline:none}
.fg input:focus{border-color:#caa1aa;box-shadow:0 0 0 3px rgba(122,0,25,.10)}
.full{grid-column:1/-1}
.form-actions{display:flex;justify-content:flex-end;gap:10px;margin-top:14px}
</style>
</head>

<body>

<header class="navbar">
  <div class="brand">
    PUSAK KAMEK
    <small>ADMIN PANEL</small>
  </div>

  <div class="nav">
    <a class="active" href="<%= cp %>/admin/index">Dashboard</a>
    <a href="<%= cp %>/admin/adoptions">Adoptions</a>
    <a href="<%= cp %>/add-petbrowse.jsp">Pets</a>
    <a href="<%= cp %>/adminLogout" style="color:#b00020;">Logout</a>
  </div>
</header>

<main class="wrap">
  <h1>Welcome back, <%= adminDisplay %> 👋</h1>
  <p class="sub">Manage pets, stories and adoption requests.</p>

  <% if (ok != null) { %><div class="msg ok">✅ Pet saved successfully!</div><% } %>
  <% if (err != null) { %><div class="msg err">❌ Failed to save pet. Please try again.</div><% } %>

  <section class="grid">
    <div class="card stat">
      <div class="icon"><i class="fa-solid fa-paw"></i></div>
      <h3>Pets Available</h3>
      <div class="num"><%= availablePets %></div>
      <div class="small">Currently listed for adoption</div>
    </div>

    <div class="card stat">
      <div class="icon"><i class="fa-solid fa-heart"></i></div>
      <h3>Pets Adopted</h3>
      <div class="num"><%= adoptedPets %></div>
      <div class="small">Successfully rehomed</div>
    </div>

    <div class="card stat">
      <div class="icon"><i class="fa-solid fa-file-lines"></i></div>
      <h3>Pending Applications</h3>
      <div class="num"><%= pendingApps %></div>
      <div class="small">Need admin action</div>
    </div>

    <div class="card stat">
      <div class="icon"><i class="fa-solid fa-circle-plus"></i></div>
      <h3>Quick Actions</h3>
      <div class="small" style="margin-top:8px;">Add pets or review applications quickly.</div>

      <div class="actions">
        <button class="btn btn-primary" onclick="openModal()">Add New Pet</button>
        <a class="btn btn-soft" href="<%= cp %>/admin/adoptions" style="text-decoration:none;display:inline-block;">View Applications</a>
        <a class="btn btn-soft" href="<%= cp %>/add-petbrowse.jsp" style="text-decoration:none;display:inline-block;">Manage Pets</a>
      </div>
    </div>
  </section>
</main>

<!-- ADD PET MODAL -->
<div class="modal" id="petModal">
  <div class="modal-box">
    <div class="modal-head">
      <h2>Add New Pet</h2>
      <span class="close-btn" onclick="closeModal()">&times;</span>
    </div>

    <div class="form">
      <form action="<%= cp %>/AddPetServlet" method="post" enctype="multipart/form-data">
        <div class="form-grid">

          <div class="fg">
            <label>Species</label>
            <input type="text" name="species" placeholder="Cat/Dog" required>
          </div>

          <div class="fg">
            <label>Name</label>
            <input type="text" name="name" placeholder="Pet name" required>
          </div>

          <div class="fg">
            <label>Breed</label>
            <input type="text" name="breed" placeholder="e.g. Siamese">
          </div>

          <div class="fg">
            <label>Age</label>
            <input type="number" name="age" min="0" required>
          </div>

          <div class="fg">
            <label>Vaccination Status</label>
            <input type="text" name="vaccinationStatus" placeholder="Yes/No">
          </div>

          <div class="fg">
            <label>Condition</label>
            <input type="text" name="condition" placeholder="Healthy">
          </div>

          <div class="fg">
            <label>Neutered</label>
            <input type="text" name="neutered" placeholder="Yes/No">
          </div>

          <div class="fg">
            <label>Color</label>
            <input type="text" name="color" placeholder="e.g. White">
          </div>

          <div class="fg full">
            <label>Photo</label>
            <input type="file" name="image" accept="image/*" required>
          </div>
        </div>

        <div class="form-actions">
          <button type="button" class="btn btn-soft" onclick="closeModal()">Cancel</button>
          <button type="submit" class="btn btn-primary">Save Pet</button>
        </div>

      </form>
    </div>
  </div>
</div>

<script>
const modal = document.getElementById('petModal');
function openModal(){ modal.style.display='flex'; }
function closeModal(){ modal.style.display='none'; }
window.addEventListener("click", function(e){
  if(e.target === modal) closeModal();
});
</script>

</body>
</html>

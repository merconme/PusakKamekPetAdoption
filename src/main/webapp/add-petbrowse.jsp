<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.pusakkamek.dao.PetDAO"%>
<%@ page import="com.pusakkamek.model.Pet"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pusakkamek.dao.CategoryDAO"%>
<%@ page import="com.pusakkamek.model.Category"%>
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
            --shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        body { margin: 0; font-family: 'Poppins', sans-serif; background: radial-gradient(circle at top, var(--brand-maroon-light), var(--brand-maroon)); color: white; min-height: 100vh; }
        .navbar { display:flex; justify-content:space-between; align-items:center; padding:0 5%; height:80px; background:white; position:fixed; top:0; left:0; width:100%; box-shadow:var(--shadow); z-index:1000; }
        .logo-section { display:flex; align-items:center; gap:12px; color:var(--brand-maroon); }
        .logo-circle { background: var(--brand-maroon); color:white; width:35px; height:35px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-weight:800; }
        .logo-text { font-weight:800; font-size:18px; line-height:1.1; }
        .nav-links { display:flex; list-style:none; gap:5px; margin:0; padding:0; }
        .nav-links a { color:#555; text-decoration:none; font-weight:600; font-size:14px; padding:10px 18px; border-radius:10px; transition:0.3s; }
        .nav-links a:hover { background:#f8f8f8; color:var(--brand-maroon); }
        .nav-active { background:var(--brand-maroon) !important; color:white !important; }
        .admin-profile { display:flex; align-items:center; gap:10px; color:var(--brand-maroon); font-weight:700; }
        .profile-icon { width:40px; height:40px; background:#eee; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:18px; }
        .container { max-width:1400px; margin:120px auto 50px; padding:0 5%; position:relative; z-index:1; }
        .section-title { display:flex; justify-content:space-between; align-items:center; margin-bottom:20px; border-bottom:1px solid rgba(255,255,255,0.2); padding-bottom:10px; margin-top:40px; }
        .btn-back { background: rgba(255,255,255,0.2); color:white; padding:8px 15px; border-radius:10px; text-decoration:none; font-size:13px; font-weight:600; display:flex; align-items:center; gap:8px; border:1px solid rgba(255,255,255,0.3); margin-bottom:20px; width:fit-content; transition:0.3s; }
        .btn-back:hover { background:white; color:var(--brand-maroon); }
        .category-scroll { display:flex; gap:20px; overflow-x:auto; padding:10px 0 30px; scrollbar-width:none; }
        .category-scroll::-webkit-scrollbar { display:none; }
        .mini-cat-card { flex:0 0 160px; background:white; color:#333; border-radius:20px; text-align:center; padding:15px; cursor:pointer; transition:0.3s; box-shadow:var(--shadow); }
        .mini-cat-card:hover { transform:translateY(-5px); background:#fdf0f1; }
        .mini-cat-card img { width:60px; height:60px; border-radius:50%; object-fit:cover; margin-bottom:10px; }
        .mini-cat-card h4 { margin:0; font-size:16px; color:var(--brand-maroon); }
        .add-mini-card { flex:0 0 160px; border:2px dashed rgba(255,255,255,0.4); border-radius:20px; display:flex; flex-direction:column; justify-content:center; align-items:center; cursor:pointer; transition:0.3s; }
        .add-mini-card:hover { background:rgba(255,255,255,0.1); border-color:white; }
        .pet-grid { display:grid; grid-template-columns:repeat(auto-fill, minmax(280px, 1fr)); gap:25px; margin-top:20px; }
        .pet-card { background:white; color:#333; border-radius:25px; overflow:hidden; box-shadow:var(--shadow); transition:0.3s; }
        .pet-card img { width:100%; height:200px; object-fit:cover; }
        .pet-info { padding:20px; }
        .pet-info h3 { margin:0 0 10px; color:var(--brand-maroon); }
        .pet-tag { display:inline-block; padding:4px 12px; border-radius:20px; font-size:11px; font-weight:700; background:#eee; margin-right:5px; margin-bottom:5px; }
        .edit-btn { width:100%; padding:10px; border-radius:10px; border:1px solid var(--brand-maroon); color:var(--brand-maroon); background:none; font-weight:700; cursor:pointer; transition:0.3s; }
        .edit-btn:hover { background:var(--brand-maroon); color:white; }
        .floating-add { background:#fff; color:var(--brand-maroon); padding:12px 25px; border-radius:50px; font-weight:800; display:flex; align-items:center; gap:10px; cursor:pointer; box-shadow:var(--shadow); transition:0.3s; }
        .floating-add:hover { transform:scale(1.05); background:#fdf0f1; }
        .modal-overlay { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.85); backdrop-filter:blur(8px); display:none; justify-content:center; align-items:center; z-index:2000; }
        .modal-content { background:white; color:#333; padding:40px; border-radius:30px; width:90%; max-width:800px; display:flex; gap:30px; position:relative; max-height:90vh; overflow-y:auto; }
        .close-btn { position:absolute; top:20px; right:25px; cursor:pointer; font-size:28px; color:#ccc; transition:0.3s; }
        .close-btn:hover { color:var(--brand-maroon); }
        .form-grid { display:grid; grid-template-columns:1fr 1fr; gap:15px; flex:1; }
        .form-group { display:flex; flex-direction:column; }
        .form-group label { font-size:12px; font-weight:700; color:#777; margin-bottom:5px; text-transform:uppercase; }
        .form-group input, .form-group select { padding:12px; border-radius:10px; border:1px solid #ddd; font-family:inherit; }
        .submit-btn { grid-column:span 2; background:var(--brand-maroon); color:white; border:none; padding:15px; border-radius:12px; font-weight:700; cursor:pointer; margin-top:10px; transition:0.3s; }
        .submit-btn:hover { background:var(--brand-maroon-light); }
        .upload-area { flex:0 0 200px; display:flex; flex-direction:column; align-items:center; }
        .upload-placeholder { width:160px; height:160px; background:#f9f9f9; border:2px dashed #ddd; border-radius:20px; display:flex; flex-direction:column; align-items:center; justify-content:center; cursor:pointer; color:#aaa; }
    </style>
</head>
<body>

<header class="navbar">
    <div class="logo-section">
        <div class="logo-circle">PK</div>
        <div class="logo-text">PUSAK KAMEK<br><small style="font-weight:400; font-size:10px; color:#777;">ADMIN PANEL</small></div>
    </div>
    <nav>
        <ul class="nav-links">
            <li><a href="admin-index.jsp">Dashboard</a></li>
            <li><a href="upload-stories.jsp">Stories</a></li>
            <li><a href="add-petbrowse.jsp" class="nav-active">Pets</a></li>
            <li><a href="adopt-history.jsp">Adoptions</a></li>
        </ul>
    </nav>
    <div class="admin-profile"><span>Admin</span><div class="profile-icon">👤</div></div>
</header>

<div class="container">
    <a href="admin-index.jsp" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>

    <!-- Categories -->
    <div class="section-title">
        <h2>Pet Categories</h2>
        <small style="color:#ffcad4;">View or Add Species</small>
    </div>
    <div class="category-scroll">
        <%
            CategoryDAO catDAO = new CategoryDAO();
            List<Category> categories = catDAO.selectAllCategories();
            for(Category c : categories) {
        %>
        <div class="mini-cat-card">
            <img src="<%= c.getImageUrl() %>" alt="<%= c.getName() %>">
            <h4><%= c.getName() %></h4>
        </div>
        <% } %>
        <div class="add-mini-card" onclick="toggleModal('categoryModal', true)">
            <span style="font-size:24px;">+</span>
            <span style="font-size:12px; font-weight:600;">Add Category</span>
        </div>
    </div>

    <!-- Pets -->
    <div class="section-title">
        <h2>Current Residents</h2>
        <div class="floating-add" onclick="toggleModal('petModal', true)"><i class="fa-solid fa-plus"></i> Add New Pet</div>
    </div>
    <div class="pet-grid">
        <%
            PetDAO petDAO = new PetDAO();
            List<Pet> pets = petDAO.selectAllPets();
            for(Pet p : pets) {
        %>
        <div class="pet-card">
            <img src="<%= p.getPhotoUrl() != null ? p.getPhotoUrl() : "default.jpg" %>" alt="<%= p.getName() %>">
            <div class="pet-info">
                <h3><%= p.getName() %></h3>
                <div style="margin-bottom:15px;">
                    <span class="pet-tag"><%= p.getSpecies() %></span>
                    <span class="pet-tag"><%= p.getAge() %> YEARS</span>
                </div>
                <button class="edit-btn" onclick="toggleModal('petModal', true)">Edit Details</button>
            </div>
        </div>
        <% } %>
    </div>
</div>

<!-- Add Pet Modal -->
<div class="modal-overlay" id="petModal">
    <div class="modal-content">
        <span class="close-btn" onclick="toggleModal('petModal', false)">&times;</span>
        <div class="upload-area">
            <div class="upload-placeholder"><i class="fa-solid fa-camera" style="font-size:30px; margin-bottom:10px;"></i><p style="font-size:10px; font-weight:700;">PHOTO</p></div>
        </div>
        <form action="insert" method="post" enctype="multipart/form-data" class="form-grid">
            <h2 style="grid-column: span 2; margin:0; color:var(--brand-maroon);">Pet Information</h2>
            <div class="form-group"><label>Category</label>
                <select name="species">
                    <%
                        for(Category c : categories) {
                    %>
                        <option><%= c.getName() %></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group"><label>Pet Name</label><input type="text" name="name" placeholder="e.g. Luna" required></div>
            <div class="form-group"><label>Age</label><input type="number" name="age" placeholder="e.g. 1" required></div>
            <div class="form-group"><label>Breed</label><input type="text" name="breed" placeholder="e.g. Persian"></div>
            <button type="submit" class="submit-btn">Save Pet Entry</button>
        </form>
    </div>
</div>

<!-- Add Category Modal -->
<div class="modal-overlay" id="categoryModal">
    <div class="modal-content" style="max-width:500px; flex-direction:column; align-items:center; text-align:center;">
        <span class="close-btn" onclick="toggleModal('categoryModal', false)">&times;</span>
        <h2 style="color:var(--brand-maroon); margin-bottom:10px;">New Category</h2>
        <form action="insertCategory" method="post" enctype="multipart/form-data" style="width:100%;">
            <div class="form-group" style="width:100%; margin-bottom:20px;">
                <label>Category Name</label>
                <input type="text" name="name" placeholder="e.g. Hamsters" required>
            </div>
            <button type="submit" class="submit-btn" style="width:100%;">Create Category</button>
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

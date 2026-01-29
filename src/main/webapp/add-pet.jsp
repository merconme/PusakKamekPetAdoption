<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pusakkamek.model.Pet"%>
<%@page import="java.util.List"%>
<%@page import="com.pusakkamek.dao.PetDAO"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Pets - Pusak Kamek Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        /* Your CSS from previous code (same as before) */
    </style>
</head>
<body>
<header class="navbar">
    <!-- Navbar same as before -->
</header>

<div class="page-header">
    <h1>Manage Pets</h1>
    <a href="admin-index.jsp" class="back-btn">
        <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<main>
    <div class="pet-grid">
        <% 
            PetDAO dao = new PetDAO();
            List<Pet> pets = dao.selectAllPets();
            for(Pet p : pets) { 
        %>
        <div class="pet-card">
            <img src="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400" alt="Pet">
            <div class="pet-info">
                <p>Name: <span><%= p.getName() %></span></p>
                <p>Age: <span><%= p.getAge() %> Years</span></p>
                <p>Breed: <span><%= p.getSpecies() %></span></p>
            </div>
        </div>
        <% } %>

        <div class="add-pet-card" onclick="openModal()">
            <div class="plus-icon">+</div>
            <div class="add-text">Add New Pet</div>
        </div>
    </div>
</main>

<!-- Modal Form -->
<div class="modal-overlay" id="petModal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <div class="modal-left">
            <div class="circle-upload" onclick="document.getElementById('fileInput').click()">
                <span style="font-size: 30px;">📷</span>
                <div style="font-size: 11px; font-weight: 700;">Add Photo</div>
                <input type="file" id="fileInput" hidden>
            </div>
        </div>
        <div class="modal-right">
            <h3 style="margin-top: 0;">Add New Pet Entry</h3>
            <form action="insert" method="post" class="form-grid" enctype="multipart/form-data">
                <div class="form-group"><label>Category</label><input type="text" name="species" placeholder="e.g. Cat" required></div>
                <div class="form-group"><label>Name</label><input type="text" name="name" placeholder="Pet Name" required></div>
                <div class="form-group"><label>Breed</label><input type="text" name="breed" placeholder="e.g. Siamese"></div>
                <div class="form-group"><label>Age</label><input type="number" name="age" placeholder="e.g. 6" required></div>
                <div class="form-group"><label>Vaccinated</label><input type="text" name="vaccinated" placeholder="Yes/No"></div>
                <div class="form-group"><label>Condition</label><input type="text" name="condition" placeholder="Healthy"></div>
                <div class="form-group"><label>Neutered</label><input type="text" name="neutered" placeholder="Yes/No"></div>
                <div class="form-group"><label>Color</label><input type="text" name="color" placeholder="e.g. White"></div>
                <div class="submit-container">
                    <button type="submit" class="submit-btn">Save Pet</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    const modal = document.getElementById('petModal');
    function openModal() { modal.style.display = 'flex'; }
    function closeModal() { modal.style.display = 'none'; }
    window.onclick = function(event) { if(event.target == modal) closeModal(); }
</script>
</body>
</html>

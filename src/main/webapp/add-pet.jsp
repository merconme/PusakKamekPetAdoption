<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pusakkamek.model.User" %>
<%
    User admin = (User) session.getAttribute("currentUser");
    if (admin == null || !"admin".equals(admin.getUserType())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Pet - Pusak Kamek Admin</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Minimal CSS for modal & form */
        .modal { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background: rgba(0,0,0,0.6); justify-content:center; align-items:center; }
        .modal-content { background:white; padding:20px; border-radius:15px; max-width:600px; width:100%; display:flex; gap:20px; }
        .form-group { margin-bottom:15px; }
        .form-group label { display:block; margin-bottom:5px; font-weight:bold; }
        .form-group input { width:100%; padding:8px; border-radius:8px; border:1px solid #ccc; }
        .submit-btn { background:#7a0019; color:white; padding:10px 30px; border:none; border-radius:25px; cursor:pointer; }
        .close-btn { cursor:pointer; font-size:20px; font-weight:bold; }
    </style>
</head>
<body>

<h2>Manage Pets</h2>
<button onclick="openModal()">Add New Pet</button>

<!-- Modal -->
<div class="modal" id="petModal">
    <div class="modal-content">
        <div>
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h3>Add New Pet</h3>
            <form action="AddPetServlet" method="post" enctype="multipart/form-data">
                <div class="form-group"><label>Species</label><input type="text" name="species" placeholder="Cat/Dog" required></div>
                <div class="form-group"><label>Name</label><input type="text" name="name" placeholder="Pet Name" required></div>
                <div class="form-group"><label>Breed</label><input type="text" name="breed" placeholder="e.g. Siamese"></div>
                <div class="form-group"><label>Age</label><input type="number" name="age" placeholder="e.g. 2" required></div>
                <div class="form-group"><label>Vaccination Status</label><input type="text" name="vaccinationStatus" placeholder="Yes/No"></div>
                <div class="form-group"><label>Condition</label><input type="text" name="condition" placeholder="Healthy"></div>
                <div class="form-group"><label>Neutered</label><input type="text" name="neutered" placeholder="Yes/No"></div>
                <div class="form-group"><label>Color</label><input type="text" name="color" placeholder="e.g. White"></div>
                <div class="form-group"><label>Photo</label><input type="file" name="image" accept="image/*" required></div>
                <button type="submit" class="submit-btn">Save Pet</button>
            </form>
        </div>
    </div>
</div>

<script>
    const modal = document.getElementById('petModal');
    function openModal(){ modal.style.display='flex'; }
    function closeModal(){ modal.style.display='none'; }
    window.onclick = function(event){ if(event.target == modal) closeModal(); }
</script>
</body>
</html>

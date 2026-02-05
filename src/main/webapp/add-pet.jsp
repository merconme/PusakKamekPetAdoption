<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pusakkamek.model.Admin" %>
<%
    String cp = request.getContextPath();
    Admin admin = (Admin) session.getAttribute("adminUser");
    if (admin == null) {
        response.sendRedirect(cp + "/admin-login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Pet - Pusak Kamek Admin</title>
    <link rel="stylesheet" href="<%= cp %>/style.css">
   <style>
:root {
    --brand: #7a0019;
    --brand-light: #96102b;
    --bg-soft: #fdf0f1;
    --shadow: 0 12px 35px rgba(0,0,0,0.15);
}

/* Page base */
body {
    margin: 0;
    background: radial-gradient(circle at top, var(--brand-light), var(--brand));
    font-family: 'Poppins', sans-serif;
    color: #333;
}

/* Top bar */
.topbar {
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:25px 6%;
    color:white;
}

.topbar h2 {
    margin:0;
    font-weight:800;
    letter-spacing:0.5px;
}

.btn-outline {
    padding:10px 18px;
    border-radius:25px;
    border:1px solid rgba(255,255,255,0.6);
    color:white;
    text-decoration:none;
    font-weight:600;
    transition:0.3s;
}

.btn-outline:hover {
    background:white;
    color:var(--brand);
}

/* Feedback messages */
.msg {
    margin:0 6% 15px;
    padding:12px 18px;
    border-radius:14px;
    background:rgba(0,255,0,0.12);
    border:1px solid rgba(0,255,0,0.25);
    color:#0b5f16;
    font-weight:700;
}

.err {
    margin:0 6% 15px;
    padding:12px 18px;
    border-radius:14px;
    background:rgba(255,0,0,0.12);
    border:1px solid rgba(255,0,0,0.25);
    color:#8b0000;
    font-weight:700;
}

/* Add button */
button {
    margin-left:6%;
    margin-top:10px;
    background:white;
    color:var(--brand);
    border:none;
    padding:14px 30px;
    border-radius:50px;
    font-weight:800;
    cursor:pointer;
    box-shadow:var(--shadow);
    transition:0.3s;
}

button:hover {
    transform:translateY(-2px);
    background:var(--bg-soft);
}

/* MODAL */
.modal {
    display:none;
    position:fixed;
    inset:0;
    background:rgba(0,0,0,0.75);
    backdrop-filter: blur(8px);
    justify-content:center;
    align-items:center;
    z-index:2000;
}

.modal-content {
    background:white;
    padding:35px 40px;
    border-radius:30px;
    max-width:700px;
    width:95%;
    display:flex;
    gap:25px;
    box-shadow:var(--shadow);
    position:relative;
    animation: pop 0.3s ease;
}

@keyframes pop {
    from { transform:scale(0.95); opacity:0; }
    to { transform:scale(1); opacity:1; }
}

.close-btn {
    position:absolute;
    top:20px;
    right:25px;
    font-size:26px;
    font-weight:800;
    color:#ccc;
    cursor:pointer;
    transition:0.3s;
}

.close-btn:hover {
    color:var(--brand);
}

/* FORM */
form h3 {
    margin-top:0;
    margin-bottom:20px;
    color:var(--brand);
    font-weight:800;
}

.form-group {
    margin-bottom:15px;
}

.form-group label {
    display:block;
    margin-bottom:6px;
    font-size:12px;
    font-weight:700;
    color:#777;
    text-transform:uppercase;
}

.form-group input {
    width:100%;
    padding:12px;
    border-radius:12px;
    border:1px solid #ddd;
    font-size:14px;
}

.form-group input:focus {
    outline:none;
    border-color:var(--brand);
    box-shadow:0 0 0 2px rgba(122,0,25,0.15);
}

/* Submit button */
.submit-btn {
    margin-top:10px;
    width:100%;
    background:var(--brand);
    color:white;
    padding:14px;
    border:none;
    border-radius:30px;
    font-weight:800;
    letter-spacing:0.5px;
    cursor:pointer;
    transition:0.3s;
}

.submit-btn:hover {
    background:var(--brand-light);
}
</style>

</head>
<body>

<div class="topbar">
    <h2>Manage Pets</h2>
    <a href="<%= cp %>/admin/index" class="btn-outline">Back to Dashboard</a>
</div>

<%
    String ok = request.getParameter("ok");
    String err = request.getParameter("err");
    if (ok != null) { %><div class="msg">Pet saved successfully!</div><% }
    if (err != null) { %><div class="err">Failed to save pet. Try again.</div><% }
%>

<button onclick="openModal()">Add New Pet</button>

<!-- Modal -->
<div class="modal" id="petModal">
    <div class="modal-content">
        <div style="width:100%;">
            <span class="close-btn" onclick="closeModal()">&times;</span>
            <h3>Add New Pet</h3>

            <form action="<%= cp %>/AddPetServlet" method="post" enctype="multipart/form-data">
                <div class="form-group"><label>Species</label><input type="text" name="species" placeholder="Cat/Dog" required></div>
                <div class="form-group"><label>Name</label><input type="text" name="name" placeholder="Pet Name" required></div>
                <div class="form-group"><label>Breed</label><input type="text" name="breed" placeholder="e.g. Siamese"></div>
                <div class="form-group"><label>Age</label><input type="number" name="age" min="0" required></div>
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
    window.onclick = function(event){ if(event.target === modal) closeModal(); }
</script>
</body>
</html>

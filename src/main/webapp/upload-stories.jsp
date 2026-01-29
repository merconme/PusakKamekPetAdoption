<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adoption Stories - Pusak Kamek Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        /* Include all your existing styles here */
        :root {
            --brand-maroon: #7a0019;
            --brand-maroon-light: #96102b;
            --shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top, var(--brand-maroon-light), var(--brand-maroon));
            background-attachment: fixed;
            color: white;
            min-height: 100vh;
        }

        /* --- FIXED WHITE NAVBAR --- */
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 0 5%; height: 80px; background: white; position: fixed; top: 0; left: 0; width: 100%; box-sizing: border-box; z-index: 1000; box-shadow: var(--shadow); }
        .logo-section { display: flex; align-items: center; gap: 12px; color: var(--brand-maroon); }
        .logo-circle { background: var(--brand-maroon); color: white; width: 35px; height: 35px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; }
        .logo-text { font-weight: 800; line-height: 1.1; font-size: 18px; text-align: left; }
        .nav-links { display: flex; list-style: none; gap: 5px; margin: 0; padding: 0; }
        .nav-links a { color: #555; text-decoration: none; font-weight: 600; font-size: 14px; padding: 10px 18px; border-radius: 10px; transition: 0.3s; }
        .nav-links a:hover { background: #f8f8f8; color: var(--brand-maroon); }
        .nav-active { background: var(--brand-maroon) !important; color: white !important; }
        .admin-profile { display: flex; align-items: center; gap: 10px; color: var(--brand-maroon); font-weight: 700; }
        .profile-icon { width: 40px; height: 40px; background: #eee; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px; }

        /* --- PAGE HEADER & BACK BUTTON --- */
        .page-header { max-width: 1200px; width: 90%; margin: 120px auto 30px; display: flex; justify-content: space-between; align-items: center; }
        .header-content { text-align: left; }
        h1 { margin: 0; font-size: 32px; font-weight: 800; }
        .subtitle { margin: 5px 0 0; opacity: 0.9; font-size: 16px; font-weight: 400; }
        .back-btn { background: white; color: var(--brand-maroon); text-decoration: none; padding: 10px 20px; border-radius: 12px; font-weight: 600; font-size: 14px; display: flex; align-items: center; gap: 8px; transition: 0.3s; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .back-btn:hover { background: #fdf0f1; transform: translateX(-5px); }

        /* --- STORIES GRID --- */
        .stories-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; padding: 0 5% 50px; max-width: 1200px; margin: 0 auto; }
        .story-card { background: white; color: #333; border-radius: 40px; padding: 20px; display: flex; flex-direction: column; box-shadow: var(--shadow); transition: 0.3s; }
        .story-img { width: 100%; height: 200px; object-fit: cover; border-radius: 30px; margin-bottom: 15px; }
        .story-text { font-size: 14px; line-height: 1.6; text-align: left; margin-bottom: 15px; flex-grow: 1; }
        .add-card { background: rgba(255, 255, 255, 0.1); border: 2px dashed rgba(255, 255, 255, 0.4); color: white; cursor: pointer; justify-content: center; align-items: center; }
        .add-card:hover { background: rgba(255, 255, 255, 0.2); transform: translateY(-5px); }
        .add-icon { font-size: 50px; opacity: 0.7; margin-bottom: 10px; }
        .add-text { font-weight: 700; font-size: 18px; opacity: 0.8; }

        /* --- MODAL --- */
        .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.75); display: none; justify-content: center; align-items: center; z-index: 2000; backdrop-filter: blur(5px); }
        .modal-content { background-color: white; color: #333; width: 90%; max-width: 800px; padding: 40px; border-radius: 40px; display: flex; gap: 30px; position: relative; }
        .close-modal { position: absolute; top: 20px; right: 30px; font-size: 30px; cursor: pointer; color: #ccc; }
        .form-left { flex: 1.5; }
        .form-right { flex: 1; display: flex; flex-direction: column; align-items: center; }
        .field-group { margin-bottom: 20px; }
        label { display: block; font-weight: 700; margin-bottom: 8px; font-size: 14px; color: #555; }
        input[type="text"], textarea { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 15px; font-family: inherit; box-sizing: border-box; }
        textarea { height: 150px; resize: none; }
        .upload-box { width: 100%; height: 180px; background-color: #f9f9f9; border-radius: 25px; display: flex; flex-direction: column; align-items: center; justify-content: center; cursor: pointer; border: 2px dashed #ddd; margin-bottom: 20px; }
        .btn-post { background-color: var(--brand-maroon); color: white; border: none; width: 100%; padding: 15px; border-radius: 15px; font-weight: 800; font-size: 16px; cursor: pointer; transition: 0.3s; }
        .btn-post:hover { background: #5a0012; }
    </style>
</head>
<body>

    <header class="navbar">
        <div class="logo-section">
            <div class="logo-circle">PK</div>
            <div class="logo-text">PUSAK KAMEK<br><small style="font-weight: 400; font-size: 10px; color: #777;">ADMIN PANEL</small></div>
        </div>

        <nav>
            <ul class="nav-links">
                <li><a href="admin-index.jsp">Dashboard</a></li>
                <li><a href="upload-stories.jsp" class="nav-active">Stories</a></li>
                <li><a href="add-petbrowse.jsp">Pets</a></li>
                <li><a href="adopt-history.jsp">Adoptions</a></li>
            </ul>
        </nav>

        <div class="admin-profile">
            <span>Admin</span>
            <div class="profile-icon">👤</div>
        </div>
    </header>

    <div class="page-header">
        <div class="header-content">
            <h1>Success Stories</h1>
            <p class="subtitle">Managing shared adoption memories.</p>
        </div>
        <a href="admin-index.jsp" class="back-btn">
            <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <main class="stories-grid">
        <div class="story-card add-card" onclick="openModal()">
            <div class="add-icon">+</div>
            <div class="add-text">Add New Story</div>
        </div>

        <div class="story-card">
            <img src="https://images.unsplash.com/photo-1526336024174-e58f5cdd8e13?w=400" class="story-img" alt="Mimi">
            <div class="story-text">
                <strong style="display:block; margin-bottom: 5px;">Mimi's New Home</strong>
                Mimi used to hide in her cage. After being adopted, she transformed into a cuddly queen of her household.
            </div>
        </div>

        <div class="story-card">
            <img src="https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400" class="story-img" alt="Cat">
            <div class="story-text">
                <strong style="display:block; margin-bottom: 5px;">Luna's First Year</strong>
                From a stray kitten to a beloved family member. Luna has brought so much joy to the Smith family.
            </div>
        </div>
    </main>

    <div class="modal-overlay" id="storyModal">
        <div class="modal-content">
            <span class="close-modal" onclick="closeModal()">&times;</span>
            <div class="form-left">
                <div class="field-group">
                    <label>Story Title</label>
                    <input type="text" placeholder="e.g. Mimi's New Home">
                </div>
                <div class="field-group">
                    <label>Content</label>
                    <textarea placeholder="Write the success story here..."></textarea>
                </div>
            </div>
            <div class="form-right">
                <label>Cover Image</label>
                <div class="upload-box" onclick="document.getElementById('fileInput').click()">
                    <span style="font-size: 30px;">📷</span>
                    <span style="font-size: 12px; color: #666; font-weight: bold; margin-top: 10px;">Click to Upload</span>
                    <input type="file" id="fileInput" hidden>
                </div>
                <button class="btn-post" onclick="closeModal()">Post Story</button>
            </div>
        </div>
    </div>

    <script>
        const modal = document.getElementById('storyModal');
        function openModal() { modal.style.display = 'flex'; }
        function closeModal() { modal.style.display = 'none'; }
        window.onclick = function(e) { if (e.target == modal) closeModal(); }
    </script>

</body>
</html>

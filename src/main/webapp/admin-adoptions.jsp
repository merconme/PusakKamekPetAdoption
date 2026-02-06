<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pusakkamek.model.AdoptionApplication" %>
<%@ page import="com.pusakkamek.model.Admin" %>

<%
    String cp = request.getContextPath();
    Admin admin = (Admin) session.getAttribute("adminUser");
    if(admin == null){
        response.sendRedirect(cp + "/admin-login.jsp");
        return;
    }

    String adminDisplay = "Admin";
    try { adminDisplay = admin.getUsername(); } catch (Exception e) { adminDisplay = "Admin"; }

    List<AdoptionApplication> list = (List<AdoptionApplication>) request.getAttribute("adoptionList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Adoption Applications - Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
:root{
  --brand:#7a0019;
  --brand2:#96102b;
  --shadow:0 10px 30px rgba(0,0,0,.10);
  --bg:#f7f7f7;
  --line:#e5e7eb;
}
*{box-sizing:border-box}
body{margin:0;font-family:'Poppins',sans-serif;background:var(--bg);}

/* ===== SAME LAYOUT AS admin-index ===== */
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

/* content */
.content{ flex:1; padding:22px 28px 60px; }
h1{margin:0 0 10px;color:#222}
.sub{margin:0 0 18px;color:#666;font-size:13px}

/* table card */
.card{background:#fff;border-radius:18px;box-shadow:var(--shadow);overflow:hidden;border:1px solid #eee}
table{width:100%;border-collapse:collapse}
th,td{padding:14px 16px;border-bottom:1px solid #eee;text-align:left;font-size:13px}
th{background:#fdf0f1;color:var(--brand);font-weight:900}
.small{font-size:12px;color:#555}

/* badges */
.badge{display:inline-block;padding:6px 12px;border-radius:999px;font-weight:900;font-size:12px}
.PENDING{background:#fff3cd;color:#8a6d00}
.APPROVED{background:#e8f7ee;color:#0b5f16}
.REJECTED{background:#fde7e7;color:#8b0000}

/* buttons */
.btn{
  border:none;cursor:pointer;font-weight:900;
  padding:9px 12px;border-radius:12px;
}
.approve{background:#16a34a;color:#fff}
.reject{background:#dc2626;color:#fff}
.approve:disabled,.reject:disabled{opacity:.4;cursor:not-allowed}

/* responsive like your admin-index */
@media (max-width:1100px){ .sidebar{width:240px;} }
@media (max-width:800px){
  .shell{flex-direction:column;}
  .sidebar{width:100%;height:auto;position:relative;}
}
</style>
</head>

<body>
<div class="shell">

  <!-- ✅ LEFT SIDEBAR (EXACT LIKE admin-index) -->
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
      <a class="active" href="<%= cp %>/admin/adoptions"><i class="fa-solid fa-file-lines"></i> Adoptions</a>
      <a href="<%= cp %>/add-petbrowse.jsp"><i class="fa-solid fa-paw"></i> Pets</a>
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

  <!-- ✅ CONTENT -->
  <main class="content">
    <h1>Adoption Applications</h1>
    <p class="sub">Approve or reject user applications.</p>

    <div class="card">
      <table>
        <tr>
          <th>Pet</th>
          <th>Applicant</th>
          <th>Contact</th>
          <th>Reason</th>
          <th>Status</th>
          <th>Action</th>
        </tr>

        <%
          if(list == null || list.isEmpty()){
        %>
          <tr><td colspan="6">No adoption applications yet.</td></tr>
        <%
          } else {
            for(AdoptionApplication a : list){
              String st = (a.getStatus()!=null)? a.getStatus().toUpperCase() : "PENDING";
        %>

        <tr>
          <td>
            <b><%= a.getPetName() %></b>
            <div class="small">Pet ID: <%= a.getPetId() %></div>
          </td>

          <td>
            <%= a.getFullName() %>
            <div class="small">User ID: <%= a.getUserId() %></div>
          </td>

          <td>
            <div class="small"><%= a.getPhone() %></div>
            <div class="small"><%= a.getEmail() %></div>
          </td>

          <td class="small"><%= a.getReason() %></td>

          <td><span class="badge <%= st %>"><%= st %></span></td>

          <td>
            <form action="<%= cp %>/admin/adoptions/update" method="post" style="display:flex;gap:8px;">
              <input type="hidden" name="appId" value="<%= a.getId() %>">
              <input type="hidden" name="petId" value="<%= a.getPetId() %>">

              <button class="btn approve" name="action" value="APPROVE"
                <%= "APPROVED".equals(st) ? "disabled" : "" %>>
                Approve
              </button>

              <button class="btn reject" name="action" value="REJECT"
                <%= "REJECTED".equals(st) ? "disabled" : "" %>>
                Reject
              </button>
            </form>
          </td>
        </tr>

        <% } } %>
      </table>
    </div>
  </main>

</div>
</body>
</html>

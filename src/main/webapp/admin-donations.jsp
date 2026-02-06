<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pusakkamek.model.Donation"%>
<%@ page import="com.pusakkamek.model.Admin"%>

<%!
    private String esc(String s){
        if(s==null) return "";
        return s.replace("&","&amp;")
                .replace("<","&lt;")
                .replace(">","&gt;")
                .replace("\"","&quot;")
                .replace("'","&#39;");
    }
%>

<%
    String cp = request.getContextPath();
    Admin admin = (Admin) session.getAttribute("adminUser");
    if (admin == null) { response.sendRedirect(cp + "/admin-login.jsp"); return; }

    String adminDisplay = "Admin";
    try { adminDisplay = admin.getUsername(); } catch(Exception e){ adminDisplay = "Admin"; }

    List<Donation> donations = (List<Donation>) request.getAttribute("donations");
    if (donations == null) donations = java.util.Collections.emptyList();

    String donationErr = (String) request.getAttribute("donationErr");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Donations - Admin Panel</title>

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
body{margin:0;font-family:'Poppins',sans-serif;background:var(--bg);color:#222;}

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
h1{margin:0 0 6px;color:#222}
.sub{margin:0 0 18px;color:#666;font-size:13px}

.msg{
  display:inline-block;margin:10px 0 18px;padding:10px 14px;border-radius:14px;
  font-weight:900;font-size:13px;border:1px solid transparent;
}
.msg.err{background:#fde7e7;color:#8b0000;border-color:rgba(139,0,0,.15)}

.card{ background:#fff;border-radius:18px;box-shadow:var(--shadow); border:1px solid #eee; overflow:hidden; }
.table-wrap{ overflow:auto; }
table{width:100%;border-collapse:collapse;min-width:900px;}
th,td{padding:12px 14px;border-bottom:1px solid #eee;font-size:13px;text-align:left;vertical-align:top;}
th{background:#fafafa;color:#111;font-weight:900;}
.small{font-size:12px;color:#666}

.btn-back{
  display:inline-flex;align-items:center;gap:8px;
  background:#fff;border:1px solid #eee;color:var(--brand);
  padding:10px 14px;border-radius:12px;text-decoration:none;
  font-weight:900;font-size:13px;box-shadow:var(--shadow);transition:.2s;
  margin:8px 0 16px;
}
.btn-back:hover{transform:translateY(-1px);background:#fdf0f1;}

@media (max-width:1100px){ .sidebar{width:240px;} }
@media (max-width:800px){
  .shell{flex-direction:column;}
  .sidebar{width:100%;height:auto;position:relative;}
  table{min-width:760px;}
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
      <a href="<%= cp %>/add-petbrowse.jsp"><i class="fa-solid fa-paw"></i> Pets</a>
      <a href="<%= cp %>/admin/stories"><i class="fa-solid fa-book"></i> Stories</a>
      <a href="<%= cp %>/admin/volunteers"><i class="fa-solid fa-hand-holding-heart"></i> Volunteers</a>
      <a class="active" href="<%= cp %>/admin/donations"><i class="fa-solid fa-hand-holding-dollar"></i> Donations</a>
    </nav>

    <div class="side-bottom">
      <div class="side-user">
        <div class="av">👤</div>
        <div>Welcome, <%= esc(adminDisplay) %></div>
      </div>
      <a class="logout" href="<%= cp %>/adminLogout">Logout</a>
    </div>
  </aside>

  <main class="content">

    <a href="<%= cp %>/admin/index" class="btn-back">
      <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
    </a>

    <h1>Donations</h1>
    <p class="sub">View who donated (records are stored as PAID).</p>

    <% if (donationErr != null) { %>
      <div class="msg err"><%= esc(donationErr) %></div>
    <% } %>

    <div class="card">
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Donor</th>
              <th>Contact</th>
              <th>Amount (RM)</th>
              <th>Method</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
          <% if (donations.isEmpty()) { %>
            <tr><td colspan="6">No donations found.</td></tr>
          <% } else { %>
            <% for (Donation d : donations) { %>
              <tr>
                <td><%= d.getId() %></td>
                <td>
                  <b><%= esc(d.getDonorName()) %></b>
                  <% if (d.getNote()!=null && !d.getNote().trim().isEmpty()) { %>
                    <div class="small">Note: <%= esc(d.getNote()) %></div>
                  <% } %>
                </td>
                <td>
                  <div class="small"><%= d.getDonorEmail()==null ? "-" : esc(d.getDonorEmail()) %></div>
                  <div class="small"><%= d.getDonorPhone()==null ? "-" : esc(d.getDonorPhone()) %></div>
                </td>
                <td><%= String.format("%.2f", d.getAmount()) %></td>
                <td>
                  <b><%= esc(d.getMethod()) %></b>
                  <% if (d.getBank()!=null && !d.getBank().trim().isEmpty()) { %>
                    <div class="small">Bank: <%= esc(d.getBank()) %></div>
                  <% } else { %>
                    <div class="small">Bank: -</div>
                  <% } %>
                </td>
                <td><%= d.getCreatedAt()==null ? "-" : d.getCreatedAt() %></td>
              </tr>
            <% } %>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>

  </main>

</div>
</body>
</html>

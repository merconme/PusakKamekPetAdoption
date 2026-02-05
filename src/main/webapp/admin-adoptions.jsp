<%-- 
    Document   : admin-adoptions
    Created on : 5 Feb 2026, 8:22:34 pm
    Author     : USER
--%>

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

    List<AdoptionApplication> list = (List<AdoptionApplication>) request.getAttribute("adoptionList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Adoption Applications - Admin</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

<style>
:root{
  --brand:#7a0019;
  --brand-light:#96102b;
  --shadow:0 10px 30px rgba(0,0,0,.10);
  --bg:#f7f7f7;
}
body{margin:0;font-family:'Poppins',sans-serif;background:var(--bg);}

.navbar{
  display:flex;justify-content:space-between;align-items:center;
  padding:18px 6%;
  background:#fff;box-shadow:var(--shadow);
}
.brand{font-weight:900;color:var(--brand);line-height:1.1}
.brand small{display:block;font-weight:600;color:#777;margin-top:2px;font-size:11px}
.nav a{margin-left:12px;text-decoration:none;color:#555;font-weight:800;padding:8px 14px;border-radius:999px}
.nav a:hover{background:#fdf0f1;color:var(--brand)}
.active{background:var(--brand);color:#fff !important}

.wrap{padding:22px 6% 60px;}
h1{margin:0 0 10px;color:#222}
.sub{margin:0 0 18px;color:#666;font-size:13px}

.card{background:#fff;border-radius:18px;box-shadow:var(--shadow);overflow:hidden}
table{width:100%;border-collapse:collapse}
th,td{padding:14px 16px;border-bottom:1px solid #eee;text-align:left;font-size:13px}
th{background:#fdf0f1;color:var(--brand);font-weight:900}

.badge{display:inline-block;padding:6px 12px;border-radius:999px;font-weight:900;font-size:12px}
.PENDING{background:#fff3cd;color:#8a6d00}
.APPROVED{background:#e8f7ee;color:#0b5f16}
.REJECTED{background:#fde7e7;color:#8b0000}

.btn{
  border:none;cursor:pointer;font-weight:900;
  padding:9px 12px;border-radius:12px;
}
.approve{background:#16a34a;color:#fff}
.reject{background:#dc2626;color:#fff}
.approve:disabled,.reject:disabled{opacity:.4;cursor:not-allowed}

.small{font-size:12px;color:#555}
</style>
</head>

<body>

<header class="navbar">
  <div class="brand">
    PUSAK KAMEK
    <small>ADMIN PANEL</small>
  </div>

   <div class="nav">
    <a href="<%= cp %>/admin/index">Dashboard</a>
    <a class="active" href="<%= cp %>/admin/adoptions">Adoptions</a>
    <a href="<%= cp %>/add-petbrowse.jsp">Pets</a>
    <a href="<%= cp %>/adminLogout" style="color:#b00020;">Logout</a>
  </div>
</header>

<main class="wrap">
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
        <td><b><%= a.getPetName() %></b><div class="small">Pet ID: <%= a.getPetId() %></div></td>
        <td><%= a.getFullName() %><div class="small">User ID: <%= a.getUserId() %></div></td>
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

</body>
</html>


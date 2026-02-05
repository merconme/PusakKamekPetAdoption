<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.pusakkamek.model.Admin" %>

<%
    String cp = request.getContextPath();
    Admin admin = (Admin) session.getAttribute("adminUser");
    if (admin == null) {
        response.sendRedirect(cp + "/admin-login.jsp");
        return;
    }

    String active = (String) request.getAttribute("active");
    if (active == null) active = "";
%>

<link rel="stylesheet" href="<%= cp %>/admin.css">

<header class="admin-nav">
    <div class="admin-brand">
        <div class="admin-title">PUSAK KAMEK</div>
        <div class="admin-sub">ADMIN PANEL</div>
    </div>

    <nav class="admin-links">
        <a class="<%= active.equals("dashboard") ? "active" : "" %>"
           href="<%= cp %>/admin/index">Dashboard</a>

        <a class="<%= active.equals("pets") ? "active" : "" %>"
           href="<%= cp %>/add-petbrowse.jsp">Pets</a>

        <a class="<%= active.equals("stories") ? "active" : "" %>"
           href="<%= cp %>/upload-stories.jsp">Stories</a>

        <a class="<%= active.equals("adoptions") ? "active" : "" %>"
           href="<%= cp %>/admin/adoptions">Adoptions</a>

        <a class="logout" href="<%= cp %>/admin/logout">Logout</a>
    </nav>

    <div class="admin-user">
        <span><%= admin.getUsername() %></span>
        <span class="admin-user-icon">👤</span>
    </div>
</header>

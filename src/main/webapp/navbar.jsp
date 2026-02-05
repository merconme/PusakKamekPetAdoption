<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String cp = request.getContextPath();
%>

<nav>
    <ul>
        <li><a href="<%= cp %>/index.jsp" class="nav-link-active">Home</a></li>
        <li><a href="<%= cp %>/stories.jsp">Stories</a></li>
        <li><a href="<%= cp %>/petbrowse.jsp">Pet</a></li>
        <li><a href="<%= cp %>/adopt.jsp">Adopt</a></li>
        <li><a href="<%= cp %>/foster-details.jsp">Foster</a></li>
        <li><a href="<%= cp %>/donation.jsp">Donate</a></li>
        <li><a href="<%= cp %>/volunteer.jsp">Volunteer</a></li>
    </ul>
</nav>

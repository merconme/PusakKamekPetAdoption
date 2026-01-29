<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pusakkamek.model.Pet"%>

<%
    Pet pet = (Pet) request.getAttribute("pet");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Pet - Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
        }
        .container {
            width: 500px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
        }
        h2 {
            text-align: center;
            color: #7a0019;
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        button {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            background: #7a0019;
            color: white;
            border: none;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
        }
        button:hover {
            background: #5a0012;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Update Pet</h2>

    <form action="adminPet" method="post">

        <!-- IMPORTANT -->
        <input type="hidden" name="id" value="<%= pet.getId() %>">

        <label>Pet Name</label>
        <input type="text" name="name" value="<%= pet.getName() %>" required>

        <label>Species</label>
        <select name="species">
            <option value="Dog" <%= pet.getSpecies().equals("Dog") ? "selected" : "" %>>Dog</option>
            <option value="Cat" <%= pet.getSpecies().equals("Cat") ? "selected" : "" %>>Cat</option>
        </select>

        <label>Age (Years)</label>
        <input type="number" name="age" value="<%= pet.getAge() %>" required>

        <label>Status</label>
        <select name="status">
            <option value="Available" <%= pet.getStatus().equals("Available") ? "selected" : "" %>>Available</option>
            <option value="Adopted" <%= pet.getStatus().equals("Adopted") ? "selected" : "" %>>Adopted</option>
            <option value="Pending" <%= pet.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
        </select>

        <label>Image URL</label>
        <input type="text" name="image" value="<%= pet.getImageUrl() %>">

        <button type="submit">Update Pet</button>
    </form>
</div>

</body>
</html>

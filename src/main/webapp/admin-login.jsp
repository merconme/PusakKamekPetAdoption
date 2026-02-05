<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cp = request.getContextPath();
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pusak Kamek | Admin Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #7a0019, #96102b);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-card {
            background: white;
            width: 360px;
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .login-card h1 {
            text-align: center;
            margin-bottom: 5px;
            color: #7a0019;
        }

        .login-card p {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
            font-size: 14px;
        }

        .login-card label {
            font-weight: 600;
            font-size: 14px;
            color: #333;
        }

        .login-card input {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            margin-bottom: 18px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        .login-card button {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: none;
            background: #7a0019;
            color: white;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        .login-card button:hover {
            background: #a30022;
        }

        .error-msg {
            color: red;
            text-align: center;
            font-size: 14px;
            margin-top: 10px;
        }

        .admin-tag {
            text-align: center;
            font-size: 12px;
            color: #999;
            margin-top: 20px;
        }
    </style>
</head>

<body>

<div class="login-card">
    <h1>Admin Login</h1>
    <p>Authorized personnel only</p>

    <form action="<%= cp %>/adminLogin" method="post">
        <label>Username</label>
        <input type="text" name="username" placeholder="Admin username" required>

        <label>Password</label>
        <input type="password" name="password" placeholder="••••••••" required>

        <button type="submit">Login</button>
    </form>

    <% if (error != null) { %>
        <div class="error-msg"><%= error %></div>
    <% } %>

    <div class="admin-tag">
        Pusak Kamek • Admin Panel
    </div>
</div>

</body>
</html>

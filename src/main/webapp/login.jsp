<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pusak Kamek - Login</title>

    <style>
        body.login-body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }
        .login-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 350px;
        }
        .login-card h1 {
            text-align: center;
            color: #7a0019;
            margin-bottom: 20px;
        }
        .login-card p {
            text-align: center;
            color: #555;
            margin-bottom: 30px;
        }
        .login-card form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .login-card input {
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 16px;
            width: 100%;
        }
        .login-card button {
            padding: 12px;
            border-radius: 10px;
            border: none;
            background-color: #7a0019;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>

<body class="login-body">

<div class="login-card">
    <h1>Welcome to Pusak Kamek</h1>
    <p>Please login to continue</p>

    <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
        <input type="text" name="username" placeholder="Email or Phone" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error-message"><%= error %></div>
    <%
        }
    %>
</div>

</body>
</html>

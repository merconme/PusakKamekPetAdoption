<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Login</title>

    <!-- CSS -->
    <link rel="stylesheet" href="style.css">
</head>

<body class="login-body">

<div class="split-login-card">

    <div class="login-visual">
        <img src="https://images.unsplash.com/photo-1592194996308-7b43878e84a6?auto=format&fit=crop&q=80&w=800"
             alt="Kitten">
    </div>

    <div class="login-glass-form">
        <h1>Welcome to Pusak Kamek</h1>
        <p>Please enter your login details</p>

        <!-- Login Form -->
        <form action="LoginServlet" method="post">

            <div class="modern-input-group">
                <label>Username</label>
                <input type="text" name="username"
                       placeholder="Enter your username" required>
            </div>

            <div class="modern-input-group">
                <label>Password</label>
                <input type="password" name="password"
                       placeholder="********" required>
            </div>

            <button type="submit" class="btn-signin">Login</button>
        </form>

        <!-- Error Message from Servlet -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <p style="color:red; margin-top:10px;"><%= error %></p>
        <%
            }
        %>

        <div class="login-options">
            <a href="#">Forgot password?</a>
            <span style="margin: 0 10px; opacity: 0.3;">|</span>
            <a href="register.jsp">Create account</a>
        </div>
    </div>

</div>

</body>
</html>

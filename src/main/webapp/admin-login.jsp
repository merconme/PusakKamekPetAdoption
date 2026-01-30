<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Login | Pusak Kamek</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

<style>
    body {
        margin: 0;
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #7a0019, #b1122f);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .login-box {
        background: #fff;
        width: 380px;
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.2);
    }

    .login-box h2 {
        text-align: center;
        margin-bottom: 10px;
        color: #7a0019;
    }

    .login-box p {
        text-align: center;
        color: #666;
        margin-bottom: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 6px;
        font-weight: 600;
        color: #333;
    }

    .form-group input {
        width: 100%;
        padding: 12px;
        border-radius: 10px;
        border: 1px solid #ccc;
        font-size: 14px;
    }

    .form-group input:focus {
        outline: none;
        border-color: #7a0019;
    }

    .btn-login {
        width: 100%;
        padding: 12px;
        background: #7a0019;
        border: none;
        border-radius: 10px;
        color: #fff;
        font-weight: 700;
        font-size: 15px;
        cursor: pointer;
        transition: 0.3s;
    }

    .btn-login:hover {
        background: #96102b;
    }

    .error {
        background: #ffe6e6;
        color: #b1122f;
        padding: 10px;
        border-radius: 8px;
        text-align: center;
        margin-bottom: 15px;
        font-size: 14px;
    }

    .back-link {
        margin-top: 20px;
        text-align: center;
    }

    .back-link a {
        color: #7a0019;
        text-decoration: none;
        font-weight: 600;
    }
</style>
</head>

<body>

<div class="login-box">
    <h2>Admin Login</h2>
    <p>Pusak Kamek Administration</p>

    <%-- Error message from servlet --%>
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>

    <!-- ✅ FIXED FORM ACTION -->
    <form action="<%= request.getContextPath() %>/adminLogin" method="post">
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" required placeholder="••••••••">
        </div>

        <button type="submit" class="btn-login">Login</button>
    </form>

    <div class="back-link">
        <a href="login.jsp">← Back to User Login</a>
    </div>
</div>

</body>
</html>

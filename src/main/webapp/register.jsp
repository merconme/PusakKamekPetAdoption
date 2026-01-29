<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Join Us</title>
    <link rel="stylesheet" href="style.css">
</head>
<body class="register-body">

    <div class="compact-register-card">
        <h1>Welcome to Pusak Kamek</h1>
        <p>Create an account to get started.</p>

        <!-- Registration form submits to RegisterServlet -->
        <form action="RegisterServlet" method="post">
            <div class="register-field">
                <label>Full Name</label>
                <input type="text" name="fullname" placeholder="Your Name" required>
            </div>

            <div class="register-field">
                <label>Email</label>
                <input type="email" name="email" placeholder="email@domain.com" required>
            </div>

            <div class="register-field">
                <label>Phone Number</label>
                <input type="tel" name="phone" placeholder="012-3456789" required>
            </div>

            <div class="register-field">
                <label>Password</label>
                <input type="password" name="password" placeholder="••••••••" required>
            </div>

            <div class="register-field">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-register">Register Now</button>
        </form>

        <div class="register-footer">
            Already registered? <a href="login.jsp">Login</a>
        </div>
    </div>

</body>
</html>

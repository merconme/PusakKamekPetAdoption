<%-- 
    Document   : foster-application
    Created on : 27 Jan 2026, 3:52:01 am
    Author     : USER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Foster Application</title>
    <link rel="stylesheet" href="style.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --soft-pink: #FFF0F1;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 16px;
            background-color: var(--soft-pink);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: var(--brand-maroon);
            color: white;
        }

        .logo-text { font-weight: bold; line-height: 1.2; font-size: 18px; }
        .logo-text small { font-weight: normal; font-size: 12px; }

        .navbar nav ul {
            display: flex;
            list-style: none;
            gap: 30px;
            margin: 0;
            padding: 0;
        }

        .navbar nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            padding: 8px 16px;
            border-radius: 20px;
            transition: 0.3s;
        }

        .nav-link-active {
            background-color: rgba(0, 0, 0, 0.2);
        }

        .user-profile-icon a {
            font-size: 24px;
            text-decoration: none;
            color: white;
            cursor: pointer;
        }

        .page-wrapper { padding: 40px 5%; }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 50px;
            border-radius: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .form-header { margin-bottom: 40px; }
        .form-header h1 {
            color: var(--brand-maroon);
            margin: 0 0 10px 0;
            font-size: 32px;
        }
        .form-header p { color: #666; line-height: 1.6; }

        .application-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-row { display: flex; gap: 20px; }
        .form-group { flex: 1; display: flex; flex-direction: column; gap: 8px; }
        .full-width { width: 100%; }

        label { font-weight: bold; color: #444; }
        input, select { padding: 12px 15px; border: 1px solid #ddd; border-radius: 10px; font-size: 16px; font-family: inherit; }

        .checkbox-container { display: flex; align-items: center; gap: 10px; margin-top: 10px; font-size: 14px; color: #555; }

        .form-actions { display: flex; gap: 15px; margin-top: 20px; }
        .btn-submit {
            background-color: var(--brand-maroon);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 30px;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
            transition: 0.3s;
        }
        .btn-reset {
            background-color: #eee;
            color: #444;
            border: none;
            padding: 15px 30px;
            border-radius: 30px;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-submit:hover { opacity: 0.9; transform: translateY(-2px); }

        @media (max-width: 768px) {
            .navbar nav { display: none; }
            .form-row { flex-direction: column; }
            .container { padding: 30px; }
        }
    </style>
</head>
<body>

<header class="navbar">
    <div class="logo-text">PUSAK KAMEK<br><small>Rescue - Rehome - Rebuild</small></div>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="stories.jsp">Stories</a></li>
            <li><a href="petbrowse.jsp">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
            <li><a href="foster-details.jsp" class="nav-link-active">Foster</a></li>
            <li><a href="donate.jsp">Donate</a></li>
            <li><a href="volunteer.jsp">Volunteer</a></li>
        </ul>
    </nav>
    <div class="user-profile-icon">
        <a href="profile.jsp">👤</a>
    </div>
</header>

<main class="page-wrapper">
    <div class="container">
        
        <div class="form-header">
            <h1>Apply to Foster a Pet</h1>
            <p>Please fill in your details. Your information helps us decide which pet is suitable for your home environment.</p>
        </div>

        <form class="application-form" action="foster-submit.jsp" method="post">
            
            <div class="form-row">
                <div class="form-group">
                    <label>Full Name *</label>
                    <input type="text" name="fullname" placeholder="e.g. Yasmine" required>
                </div>
                <div class="form-group">
                    <label>Age *</label>
                    <input type="number" name="age" placeholder="e.g. 18" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Email *</label>
                    <input type="email" name="email" placeholder="you@gmail.com" required>
                </div>
                <div class="form-group">
                    <label>Phone *</label>
                    <input type="tel" name="phone" placeholder="012-3456789" required>
                </div>
            </div>

            <div class="form-group full-width">
                <label>Address *</label>
                <input type="text" name="address" placeholder="Enter your full home address" required>
            </div>

            <div class="form-row" style="margin-top: 10px;">
                <div class="form-group">
                    <label>Type of Residence</label>
                    <select name="residence">
                        <option value="">Select</option>
                        <option value="apartment">Apartment</option>
                        <option value="house">Landed House</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Do you have pets at home?</label>
                    <select name="hasPets">
                        <option value="">Select</option>
                        <option value="yes">Yes</option>
                        <option value="no">No</option>
                    </select>
                </div>
            </div>

            <div class="form-group" style="max-width: 48%;">
                <label>Preferred Foster Duration</label>
                <select name="fosterDuration">
                    <option value="">Select</option>
                    <option value="short">Short-term (1-4 weeks)</option>
                    <option value="long">Long-term (1 month+)</option>
                </select>
            </div>

            <div class="checkbox-container">
                <input type="checkbox" id="confirm" name="confirm" required>
                <label for="confirm">I confirm that the information is true and I agree to a background check if required</label>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-submit">Submit Application</button>
                <button type="reset" class="btn-reset">Reset</button>
            </div>

        </form>
    </div>
</main>

</body>
</html>

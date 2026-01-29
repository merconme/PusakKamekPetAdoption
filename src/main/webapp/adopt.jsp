<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pusakkamek.model.User"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pusak Kamek - Adoption Process</title>

    <style>
        :root {
            --brand-maroon: #7a0019;
            --white: #ffffff;
            --light-peach: #fff5f6;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: var(--brand-maroon);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            color: white;
        }

        .navbar ul {
            display: flex;
            list-style: none;
            gap: 20px;
            margin: 0;
            padding: 0;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
        }

        .nav-link-active {
            background-color: rgba(0,0,0,0.2);
        }

        .page-wrapper {
            padding: 40px 5%;
            display: flex;
            justify-content: center;
        }

        .content-card {
            background: white;
            max-width: 1000px;
            width: 100%;
            padding: 50px;
            border-radius: 40px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        h1 {
            color: var(--brand-maroon);
            font-size: 36px;
            margin-top: 0;
        }

        .subtitle {
            color: #666;
            margin-bottom: 40px;
            font-size: 18px;
        }

        .process-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px,1fr));
            gap: 20px;
            margin-bottom: 50px;
        }

        .step-card {
            border: 2px solid #fce8eb;
            padding: 25px;
            border-radius: 25px;
            transition: 0.3s;
        }

        .step-number {
            background: var(--brand-maroon);
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-weight: bold;
        }

        .info-box {
            background: var(--light-peach);
            padding: 30px;
            border-radius: 25px;
            text-align: left;
            margin-bottom: 40px;
        }

        .btn-adopt {
            background: var(--brand-maroon);
            color: white;
            padding: 18px 50px;
            border-radius: 40px;
            font-weight: bold;
            font-size: 18px;
            text-decoration: none;
            display: inline-block;
            transition: 0.3s;
        }

        .btn-adopt:hover {
            transform: scale(1.05);
        }

        .history-link {
            display: block;
            text-align: right;
            font-weight: bold;
            margin-bottom: 20px;
            color: var(--brand-maroon);
            text-decoration: none;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<header class="navbar">
    <div>
        <strong>PUSAK KAMEK</strong><br>
        <small>Rescue · Rehome · Rebuild</small>
    </div>
    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="petbrowse.jsp">Pet</a></li>
            <li><a href="adopt.jsp" class="nav-link-active">Adopt</a></li>
            <li><a href="profile.jsp">👤</a></li>
        </ul>
    </nav>
</header>

<!-- CONTENT -->
<main class="page-wrapper">
    <div class="content-card">

        <a href="AdoptHistoryServlet" class="history-link">
            View My Adoption Status & History →
        </a>

        <h1>Start Your Adoption Journey</h1>
        <p class="subtitle">
            Bringing a new family member home is a rewarding 4-step process.
        </p>

        <div class="process-container">
            <div class="step-card">
                <div class="step-number">1</div>
                <h3>Find Your Match</h3>
                <p>Browse our available pets and find the one that suits you.</p>
            </div>
            <div class="step-card">
                <div class="step-number">2</div>
                <h3>Application</h3>
                <p>Fill in the adoption form with your experience details.</p>
            </div>
            <div class="step-card">
                <div class="step-number">3</div>
                <h3>Interview</h3>
                <p>Meet-and-greet session to ensure compatibility.</p>
            </div>
            <div class="step-card">
                <div class="step-number">4</div>
                <h3>Welcome Home</h3>
                <p>Complete paperwork and start your life together.</p>
            </div>
        </div>

        <div class="info-box">
            <h2>Things to Know Before Applying</h2>
            <ul>
                <li><strong>Commitment:</strong> 10–15 years lifetime care.</li>
                <li><strong>Recovery Fee:</strong> Covers medical & vaccinations.</li>
                <li><strong>Home Check:</strong> Virtual or physical review.</li>
                <li><strong>Supplies:</strong> Prepare food and basic needs.</li>
            </ul>
        </div>

        <a href="petbrowse.jsp" class="btn-adopt">
            Browse Available Pets
        </a>

    </div>
</main>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - How You Can Help</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <header class="navbar">
        <div class="logo-text">PUSAK KAMEK<br><small>Rescue - Rehome - Rebuild</small></div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="support.jsp" class="nav-link-active">Stories</a></li>
                <li><a href="petbrowse.jsp">Pet</a></li>
                <li><a href="adopt.jsp">Adopt</a></li>
                <li><a href="foster-details.jsp">Foster</a></li>
                <li><a href="donation.jsp">Donate</a></li>
                <li><a href="volunteer.jsp">Volunteer</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <a href="login.jsp" class="btn-outline">Login</a>
            <a href="register.jsp" class="btn-outline">Sign up</a>
        </div>
    </header>

    <main class="page-wrapper">
        <div class="container">
            
            <h2 class="section-title">How You Can Help</h2>
            <div class="help-grid">
                <div class="help-card">
                    <h3>Donate</h3>
                    <p>Support medical care, food and shelter for rescued animals.</p>
                    <a href="donation.jsp" class="btn-main btn-how">How Donation Works</a>
                </div>

                <div class="help-card">
                    <h3>Foster</h3>
                    <p>Offer a temporary home while pets recover and wait for adoption.</p>
                    <a href="foster-details.jsp" class="btn-main btn-how">How Fostering Works</a>
                </div>

                <div class="help-card">
                    <h3>Volunteer</h3>
                    <p>Train with our programmes and join daily care or events.</p>
                    <a href="volunteer.jsp" class="btn-main btn-how">How Volunteering Works</a>
                </div>
            </div>

            <h2 class="section-title" style="margin-top: 50px;">Our Facilities & Contact</h2>
            <div class="contact-flex">
                <div class="map-box">
                    <img src="https://via.placeholder.com/400x300?text=Map+View" alt="Map Location">
                </div>
                <div class="contact-info-card">
                    <p><strong>Address:</strong> Pusak Kamek Lot 284<br>
                    (Ground Floor Sec.12 KTLD, Jln Haji Taha, Kampung Bandarshah, 93400 Kuching, Sarawak)</p>
                    <p><strong>Phone:</strong> 012-3456789</p>
                    <p><strong>Email:</strong> pusakkamek@gmail.com</p>
                </div>
            </div>

        </div>
    </main>

    <footer class="bottom-bar"></footer>

</body>
</html>

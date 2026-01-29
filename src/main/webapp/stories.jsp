<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Success Stories</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --brand-maroon: #7a0019;
            --beige: #FFF8DC;
        }

        body { 
            background-color: var(--beige); 
            margin: 0; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        }

        /* --- Navbar Styles --- */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5%;
            background-color: var(--brand-maroon);
            color: white;
        }

        .logo-text { font-weight: bold; line-height: 1.2; }
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
            transition: 0.3s;
        }

        /* --- Hero Section --- */
        .hero-banner {
            background-color: var(--brand-maroon);
            color: white;
            text-align: center;
            padding: 60px 20px;
        }

        .hero-banner h1 { margin: 0; font-size: 42px; }
        .hero-banner p { font-style: italic; opacity: 0.9; margin-top: 10px; }

        /* --- Story Grid --- */
        .wrapper {
            max-width: 1100px;
            margin: -30px auto 60px;
            padding: 0 20px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
        }

        .story-card {
            background: white;
            border-radius: 40px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .story-card:hover {
            transform: translateY(-10px);
        }

        .story-img {
            width: 100%;
            height: 280px;
            object-fit: cover;
            border-bottom: 5px solid #fce8eb;
        }

        .story-info {
            padding: 30px;
        }

        .story-info h2 {
            color: var(--brand-maroon);
            margin: 0 0 5px 0;
            font-size: 26px;
        }

        .story-tag {
            color: var(--brand-maroon);
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: bold;
            display: block;
            margin-bottom: 15px;
            background-color: #fce8eb;
            padding: 5px 15px;
            border-radius: 20px;
            width: fit-content;
        }

        .story-desc {
            color: #444;
            line-height: 1.7;
            font-size: 15px;
            margin-bottom: 0;
        }

        @media (max-width: 768px) {
            .hero-banner h1 { font-size: 32px; }
            .wrapper { margin-top: 20px; }
            .navbar nav { display: none; }
        }
    </style>
</head>
<body>

    <header class="navbar">
        <div class="logo-text">PUSAK KAMEK<br><small>Rescue - Rehome - Rebuild</small></div>
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="stories.jsp" class="nav-link-active">Stories</a></li>
                <li><a href="petbrowse.jsp">Pet</a></li>
                <li><a href="adopt.jsp">Adopt</a></li>
                <li><a href="foster.jsp">Foster</a></li>
                <li><a href="donate.jsp">Donate</a></li>
                <li><a href="volunteer.jsp">Volunteer</a></li>
            </ul>
        </nav>
        <div class="user-profile-icon">
            <a href="profile.jsp">👤</a>
        </div>
    </header>

    <div class="hero-banner">
        <h1>Success Stories</h1>
        <p>Every pet deserves a second chance at a "Happy Ever After".</p>
    </div>

    <div class="wrapper">
        <div class="story-card">
            <img src="https://images.unsplash.com/photo-1573865668131-974279df4a14?auto=format&fit=crop&w=600&q=80" alt="Ciko" class="story-img">
            <div class="story-info">
                <span class="story-tag">Adopted by Ahmad Izwan</span>
                <h2>Ciko</h2>
                <p class="story-desc">
                    Ahmad found his perfect companion in Ciko. From a nervous stray at Waterfront to the king of the house, Ciko now spends his days lounging on silk pillows and keeping Ahmad entertained with his playful antics.
                </p>
            </div>
        </div>

        <div class="story-card">
            <img src="https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?auto=format&fit=crop&w=600&q=80" alt="Avantiz" class="story-img">
            <div class="story-info">
                <span class="story-tag">Adopted by Sarah Tan</span>
                <h2>Avantiz</h2>
                <p class="story-desc">
                    Sarah Tan knew Avantiz was special from the moment they met. Despite his unique appearance, he has settled perfectly into Sarah's home, where he enjoys exploring the garden every single afternoon.
                </p>
            </div>
        </div>

        <div class="story-card">
            <img src="https://images.unsplash.com/photo-1601758228041-f3b2795255f1?auto=format&fit=crop&w=600&q=80" alt="RedBulz" class="story-img">
            <div class="story-info">
                <span class="story-tag">Adopted by Liza Wong</span>
                <h2>RedBulz</h2>
                <p class="story-desc">
                    RedBulz was rescued from a high-risk situation, but Liza Wong gave him the safety he deserved. He is now a healthy, happy glider who is inseparable from his best friend and guardian, Liza.
                </p>
            </div>
        </div>
    </div>

</body>
</html>

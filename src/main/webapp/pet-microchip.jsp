<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pusak Kamek - Microchip & Legal Identity</title>

    <style>
        :root {
            --maroon: #7a0019;
            --brand-maroon: #7a0019;
            --light-pink: #fce8eb;
            --alert-yellow: #fef9c3;
            --btn-maroon: #912e3f;
            --text-dark: #333;
            --navbar-hover: rgba(0, 0, 0, 0.2);
        }

        body {
            background-color: var(--brand-maroon);
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            padding: 15px 5%;
            background: var(--brand-maroon);
            color: white;
        }

        .navbar ul {
            display: flex;
            list-style: none;
            gap: 20px;
            padding: 0;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 20px;
        }

        .nav-link-active { background: var(--navbar-hover); }

        .page-wrapper {
            background: #FFF8DC;
            padding: 40px 20px;
            min-height: 100vh;
        }

        .legal-container {
            background: white;
            border-radius: 40px;
            max-width: 1000px;
            margin: auto;
            padding: 30px;
        }

        .legal-grid {
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 25px;
        }

        .data-card {
            background: #fcf1f3;
            padding: 30px;
            border-radius: 25px;
        }

        .data-list li {
            margin-bottom: 12px;
            border-bottom: 1px solid #eee;
            padding-bottom: 6px;
        }

        .btn-print {
            background: var(--btn-maroon);
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 12px;
            font-weight: bold;
            display: block;
            margin: 20px auto 0;
            cursor: pointer;
        }

        .alert-box {
            border-radius: 20px;
            padding: 20px;
        }

        .alert-pink { background: var(--light-pink); }
        .alert-yellow { background: var(--alert-yellow); }

        .alert-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .btn-reg {
            background: var(--btn-maroon);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 12px;
            font-weight: bold;
            flex: 1;
        }

        .btn-report {
            background: #d32f2f;
            color: white;
            padding: 12px;
            border-radius: 12px;
            text-align: center;
            text-decoration: none;
            flex: 1;
        }

        @media (max-width: 768px) {
            .legal-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body>

<header class="navbar">
    <div>
        <strong>PUSAK KAMEK</strong><br>
        <small>Rescue - Rehome - Rebuild</small>
    </div>

    <nav>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="petbrowse.jsp" class="nav-link-active">Pet</a></li>
            <li><a href="adopt.jsp">Adopt</a></li>
        </ul>
    </nav>
</header>

<main class="page-wrapper">
    <div class="legal-container">

        <h2 style="text-align:center;">
            Legal Identity: ${pet.name}
        </h2>

        <div class="legal-grid">

            <!-- LEFT -->
            <div class="data-card">
                <h3 style="text-align:center;">Pet Data & Implant Details</h3>

                <ul class="data-list">
                    <li><strong>Pet Name:</strong> ${pet.name}</li>
                    <li><strong>Breed:</strong> ${pet.breed}</li>
                    <li><strong>Microchip ID:</strong> ${pet.microchipId}</li>
                    <li><strong>Implanted By:</strong> ${pet.implantedBy}</li>
                    <li><strong>Implant Date:</strong> ${pet.implantDate}</li>
                    <li><strong>Status:</strong> ${pet.status}</li>
                </ul>

                <button class="btn-print" onclick="window.print()">Print ID Card</button>
            </div>

            <!-- RIGHT -->
            <div>
                <div class="alert-box alert-pink">
                    🚨 <strong>Sarawak Compliance:</strong>
                    Microchip registration is mandatory under local regulations.
                </div>

                <div class="alert-box alert-yellow">
                    <strong>ACTION REQUIRED:</strong>
                    Transfer ownership after adoption.

                    <div class="alert-actions">
                        <form action="TransferMicrochipServlet" method="post">
                            <input type="hidden" name="petId" value="${pet.petId}">
                            <button class="btn-reg">Transfer Ownership</button>
                        </form>

                        <a href="pet-lost.jsp?petId=${pet.petId}" class="btn-report">
                            ⚠️ Report Lost
                        </a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</main>

</body>
</html>

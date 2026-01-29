<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Microchip & Legal Identity</title>
    <link rel="stylesheet" href="style.css">

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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .page-wrapper {
            background-color: #FFF8DC;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .legal-container {
            background-color: white;
            border-radius: 40px;
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .legal-grid {
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 20px;
        }

        .data-card {
            background-color: #fcf1f3;
            border-radius: 20px;
            padding: 25px;
            border: 1px solid #f0d0d5;
        }

        .data-list {
            list-style: none;
            padding: 0;
        }

        .data-list li {
            margin-bottom: 15px;
            font-size: 15px;
        }

        .btn-print {
            background-color: var(--btn-maroon);
            color: white;
            border: none;
            padding: 10px 40px;
            border-radius: 12px;
            font-weight: bold;
            cursor: pointer;
            display: block;
            margin: 20px auto 0;
        }

        @media (max-width: 768px) {
            .legal-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<!-- ✅ Reusable Navbar -->
<jsp:include page="navbar.jsp" />

<main class="page-wrapper">
    <div class="legal-container">

        <div style="text-align:center;">
            <h2>Microchip & Legal Identity</h2>
        </div>

        <div class="legal-grid">

            <!-- LEFT COLUMN -->
            <div class="data-card">
                <h3 style="text-align:center;">Pet Data & Implant Details</h3>

                <ul class="data-list">
                    <li><strong>Pet Name :</strong> ${pet.name}</li>
                    <li><strong>Breed :</strong> ${pet.breed}</li>
                    <li><strong>Microchip ID :</strong> ${pet.microchipId}</li>
                    <li><strong>Implanted By :</strong> ${pet.vet}</li>
                    <li><strong>Implant Date :</strong> ${pet.implantDate}</li>
                    <li><strong>Registered Org :</strong> PUSAK-KAMEK</li>
                    <li><strong>Next Scan :</strong> ${pet.nextScan}</li>
                </ul>

                <button class="btn-print" onclick="window.print()">Print Card</button>
            </div>

            <!-- RIGHT COLUMN -->
            <div>
                <div style="background:#fce8eb; padding:20px; border-radius:20px;">
                    🚨 <strong>Sarawak Compliance:</strong>
                    Microchip registration is mandatory to ensure rabies tracking.
                </div>

                <br>

                <div style="background:#fef9c3; padding:20px; border-radius:20px;">
                    ⚠️ <strong>Action Required:</strong>
                    Ownership transfer must be completed.
                    <br><br>
                    <a href="MicrochipTransferServlet?id=${pet.microchipId}"
                       style="display:inline-block; background:#912e3f; color:white;
                              padding:12px 20px; border-radius:12px; text-decoration:none;">
                        Transfer Ownership
                    </a>
                </div>
            </div>

        </div>
    </div>
</main>

</body>
</html>

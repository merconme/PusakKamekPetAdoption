<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emergency: Report Lost Pet - Pusak Kamek</title>
    <link rel="stylesheet" href="style.css">

    <style>
        body {
            background-color: #7a0019;
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            color: white;
        }

        .emergency-wrapper {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
        }

        .emergency-card {
            background: white;
            color: #333;
            border-radius: 40px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            border-top: 10px solid #d32f2f;
        }

        .header-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .header-section h1 {
            color: #d32f2f;
            margin: 10px 0;
        }

        .form-group { margin-bottom: 20px; }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            font-size: 14px;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: 2px solid #eee;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .btn-broadcast {
            background: #d32f2f;
            color: white;
            border: none;
            padding: 18px;
            width: 100%;
            border-radius: 15px;
            font-weight: bold;
            font-size: 18px;
            cursor: pointer;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #666;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="emergency-wrapper">
    <div class="emergency-card">

        <div class="header-section">
            <div style="font-size:50px;">📢</div>
            <h1>Report a Lost Pet</h1>
            <p>
                Reporting will flag the microchip as
                <strong style="color:red;">LOST</strong>
                and alert our volunteer network.
            </p>
        </div>

        <!-- ✅ REAL FORM → SERVLET -->
        <form action="ReportLostPetServlet" method="post">

            <!-- Passed from previous page -->
            <input type="hidden" name="petId" value="${pet.petId}">
            <input type="hidden" name="microchipId" value="${pet.microchipId}">

            <div class="form-group">
                <label>Pet Name</label>
                <input type="text" value="${pet.name}" readonly>
            </div>

            <div class="grid-2">
                <div class="form-group">
                    <label>Owner Name</label>
                    <input type="text" name="ownerName" required>
                </div>

                <div class="form-group">
                    <label>Emergency Contact</label>
                    <input type="tel" name="contact" required>
                </div>
            </div>

            <div class="form-group">
                <label>Last Seen Location</label>
                <input type="text" name="lastLocation" required>
            </div>

            <div class="form-group">
                <label>Date & Time Last Seen</label>
                <input type="datetime-local" name="lastSeen" required>
            </div>

            <div class="form-group">
                <label>Distinctive Features</label>
                <textarea name="features" rows="3"></textarea>
            </div>

            <button type="submit" class="btn-broadcast">
                🚨 Broadcast Emergency Alert
            </button>

        </form>

        <center>
            <a href="pet-checkin.jsp?id=${pet.petId}" class="back-link">
                ← Cancel and Go Back
            </a>
        </center>

    </div>
</div>

</body>
</html>

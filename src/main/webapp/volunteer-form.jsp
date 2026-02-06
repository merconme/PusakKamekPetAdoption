<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pusakkamek.model.User" %>
<%
    String cp = request.getContextPath();
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(cp + "/login.jsp");
        return;
    }

    String msg = (String) session.getAttribute("volunteerSuccess");
    if (msg != null) session.removeAttribute("volunteerSuccess");

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Volunteer Form - Pusak Kamek</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{ --brand:#7a0019; --brand2:#96102b; --bg:#f6f7fb; --line:#e5e7eb; --shadow:0 12px 35px rgba(0,0,0,.10); }
        *{ box-sizing:border-box; }
        body{ margin:0; font-family:Poppins,system-ui; background:var(--bg); }
        .wrap{ max-width:900px; margin:26px auto; padding:0 18px; }
        .card{ background:#fff; border:1px solid var(--line); border-radius:22px; box-shadow:var(--shadow); padding:22px; }
        h1{ margin:0 0 8px; color:var(--brand); }
        p{ margin:0 0 16px; color:#666; font-weight:600; }
        .grid{ display:grid; grid-template-columns:1fr 1fr; gap:12px; }
        .field label{ display:block; font-size:12px; font-weight:900; color:#555; margin:10px 0 6px; }
        .field input, .field select, .field textarea{
            width:100%; padding:12px 12px; border-radius:14px;
            border:1px solid var(--line); outline:none; font-family:inherit;
        }
        .field textarea{ min-height:110px; resize:vertical; }
        .btn{
            margin-top:14px;
            border:none; cursor:pointer;
            padding:12px 18px; border-radius:14px;
            background:linear-gradient(135deg,var(--brand2),var(--brand));
            color:#fff; font-weight:900;
        }
        .toast{ margin-bottom:12px; padding:12px 14px; border-radius:14px; font-weight:900; }
        .ok{ background:#e8f7ee; color:#0b5f16; border:1px solid rgba(11,95,22,.15); }
        .err{ background:#fde7e7; color:#8b0000; border:1px solid rgba(139,0,0,.15); }
        @media(max-width:800px){ .grid{ grid-template-columns:1fr; } }
    </style>
</head>

<body>
<div class="wrap">
    <div class="card">
        <h1>Volunteer Application</h1>
        <p>Fill in the form below. Our team will review and contact you.</p>

        <% if (msg != null) { %>
            <div class="toast ok"><%= msg %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="toast err"><%= error %></div>
        <% } %>

        <form method="post" action="<%= cp %>/volunteer-apply">
            <div class="grid">
                <div class="field">
                    <label>Full Name</label>
                    <input type="text" name="full_name" required value="<%= currentUser.getName() %>">
                </div>

                <div class="field">
                    <label>Phone</label>
                    <input type="text" name="phone" placeholder="01X-XXXXXXX">
                </div>

                <div class="field">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="example@email.com">
                </div>

                <div class="field">
                    <label>Preferred Role</label>
                    <select name="role" required>
                        <option value="">-- Choose --</option>
                        <option>Animal Care</option>
                        <option>Cleaning & Feeding</option>
                        <option>Event Helper</option>
                        <option>Transport / Rescue</option>
                    </select>
                </div>

                <div class="field">
                    <label>Availability</label>
                    <select name="availability" required>
                        <option value="">-- Choose --</option>
                        <option>Weekdays</option>
                        <option>Weekends</option>
                        <option>Evenings</option>
                        <option>Anytime</option>
                    </select>
                </div>

                <div class="field">
                    <label>Do you have experience?</label>
                    <select name="experience" required>
                        <option value="NO">No</option>
                        <option value="YES">Yes</option>
                    </select>

                </div>
            </div>

            <div class="field">
                <label>Address</label>
                <input type="text" name="address" placeholder="Your address (optional)">
            </div>

            <div class="field">
                <label>Why do you want to volunteer?</label>
                <textarea name="reason" placeholder="Tell us briefly..."></textarea>
            </div>

            <button class="btn" type="submit">Submit Application</button>
        </form>
    </div>
</div>
</body>
</html>

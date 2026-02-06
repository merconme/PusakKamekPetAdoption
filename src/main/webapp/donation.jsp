<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.pusakkamek.model.User" %>
<%
    String cp = request.getContextPath();

    // Require login (same style as your system)
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect(cp + "/login.jsp");
        return;
    }

    String success = (String) session.getAttribute("donationSuccess");
    String error = (String) session.getAttribute("donationError");
    if (success != null) session.removeAttribute("donationSuccess");
    if (error != null) session.removeAttribute("donationError");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Pusak Kamek - Donation</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brand2:#96102b;
            --bg:#f6f7fb;
            --card:#ffffff;
            --text:#111827;
            --muted:#6b7280;
            --line:#e5e7eb;
            --shadow:0 12px 35px rgba(0,0,0,.10);
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family:'Poppins',system-ui,-apple-system,Segoe UI,Roboto,Arial,sans-serif;
            background:var(--bg);
            color:var(--text);
        }

        /* ===== NAVBAR (MATCH YOUR 1st NAVBAR) ===== */
        header.navbar{
            position:sticky;
            top:0;
            z-index:1000;
            background:linear-gradient(135deg, var(--brand2), var(--brand));
            box-shadow:0 10px 28px rgba(0,0,0,.18);
            color:#fff;
        }
        .nav-wrap{
            max-width:1200px;
            margin:0 auto;
            padding:12px 18px;
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:16px;
        }
        .brand{
            display:flex; align-items:center; gap:12px;
            min-width:230px;
        }
        .logo{
            width:42px;height:42px;border-radius:16px;
            background:linear-gradient(135deg,#fff,#f4d6dc);
            box-shadow:0 10px 24px rgba(0,0,0,.25);
            position:relative; overflow:hidden;
        }
        .logo:after{
            content:""; position:absolute; width:18px;height:18px;border-radius:50%;
            background:rgba(255,255,255,.55); top:-6px; right:-6px;
        }
        .brand-txt b{ display:block; font-size:14px; letter-spacing:.5px; color:#fff; }
        .brand-txt small{ display:block; font-size:11px; font-weight:700; margin-top:3px; color:rgba(255,255,255,.85); }

        nav.links{ display:flex; gap:10px; flex:1; justify-content:center; }
        nav.links a{
            padding:10px 14px;
            font-size:12px; font-weight:900;
            color:#fff; text-decoration:none;
            border-radius:999px; transition:.15s;
        }
        nav.links a:hover{ background:rgba(255,255,255,.18); }
        nav.links a.active{ background:rgba(255,255,255,.30); }

        .right{ display:flex; gap:10px; align-items:center; justify-content:flex-end; min-width:230px; }
        .profile{ position:relative; }
        .profile-btn{
            display:flex; align-items:center; gap:10px;
            border:1px solid rgba(255,255,255,.45);
            background:rgba(255,255,255,.10);
            padding:7px 10px; border-radius:999px;
            cursor:pointer; color:#fff;
        }
        .avatar{
            width:34px;height:34px;border-radius:50%;
            display:flex;align-items:center;justify-content:center;
            background:rgba(255,255,255,.25);
        }
        .name{
            font-weight:900; font-size:12px;
            max-width:140px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
            color:#fff;
        }
        .menu{
            position:absolute; right:0; top:52px;
            width:210px; background:#fff;
            border:1px solid var(--line);
            border-radius:16px; box-shadow:0 12px 30px rgba(0,0,0,.25);
            overflow:hidden; display:none;
        }
        .menu a{
            display:block; padding:12px 14px;
            text-decoration:none; font-weight:900; font-size:13px;
            color:#444;
        }
        .menu a:hover{ background:#f5f5f5; }
        .menu a.logout{ color:#b00020; }
        @media (max-width: 1000px){ nav.links{ display:none; } }

        /* ===== TOAST ===== */
        .toast{
            max-width:1200px;
            margin:14px auto 0;
            padding:14px 16px;
            border-radius:16px;
            font-weight:900;
            font-size:13px;
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:12px;
            box-shadow:0 12px 28px rgba(0,0,0,.10);
            border:1px solid transparent;
            animation:toastDrop .35s ease;
        }
        .toast button{
            border:none;background:transparent;cursor:pointer;
            font-weight:900;font-size:14px;opacity:.8;
        }
        .toast button:hover{ opacity:1; }
        .toast-success{ background:linear-gradient(135deg,#e8f7ee,#f4fbf7); color:#0b5f16; border-color:rgba(11,95,22,.15); }
        .toast-error{ background:linear-gradient(135deg,#fde7e7,#fff3f3); color:#8b0000; border-color:rgba(139,0,0,.15); }
        @keyframes toastDrop{ from{opacity:0;transform:translateY(-10px);} to{opacity:1;transform:translateY(0);} }

        /* ===== PAGE ===== */
        .container{
            max-width:1200px;
            margin:0 auto;
            padding:24px 18px 70px;
        }
        .head{
            text-align:center;
            margin:10px 0 18px;
        }
        .head h1{ margin:0 0 6px; font-size:30px; }
        .head p{ margin:0; color:#666; font-weight:700; font-size:13px; }

        .grid{
            display:grid;
            grid-template-columns: 1.05fr .95fr;
            gap:16px;
        }
        .card{
            background:#fff;
            border:1px solid rgba(229,231,235,.85);
            border-radius:22px;
            box-shadow:0 10px 25px rgba(0,0,0,.06);
            padding:18px;
        }
        .card h3{
            margin:0 0 10px;
            color:var(--brand);
            font-size:16px;
            font-weight:900;
        }
        label{ display:block; font-weight:900; font-size:12px; color:#333; margin:12px 0 6px; }
        input, select, textarea{
            width:100%;
            padding:12px 12px;
            border-radius:14px;
            border:1px solid #e5e7eb;
            outline:none;
            font-family:inherit;
            font-size:13px;
        }
        textarea{ min-height:90px; resize:vertical; }

        .amount-row{
            display:flex; gap:10px; flex-wrap:wrap; margin-top:8px;
        }
        .chip{
            border:1px solid rgba(122,0,25,.25);
            color:var(--brand);
            background:#fff;
            padding:10px 14px;
            border-radius:999px;
            font-weight:900;
            font-size:12px;
            cursor:pointer;
            transition:.15s;
        }
        .chip:hover{ background:#fff0f2; }
        .chip.active{
            background:linear-gradient(135deg,var(--brand2),var(--brand));
            color:#fff;
            border-color:transparent;
        }

        .method-row{
            display:flex; gap:10px; flex-wrap:wrap; margin-top:10px;
        }
        .radio{
            flex:1;
            min-width:180px;
            border:1px solid #e5e7eb;
            border-radius:16px;
            padding:12px;
            display:flex;
            gap:10px;
            align-items:flex-start;
            cursor:pointer;
            background:#fff;
        }
        .radio b{ display:block; font-size:12px; }
        .radio small{ display:block; color:#666; font-weight:700; font-size:11px; margin-top:3px; }

        .btn{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            gap:8px;
            padding:12px 18px;
            border-radius:999px;
            text-decoration:none;
            font-weight:900;
            font-size:13px;
            transition:.2s;
            border:1px solid transparent;
            cursor:pointer;
        }
        .btn.primary{
            background:linear-gradient(135deg,var(--brand2),var(--brand));
            color:#fff;
            box-shadow:0 12px 26px rgba(122,0,25,.18);
            width:100%;
            margin-top:14px;
        }
        .btn.primary:hover{ transform:translateY(-1px); }

        .paybox{
            display:flex;
            flex-direction:column;
            gap:12px;
        }
        .qr{
            width:100%;
            border-radius:18px;
            border:1px solid #e5e7eb;
            overflow:hidden;
            background:#fafafa;
            padding:12px;
            text-align:center;
        }
        .qr img{
            max-width:280px;
            width:100%;
            height:auto;
            border-radius:14px;
            border:1px solid #eee;
            background:#fff;
        }
        .hint{
            color:#666;
            font-size:12px;
            font-weight:700;
            line-height:1.6;
        }

        @media(max-width: 950px){
            .grid{ grid-template-columns:1fr; }
        }
    </style>
</head>

<body>

<header class="navbar">
    <div class="nav-wrap">
        <div class="brand">
            <div class="logo"></div>
            <div class="brand-txt">
                <b>PUSAK KAMEK</b>
                <small>Rescue · Rehome · Rebuild</small>
            </div>
        </div>

        <nav class="links">
            <a href="<%= cp %>/index.jsp">Home</a>
            <a href="<%= cp %>/stories">Stories</a>
            <a href="<%= cp %>/petbrowse.jsp">Pet</a>
            <a href="<%= cp %>/adopt.jsp">Adopt</a>
            <a href="<%= cp %>/volunteer.jsp">Volunteer</a>
            <a class="active" href="<%= cp %>/donation.jsp">Donation</a>
            <a href="<%= cp %>/my-adoptions">My Adoptions</a>
        </nav>

        <div class="right">
            <div class="profile">
                <div class="profile-btn" onclick="toggleProfileMenu()">
                    <div class="avatar">👤</div>
                    <div class="name">Hello, <%= currentUser.getName() %></div>
                </div>
                <div class="menu" id="profileMenu">
                    <a href="<%= cp %>/profile.jsp">Update Profile</a>
                    <a class="logout" href="<%= cp %>/LogoutServlet">Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<% if (success != null) { %>
<div class="toast toast-success" id="toastMsg">
    <span><%= success %></span>
    <button type="button" onclick="closeToast()">✕</button>
</div>
<% } %>

<% if (error != null) { %>
<div class="toast toast-error" id="toastMsg">
    <span><%= error %></span>
    <button type="button" onclick="closeToast()">✕</button>
</div>
<% } %>

<main class="container">
    <div class="head">
        <h1>Make a Donation</h1>
        <p>Your support helps us rescue, treat, and rehome more animals.</p>
    </div>

    <div class="grid">
        <!-- LEFT: FORM -->
        <div class="card">
            <h3>Donation Details</h3>

            <form method="post" action="<%= cp %>/donate" id="donationForm">
                <label>Your Name *</label>
                <input type="text" name="donor_name" value="<%= currentUser.getName() %>" required>

                <label>Email</label>
                <input type="email" name="donor_email" placeholder="example@gmail.com">

                <label>Phone</label>
                <input type="text" name="donor_phone" placeholder="01x-xxxxxxx">

                <label>Choose Amount</label>
                <div class="amount-row">
                    <button type="button" class="chip" data-amt="1">RM1</button>
                    <button type="button" class="chip" data-amt="5">RM5</button>
                    <button type="button" class="chip" data-amt="10">RM10</button>
                    <button type="button" class="chip" data-amt="20">RM20</button>
                    <button type="button" class="chip" data-amt="50">RM50</button>
                </div>

                <label>Custom Amount (RM) *</label>
                <input type="number" step="0.01" min="0.01" name="amount" id="amount" placeholder="e.g. 5 or 10" required>

                <label>Payment Method</label>
                <div class="method-row">
                    <div class="radio" onclick="setMethod('QR')">
                        <input type="radio" name="method" value="QR" id="mQR" checked>
                        <div>
                            <b>QR Payment</b>
                            <small>Scan QR code and pay</small>
                        </div>
                    </div>

                    <div class="radio" onclick="setMethod('FPX')">
                        <input type="radio" name="method" value="FPX" id="mFPX">
                        <div>
                            <b>FPX (Dummy)</b>
                            <small>Select bank (demo only)</small>
                        </div>
                    </div>
                </div>

                <div id="fpxBox" style="display:none;">
                    <label>Bank (FPX)</label>
                    <select name="bank">
                        <option value="">-- Select Bank --</option>
                        <option>Maybank</option>
                        <option>CIMB Bank</option>
                        <option>Bank Islam</option>
                        <option>RHB Bank</option>
                        <option>Public Bank</option>
                        <option>Hong Leong Bank</option>
                    </select>
                </div>

                <label>Note (optional)</label>
                <textarea name="note" placeholder="Any message for us?"></textarea>

                <button class="btn primary" type="submit">Submit Donation</button>
            </form>
        </div>

        <!-- RIGHT: PAYMENT INFO -->
        <div class="card paybox">
            <h3>Payment Instructions</h3>

            <div class="qr">
                <div class="hint" style="margin-bottom:10px;">
                    ✅ QR Payment: Scan using your banking app / eWallet.
                </div>
                <!-- Put your QR here: Web Pages/images/qr.png -->
                <img src="<%= cp %>/images/qr.png" alt="Donation QR Code">
                <div class="hint" style="margin-top:10px;">
                    After paying, your donation will be reviewed by admin (status: PENDING).
                </div>
            </div>

            <div class="card" style="box-shadow:none;border:1px dashed #e5e7eb;">
                <h3 style="margin:0 0 8px;">FPX Dummy</h3>
                <div class="hint">
                    This is only a demo UI. You can later integrate real FPX gateway.
                    For now, selecting FPX will just save the chosen bank into the database.
                </div>
            </div>
        </div>
    </div>
</main>

<script>
function toggleProfileMenu(){
    const menu = document.getElementById("profileMenu");
    if(!menu) return;
    menu.style.display = (menu.style.display === "block") ? "none" : "block";
}
window.onclick = function(e){
    if(!e.target.closest(".profile")){
        const menu = document.getElementById("profileMenu");
        if(menu) menu.style.display = "none";
    }
}

function closeToast(){
    const t = document.getElementById("toastMsg");
    if(t) t.style.display = "none";
}
setTimeout(closeToast, 3000);

// amount chips
const chips = document.querySelectorAll(".chip");
const amountInput = document.getElementById("amount");
chips.forEach(ch => {
    ch.addEventListener("click", () => {
        chips.forEach(x => x.classList.remove("active"));
        ch.classList.add("active");
        amountInput.value = ch.dataset.amt;
        amountInput.focus();
    });
});

// method toggle
function setMethod(m){
    document.getElementById("mQR").checked = (m === "QR");
    document.getElementById("mFPX").checked = (m === "FPX");
    document.getElementById("fpxBox").style.display = (m === "FPX") ? "block" : "none";
}
document.getElementById("mQR").addEventListener("change", ()=> setMethod("QR"));
document.getElementById("mFPX").addEventListener("change", ()=> setMethod("FPX"));
</script>

</body>
</html>

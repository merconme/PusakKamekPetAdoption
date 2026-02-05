<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String cp = request.getContextPath();
    String error = (String) request.getAttribute("error");
%>
<%
  String logout = request.getParameter("logout");
  if (logout != null) {
%>
  <div class="error-msg" style="background:#e8f7ee;border-color:rgba(11,95,22,.15);color:#0b5f16;">
    ✅ You have been logged out.
  </div>
<% } %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pusak Kamek | Admin Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand:#7a0019;
            --brand2:#96102b;
            --ink:#1f2937;
            --muted:#6b7280;
            --shadow:0 18px 45px rgba(0,0,0,.18);
        }

        *{ box-sizing:border-box; }

        body{
            margin:0;
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            font-family:'Poppins', system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            background: radial-gradient(1200px 600px at 20% 10%, rgba(255,255,255,.12), transparent 55%),
                        radial-gradient(900px 500px at 90% 30%, rgba(255,255,255,.10), transparent 55%),
                        linear-gradient(135deg, var(--brand), var(--brand2));
            padding:24px;
        }

        /* soft glass blobs */
        .blob{
            position:fixed;
            width:420px;
            height:420px;
            border-radius:50%;
            filter: blur(40px);
            opacity:.25;
            pointer-events:none;
        }
        .blob.one{ background:#ffffff; top:-140px; left:-120px; }
        .blob.two{ background:#ffd6de; bottom:-160px; right:-120px; }

        .shell{
            width:min(980px, 100%);
            display:grid;
            grid-template-columns: 1.05fr .95fr;
            gap:22px;
            align-items:stretch;
        }

        @media (max-width: 860px){
            .shell{ grid-template-columns: 1fr; }
        }

        .panel{
            border-radius:26px;
            overflow:hidden;
            box-shadow: var(--shadow);
        }

        /* Left branding panel */
        .brand-panel{
            background: linear-gradient(135deg, rgba(255,255,255,.14), rgba(255,255,255,.08));
            border: 1px solid rgba(255,255,255,.20);
            backdrop-filter: blur(10px);
            padding:30px;
            color:#fff;
            position:relative;
        }

        .logo{
            display:flex;
            gap:12px;
            align-items:center;
            margin-bottom:18px;
        }
        .logo-badge{
            width:44px;
            height:44px;
            border-radius:14px;
            background: rgba(255,255,255,.22);
            border:1px solid rgba(255,255,255,.25);
            display:flex;
            align-items:center;
            justify-content:center;
            font-weight:900;
            letter-spacing:.5px;
        }
        .logo-text b{
            display:block;
            font-weight:900;
            letter-spacing:.4px;
            font-size:16px;
            line-height:1.1;
        }
        .logo-text small{
            display:block;
            opacity:.9;
            font-weight:600;
            font-size:11px;
            margin-top:2px;
        }

        .hero-title{
            margin:14px 0 10px;
            font-size:34px;
            line-height:1.08;
            font-weight:900;
            letter-spacing:.2px;
        }
        .hero-sub{
            margin:0;
            opacity:.92;
            font-size:13px;
            max-width:48ch;
        }

        .tips{
            margin-top:22px;
            padding:14px 14px;
            border-radius:18px;
            background: rgba(0,0,0,.20);
            border:1px solid rgba(255,255,255,.18);
            display:grid;
            gap:10px;
        }
        .tip{
            display:flex;
            gap:10px;
            align-items:flex-start;
            font-size:12px;
            opacity:.95;
        }
        .dot{
            width:10px;
            height:10px;
            border-radius:50%;
            background: rgba(255,255,255,.85);
            margin-top:4px;
            flex:0 0 10px;
        }

        /* Right login panel */
        .login-panel{
            background:#fff;
            padding:28px 28px 24px;
        }

        .login-head{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:10px;
            margin-bottom:14px;
        }

        .login-head h1{
            margin:0;
            color:var(--brand);
            font-size:22px;
            font-weight:900;
            letter-spacing:.2px;
        }

        .pill{
            font-size:11px;
            font-weight:900;
            color: var(--brand);
            background:#fdf0f1;
            border:1px solid rgba(122,0,25,.15);
            padding:8px 12px;
            border-radius:999px;
        }

        .login-sub{
            margin:0 0 18px;
            color: var(--muted);
            font-size:13px;
            line-height:1.4;
        }

        .field{
            margin-bottom:12px;
        }
        label{
            display:block;
            font-size:12px;
            font-weight:900;
            color:#374151;
            text-transform:uppercase;
            letter-spacing:.5px;
            margin-bottom:6px;
        }

        .input-wrap{
            position:relative;
        }

        input{
            width:100%;
            padding:12px 14px;
            border-radius:14px;
            border:1px solid #e5e7eb;
            font-size:14px;
            outline:none;
            transition:.2s;
            background:#fff;
            color:var(--ink);
        }
        input:focus{
            border-color: rgba(122,0,25,.35);
            box-shadow: 0 0 0 4px rgba(122,0,25,.10);
        }

        .toggle-pass{
            position:absolute;
            right:10px;
            top:50%;
            transform:translateY(-50%);
            border:none;
            background:#f3f4f6;
            border:1px solid #e5e7eb;
            border-radius:12px;
            padding:8px 10px;
            cursor:pointer;
            font-weight:900;
            font-size:12px;
            color:#374151;
            transition:.2s;
        }
        .toggle-pass:hover{ background:#eceef1; }

        .btn{
            width:100%;
            margin-top:8px;
            padding:12px 14px;
            border:none;
            border-radius:14px;
            background: linear-gradient(135deg, var(--brand), var(--brand2));
            color:#fff;
            font-weight:900;
            font-size:14px;
            cursor:pointer;
            transition:.2s;
            box-shadow: 0 12px 28px rgba(122,0,25,.20);
        }
        .btn:hover{ transform: translateY(-1px); }
        .btn:active{ transform: translateY(0px); }

        .error-msg{
            margin-top:12px;
            padding:10px 12px;
            border-radius:14px;
            background:#fde7e7;
            border:1px solid rgba(139,0,0,.15);
            color:#8b0000;
            font-weight:800;
            font-size:13px;
        }

        .footer{
            margin-top:16px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:10px;
            color:#9ca3af;
            font-size:11px;
            font-weight:700;
        }
        .back-link{
            text-decoration:none;
            color: var(--brand);
            font-weight:900;
        }
        .back-link:hover{ text-decoration:underline; }
    </style>
</head>

<body>
<div class="blob one"></div>
<div class="blob two"></div>

<div class="shell">
    <!-- Left: Brand -->
    <div class="panel brand-panel">
        <div class="logo">
            <div class="logo-badge">PK</div>
            <div class="logo-text">
                <b>PUSAK KAMEK</b>
                <small>ADMIN PANEL</small>
            </div>
        </div>

        <div class="hero-title">Welcome back.</div>
        <p class="hero-sub">
            Sign in to manage pets, stories, and adoption applications.
            Authorized personnel only.
        </p>

        <div class="tips">
            <div class="tip"><span class="dot"></span><span>Keep your admin password private.</span></div>
            <div class="tip"><span class="dot"></span><span>Approve / reject adoption applications from <b>Adoptions</b> page.</span></div>
            <div class="tip"><span class="dot"></span><span>If you can’t login, ask the system owner to reset your admin account.</span></div>
        </div>
    </div>

    <!-- Right: Form -->
    <div class="panel login-panel">
        <div class="login-head">
            <h1>Admin Login</h1>
            <div class="pill">Secure Access</div>
        </div>
        <p class="login-sub">Enter your credentials to continue.</p>

        <form action="<%= cp %>/adminLogin" method="post" autocomplete="on">
            <div class="field">
                <label>Username</label>
                <div class="input-wrap">
                    <input type="text" name="username" placeholder="Admin username" required>
                </div>
            </div>

            <div class="field">
                <label>Password</label>
                <div class="input-wrap">
                    <input id="pass" type="password" name="password" placeholder="••••••••" required>
                    <button class="toggle-pass" type="button" onclick="togglePass()">Show</button>
                </div>
            </div>

            <button type="submit" class="btn">Login</button>
        </form>

        <% if (error != null) { %>
            <div class="error-msg">❌ <%= error %></div>
        <% } %>

        <div class="footer">
            <span>Pusak Kamek • Admin Panel</span>
            <a class="back-link" href="<%= cp %>/index.jsp">Back to site</a>
        </div>
    </div>
</div>

<script>
    function togglePass(){
        const pass = document.getElementById("pass");
        const btn = document.querySelector(".toggle-pass");
        if(pass.type === "password"){
            pass.type = "text";
            btn.textContent = "Hide";
        }else{
            pass.type = "password";
            btn.textContent = "Show";
        }
    }
</script>

</body>
</html>

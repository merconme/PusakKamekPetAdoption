<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pusak Kamek - Login</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root{
            --brand-maroon:#7a0019;
            --brand-maroon-2:#96102b;
            --bg:#f6f7fb;
            --text:#111827;
            --muted:#6b7280;
            --card:#ffffff;
            --line:#e5e7eb;
            --shadow: 0 20px 60px rgba(0,0,0,.12);
            --ring: 0 0 0 4px rgba(122,0,25,.12);
        }

        *{ box-sizing:border-box; }
        body.login-body{
            margin:0;
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            font-family:'Poppins', system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
            background:
                radial-gradient(900px 500px at 15% 15%, rgba(122,0,25,.10), transparent 60%),
                radial-gradient(800px 420px at 85% 20%, rgba(150,16,43,.10), transparent 55%),
                linear-gradient(180deg, #fafafa, var(--bg));
            color:var(--text);
            padding:28px;
        }

        .wrap{
            width:min(980px, 100%);
            display:grid;
            grid-template-columns: 1.15fr 0.85fr;
            gap:22px;
            align-items:stretch;
        }

        /* Left brand panel (like real product login) */
        .brand-panel{
            border-radius:26px;
            padding:34px;
            color:#fff;
            position:relative;
            overflow:hidden;
            background:
                radial-gradient(700px 380px at 20% 20%, rgba(255,255,255,.18), transparent 60%),
                radial-gradient(650px 360px at 85% 30%, rgba(255,255,255,.16), transparent 55%),
                linear-gradient(135deg, var(--brand-maroon), var(--brand-maroon-2));
            box-shadow: var(--shadow);
            min-height: 520px;
        }

        .brand-badge{
            display:inline-flex;
            align-items:center;
            gap:10px;
            padding:10px 14px;
            border-radius:999px;
            background: rgba(255,255,255,.14);
            border: 1px solid rgba(255,255,255,.22);
            font-weight:800;
            letter-spacing:.4px;
        }
        .brand-dot{
            width:10px;height:10px;border-radius:50%;
            background:#fff;
            box-shadow: 0 0 0 6px rgba(255,255,255,.10);
        }

        .brand-title{
            margin:22px 0 10px;
            font-size:38px;
            line-height:1.05;
            font-weight:900;
        }
        .brand-sub{
            margin:0;
            color: rgba(255,255,255,.86);
            font-weight:600;
            max-width: 36ch;
        }

        .feature-list{
            margin:26px 0 0;
            padding:0;
            list-style:none;
            display:grid;
            gap:14px;
        }
        .feature{
            display:flex;
            gap:12px;
            align-items:flex-start;
            background: rgba(255,255,255,.10);
            border: 1px solid rgba(255,255,255,.18);
            border-radius:18px;
            padding:14px 14px;
        }
        .icon{
            width:38px;height:38px;
            border-radius:14px;
            background: rgba(255,255,255,.18);
            display:flex;
            align-items:center;
            justify-content:center;
            flex: 0 0 38px;
            font-weight:900;
        }
        .feature b{ display:block; font-weight:900; }
        .feature span{ color: rgba(255,255,255,.86); font-size:13px; line-height:1.35; }

        .wave{
            position:absolute;
            inset:auto -120px -180px -120px;
            height:420px;
            background: radial-gradient(circle at 30% 30%, rgba(255,255,255,.18), transparent 55%);
            filter: blur(0px);
            transform: rotate(-8deg);
            opacity:.9;
        }

        /* Right login card (Google-ish clean form) */
        .login-card{
            background:var(--card);
            border-radius:26px;
            box-shadow: var(--shadow);
            border: 1px solid rgba(229,231,235,.9);
            padding:30px;
            display:flex;
            flex-direction:column;
            justify-content:center;
            min-height: 520px;
        }

        .card-top{
            display:flex;
            align-items:center;
            justify-content:space-between;
            margin-bottom:18px;
        }
        .mini-logo{
            display:flex;
            align-items:center;
            gap:10px;
            font-weight:900;
            color:var(--brand-maroon);
        }
        .mini-logo .mark{
            width:36px;height:36px;border-radius:14px;
            background: linear-gradient(135deg, var(--brand-maroon), var(--brand-maroon-2));
            box-shadow: 0 10px 20px rgba(122,0,25,.18);
            position:relative;
            overflow:hidden;
        }
        .mini-logo .mark:after{
            content:"";
            position:absolute;
            width:18px;height:18px;
            border-radius:50%;
            background: rgba(255,255,255,.35);
            top:-6px; right:-6px;
        }

        .help-link{
            font-size:12px;
            font-weight:800;
            color: var(--muted);
            text-decoration:none;
            padding:8px 10px;
            border-radius:999px;
            border: 1px solid var(--line);
            transition:.2s;
        }
        .help-link:hover{ background:#fafafa; color:var(--brand-maroon); }

        .login-card h1{
            margin:0 0 8px;
            font-size:26px;
            font-weight:900;
            color:var(--text);
        }
        .login-card p{
            margin:0 0 18px;
            color:var(--muted);
            font-weight:600;
            font-size:13px;
            line-height:1.4;
        }

        form{
            display:flex;
            flex-direction:column;
            gap:14px;
        }

        .field{
            position:relative;
        }

        .field input{
            width:100%;
            padding:14px 14px;
            border-radius:14px;
            border:1px solid var(--line);
            font-size:14px;
            font-family:inherit;
            outline:none;
            transition:.15s;
            background:#fff;
        }
        .field input:focus{
            border-color: rgba(122,0,25,.45);
            box-shadow: var(--ring);
        }

        .field label{
            position:absolute;
            left:12px;
            top:-9px;
            background:#fff;
            padding:0 8px;
            font-size:11px;
            font-weight:900;
            color:#777;
            letter-spacing:.35px;
            text-transform:uppercase;
        }

        .row{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:12px;
            margin-top:2px;
        }

        .small-link{
            font-size:12px;
            font-weight:900;
            color:var(--brand-maroon);
            text-decoration:none;
        }
        .small-link:hover{ text-decoration:underline; }

        .btn{
            padding:14px;
            border-radius:14px;
            border:none;
            background: linear-gradient(135deg, var(--brand-maroon), var(--brand-maroon-2));
            color:#fff;
            font-weight:900;
            cursor:pointer;
            transition:.2s;
            box-shadow: 0 12px 30px rgba(122,0,25,.22);
        }
        .btn:hover{ transform: translateY(-1px); }
        .btn:active{ transform: translateY(0px); }

        .error-message{
            margin-top:10px;
            padding:10px 12px;
            border-radius:14px;
            background:#fde7e7;
            border:1px solid rgba(139,0,0,.15);
            color:#8b0000;
            font-weight:900;
            font-size:12px;
            text-align:center;
        }

        .foot{
            margin-top:18px;
            color:#9ca3af;
            font-size:11px;
            font-weight:700;
            text-align:center;
            line-height:1.4;
        }

        @media (max-width: 900px){
            .wrap{ grid-template-columns: 1fr; }
            .brand-panel{ min-height: unset; }
            .login-card{ min-height: unset; }
        }
    </style>
</head>

<body class="login-body">

<div class="wrap">

    <!-- Brand side -->
    <section class="brand-panel">
        <div class="brand-badge">
            <span class="brand-dot"></span>
            PUSAK KAMEK • ADMIN / STAFF
        </div>

        <h2 class="brand-title">Welcome back.</h2>
        <p class="brand-sub">
            Log in to manage pets, track adoptions, and update listings — fast and simple.
        </p>

        <ul class="feature-list">
            <li class="feature">
                <div class="icon">🐾</div>
                <div>
                    <b>Pet Listings</b>
                    <span>Add, edit, and keep all resident info updated.</span>
                </div>
            </li>
            <li class="feature">
                <div class="icon">📌</div>
                <div>
                    <b>Adoption Requests</b>
                    <span>Review applications and approve decisions easily.</span>
                </div>
            </li>
            <li class="feature">
                <div class="icon">🛡️</div>
                <div>
                    <b>Secure Access</b>
                    <span>Your data stays protected with session-based login.</span>
                </div>
            </li>
        </ul>

        <div class="wave"></div>
    </section>

    <!-- Login card -->
    <section class="login-card">
        <div class="card-top">
            <div class="mini-logo">
                <span class="mark"></span>
                <span>Pusak Kamek</span>
            </div>
            <a class="help-link" href="#" onclick="return false;">Need help?</a>
        </div>

        <h1>Sign in</h1>
        <p>Use your admin/staff account to continue to the dashboard.</p>

        <form action="<%= request.getContextPath() %>/LoginServlet" method="post" autocomplete="on">
            <div class="field">
                <label>Email or Phone</label>
                <input type="text" name="username" placeholder="example@email.com / 01X-XXXXXXX" required>
            </div>

            <div class="field">
                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required>
            </div>

            <div class="row">
                <a class="small-link" href="#" onclick="return false;">Forgot password?</a>
                <a class="small-link" href="<%= request.getContextPath() %>/admin-login.jsp" style="opacity:.0; pointer-events:none;">.</a>
            </div>

            <button class="btn" type="submit">Sign in</button>
        </form>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error-message"><%= error %></div>
        <%
            }
        %>

        <div class="foot">
            © <%= java.time.Year.now() %> Pusak Kamek • Admin Panel
        </div>
    </section>

</div>

</body>
</html>

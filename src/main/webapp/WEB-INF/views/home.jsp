<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort | Welcome</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>

<!-- ================= HEADER ================= -->
<header class="modern-header">
    <div class="logo-modern">
        Ocean View Resort
    </div>

    <nav class="nav-modern">
        <a href="<%=request.getContextPath()%>/help">Help</a>
        <a class="btn-nav"
           href="<%=request.getContextPath()%>/login?role=RECEPTIONIST">
            Login
        </a>
    </nav>
</header>

<section class="modern-hero">

    <div class="hero-overlay"></div>

    <div class="hero-center">

        <h1>
            Experience Coastal <br>
            <span>Luxury Living</span>
        </h1>

        <p>
            Sustainable hospitality · Seamless reservations · Smart management
        </p>

        <!-- ROLE CARDS -->
        <div class="roles-center">

            <!-- Receptionist -->
            <div class="role-card-modern"
                 style="background-image:url('<%=request.getContextPath()%>/assets/img/reception.jpg')">

                <div class="role-overlay-modern">
                    <h3>Receptionist</h3>
                    <p>Manage reservations, check-ins & guest services.</p>

                    <a href="<%=request.getContextPath()%>/login?role=RECEPTIONIST"
                       class="btn-role">
                        Access Panel →
                    </a>
                </div>
            </div>

            <!-- Admin -->
            <div class="role-card-modern"
                 style="background-image:url('<%=request.getContextPath()%>/assets/img/manager.jpg')">

                <div class="role-overlay-modern">
                    <h3>Admin / Manager</h3>
                    <p>Monitor revenue, manage accounts & operations.</p>

                    <a href="<%=request.getContextPath()%>/login?role=ADMIN"
                       class="btn-role-outline">
                        Management →
                    </a>
                </div>
            </div>

        </div>

    </div>

</section>


<!-- ================= FOOTER ================= -->
<footer class="footer">
    © 2026 Ocean View Resort · Galle · Sri Lanka<br>
    🌊 Inspired by the Ocean · Committed to Excellence
</footer>

</body>
</html>
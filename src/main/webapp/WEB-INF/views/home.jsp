<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort | Welcome</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body class="eco-bg">

<div class="page">

    <!-- ===== HEADER ===== -->
    <header class="header eco-glass fade-in">
        <div class="logo">
            🌿 Ocean View Resort
            <span class="tagline">Eco-Friendly Reservation System</span>
        </div>
        <nav>
            <a href="<%=request.getContextPath()%>/help">Help</a>
        </nav>
    </header>

    <!-- ===== HERO SECTION ===== -->
    <section class="hero eco-card slide-up">

        <div class="hero-text">
            <h1>Welcome to Ocean View Resort</h1>

            <p class="subtitle">
                Sustainable hospitality · Seamless reservations
            </p>

            <div class="divider"></div>

            <p class="description">
                This system helps our staff manage guests,
                reservations, and billing efficiently while
                supporting eco-friendly tourism.
            </p>
        </div>

      <div class="hero-image album">
          <img class="album-img back"
               src="assets/img/eco-resort-2.jpg"
               alt="Resort View Side">

          <img class="album-img front"
               src="assets/img/eco-resort.jpg"
               alt="Eco Resort Main">
      </div>

    </section>

    <!-- ===== ROLE SELECTION ===== -->
    <section class="roles">

        <!-- Receptionist -->
  <div class="role-card role-bg"
       style="background-image:url('<%=request.getContextPath()%>/assets/img/reception.jpg')">

      <div class="role-overlay">
          <h2>Receptionist</h2>
          <p>
              Register guests, create and manage reservations,
              handle modifications, cancellations, and billing.
          </p>

          <a class="btn-primary"
             href="<%=request.getContextPath()%>/login?role=RECEPTIONIST">
              Go to Reception →
          </a>
      </div>
  </div>

        <!-- Admin -->
       <div class="role-card role-bg"
            style="background-image:url('<%=request.getContextPath()%>/assets/img/manager.jpg')">

           <div class="role-overlay">
               <h2>Admin / Manager</h2>
               <p>
                   View revenue reports, manage receptionist accounts,
                   and oversee system operations.
               </p>

               <a class="btn-outline"
                  href="<%=request.getContextPath()%>/login?role=ADMIN">
                   Go to Management →
               </a>
           </div>
       </div>

    </section>

    <!-- ===== FOOTER ===== -->
    <footer class="footer">
        © 2026 Ocean View Resort · Galle · Sri Lanka<br>
        🌱 Committed to sustainable tourism
    </footer>

</div>

</body>
</html>
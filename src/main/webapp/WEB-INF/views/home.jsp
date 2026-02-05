<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Ocean View Resort | Home</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">
  <div class="topbar">
    <div class="brand">
      <span>🌊 Ocean View Resort</span>
      <span class="badge">Reservation System</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/help">Help</a>
    </div>
  </div>

  <div style="height:16px"></div>

  <div class="grid grid-2">
    <div class="card">
      <h2>Receptionist</h2>
      <p>Manage reservations, register guests, and generate bills.</p>
      <a class="btn" href="<%=request.getContextPath()%>/login?role=RECEPTIONIST">Receptionist Login →</a>
    </div>

    <div class="card">
      <h2>Admin / Manager</h2>
      <p>View revenue, generate reports, and manage receptionist accounts.</p>
      <a class="btn" href="<%=request.getContextPath()%>/login?role=ADMIN">Admin Login →</a>
    </div>
  </div>

  <div style="height:16px"></div>

  <div class="card">
    <h3>Why this system?</h3>
    <p>Prevents booking conflicts, stores guest records securely, calculates bills automatically, and restricts access using role-based login.</p>
  </div>
</div>
</body>
</html>
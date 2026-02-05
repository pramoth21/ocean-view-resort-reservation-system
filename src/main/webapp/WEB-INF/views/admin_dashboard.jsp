<%@ page contentType="text/html;charset=UTF-8" %>
<%
  Object revenueObj = request.getAttribute("revenue");
  double revenue = (revenueObj instanceof Double) ? (Double)revenueObj : 0.0;
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin | Dashboard</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">
  <div class="topbar">
    <div class="brand"><span>🛡️ Admin Panel</span><span class="badge">Manager</span></div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/admin/users">Manage Receptionists</a>
      <a href="<%=request.getContextPath()%>/admin/reports">Reports</a>
      <a href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
  </div>

  <div style="height:16px"></div>

  <div class="grid grid-2">
    <div class="card">
      <h2>Total Revenue</h2>
      <p>Calculated from stored bills.</p>
      <div class="msg ok" style="font-size:22px;">
        LKR <b><%=String.format("%,.2f", revenue)%></b>
      </div>
      <div style="height:8px"></div>
      <button class="btn btn-ghost" onclick="loadRevenue()">Refresh (API)</button>
      <small id="revMsg"></small>
    </div>

    <div class="card">
      <h2>Admin Tools</h2>
      <p>Create receptionist accounts and control system access securely.</p>
      <div style="display:flex; gap:10px; flex-wrap:wrap;">
        <a class="btn" href="<%=request.getContextPath()%>/admin/users">Receptionist Accounts →</a>
        <a class="btn btn-ghost" href="<%=request.getContextPath()%>/help">Help</a>
      </div>
      <small>Admins do NOT create reservations (role separation).</small>
    </div>
  </div>
</div>

<script>
async function loadRevenue(){
  const msg = document.getElementById("revMsg");
  msg.textContent = "Loading...";
  const res = await fetch("<%=request.getContextPath()%>/api/revenue");
  const data = await res.json();
  msg.textContent = data.ok ? ("API Revenue: " + data.revenue) : "Failed to load revenue.";
}
</script>
</body>
</html>
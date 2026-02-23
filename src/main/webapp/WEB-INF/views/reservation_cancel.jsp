<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Cancel Reservation | Ocean View Resort</title>

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/cancel-reservation.css">

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">

      <div class="logo">🌊 Ocean View</div>

      <ul class="menu">

          <li>
              <a href="<%=request.getContextPath()%>/receptionist">
                  Dashboard
              </a>
          </li>

          <li>
              <a href="<%=request.getContextPath()%>/receptionist/reservations/add">
                  Add Reservation
              </a>
          </li>

          <li class="active">
              Cancel Reservation
          </li>

          <li>
              <a href="<%=request.getContextPath()%>/receptionist/bill">
                  Generate Bill
              </a>
          </li>

          <li>
              <a href="javascript:void(0)" onclick="confirmLogout()">
                  Logout
              </a>
          </li>

      </ul>

  </aside>


  <!-- MAIN CONTENT -->
  <main class="main-content">

      <div class="page-header">

          <h2>❌ Cancel Reservation</h2>

      </div>


      <div class="card cancel-card">

          <% if(error != null){ %>
              <div class="msg err"><%=error%></div>
          <% } %>

          <form method="post">

              <div class="form-group">

                  <label>Reservation Number</label>

                  <input class="input"
                         name="id"
                         placeholder="Enter reservation number">

              </div>

              <button class="btn danger">
                  Confirm Cancellation
              </button>

          </form>

      </div>

  </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

</body>
</html>
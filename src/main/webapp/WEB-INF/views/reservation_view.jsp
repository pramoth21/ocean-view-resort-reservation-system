<%@ page contentType="text/html;charset=UTF-8" %>
<%
  com.oceanview.model.Reservation r =
      (com.oceanview.model.Reservation) request.getAttribute("reservation");

  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Reservation Details | Ocean View Resort</title>

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/view-reservation.css">

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
              Reservation Details
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

          <h2>📄 Reservation Details</h2>

          <a class="btn ghost"
             href="<%=request.getContextPath()%>/receptionist">
             ← Back
          </a>

      </div>


      <div class="card">

        <% if(error != null){ %>

            <div class="msg err"><%=error%></div>

        <% } else if(r != null){ %>


            <!-- Reservation Number -->
            <div class="reservation-number">
                Reservation #<%=r.getReservationNo()%>
            </div>


            <!-- Details Grid -->
            <div class="detail-grid">

                <div class="detail-box">

                    <label>Guest Name</label>

                    <div class="value">
                        <%=r.getGuest().getName()%>
                    </div>

                </div>


                <div class="detail-box">

                    <label>Room Type</label>

                    <div class="value">
                        <%=r.getRoomType()%>
                    </div>

                </div>


                <div class="detail-box">

                    <label>Check-in Date</label>

                    <div class="value">
                        <%=r.getCheckIn()%>
                    </div>

                </div>


                <div class="detail-box">

                    <label>Check-out Date</label>

                    <div class="value">
                        <%=r.getCheckOut()%>
                    </div>

                </div>

            </div>


            <!-- Buttons -->
            <div class="action-row">

                <a class="btn primary"
                   href="<%=request.getContextPath()%>/receptionist/reservations/modify?id=<%=r.getReservationNo()%>">
                    ✏ Modify
                </a>


                <a class="btn danger"
                   href="<%=request.getContextPath()%>/receptionist/reservations/cancel?id=<%=r.getReservationNo()%>">
                    ❌ Cancel
                </a>

            </div>


        <% } %>

      </div>

  </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

</body>
</html>
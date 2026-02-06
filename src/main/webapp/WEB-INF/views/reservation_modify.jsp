<%@ page contentType="text/html;charset=UTF-8" %>
<%
  com.oceanview.model.Reservation r =
      (com.oceanview.model.Reservation) request.getAttribute("reservation");
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Modify Reservation</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">

  <!-- TOP BAR -->
  <div class="topbar">
    <div class="brand">
      <span>✏️ Modify Reservation</span>
      <span class="badge">Receptionist</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/receptionist">Dashboard</a>
      <a href="#" onclick="confirmLogout()">Logout</a>
    </div>
  </div>

  <div style="height:16px"></div>

  <!-- CARD -->
  <div class="card">

    <% if(error != null){ %>
      <div class="msg err"><%=error%></div>
    <% } %>

    <% if(r != null){ %>
    <form method="post"
          action="<%=request.getContextPath()%>/receptionist/reservations/modify">

      <!-- Hidden ID -->
      <input type="hidden" name="reservationNo"
             value="<%=r.getReservationNo()%>">

      <p><b>Guest:</b> <%=r.getGuest().getName()%></p>
      <p><b>Contact:</b> <%=r.getGuest().getContactNumber()%></p>

      <div class="row">
        <label>Room Type</label>
        <select name="roomType">
          <option <%= "STANDARD".equals(r.getRoomType()) ? "selected" : "" %>>
            STANDARD
          </option>
          <option <%= "DELUXE".equals(r.getRoomType()) ? "selected" : "" %>>
            DELUXE
          </option>
        </select>
      </div>

      <div class="row">
        <label>Check-in Date</label>
        <input class="input" type="date"
               name="checkIn" value="<%=r.getCheckIn()%>">
      </div>

      <div class="row">
        <label>Check-out Date</label>
        <input class="input" type="date"
               name="checkOut" value="<%=r.getCheckOut()%>">
      </div>

      <div style="height:14px"></div>

      <button class="btn">Update Reservation →</button>
      <a class="btn btn-ghost"
         href="<%=request.getContextPath()%>/receptionist">
         Cancel
      </a>
    </form>
    <% } %>

  </div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
</body>
</html>
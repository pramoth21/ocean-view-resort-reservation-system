<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.RoomType" %>
<%
  com.oceanview.model.Reservation r =
      (com.oceanview.model.Reservation) request.getAttribute("reservation");

  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Modify Reservation | Ocean View Resort</title>

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/modify-reservation.css">

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
              Modify Reservation
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

          <h2>✏ Modify Reservation</h2>

          <a class="btn ghost"
             href="<%=request.getContextPath()%>/receptionist">
             ← Back
          </a>

      </div>


      <div class="card">

        <% if(error != null){ %>
          <div class="msg err"><%=error%></div>
        <% } %>


        <% if(r != null){ %>

        <form method="post"
              action="<%=request.getContextPath()%>/receptionist/reservations/modify">

          <input type="hidden"
                 name="reservationNo"
                 value="<%=r.getReservationNo()%>">


          <!-- Guest Info Card -->
          <div class="guest-box">

              <div class="guest-item">
                  <label>Guest Name</label>
                  <div class="guest-value">
                      <%=r.getGuest().getName()%>
                  </div>
              </div>

              <div class="guest-item">
                  <label>Contact Number</label>
                  <div class="guest-value">
                      <%=r.getGuest().getContactNumber()%>
                  </div>
              </div>

          </div>


          <!-- Form Grid -->
          <div class="form-grid">

              <div class="form-group">

                  <label>Room Type</label>

                  <select name="roomType" class="input">

                      <option value="">Select Room Type</option>

                      <% List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
                         if (roomTypes != null) { for (RoomType t : roomTypes) { %>

                      <option value="<%= t.getTypeCode() %>"
                        <%= t.getTypeCode().equals(r.getRoomType()) ? "selected" : "" %>>
                        <%= t.getTypeCode() %> - <%= t.getTypeName() %>
                      </option>

                      <% } } %>

                  </select>

              </div>


              <div class="form-group">

                  <label>Check-in Date</label>

                  <input type="date"
                         name="checkIn"
                         class="input"
                         value="<%=r.getCheckIn()%>">

              </div>


              <div class="form-group">

                  <label>Check-out Date</label>

                  <input type="date"
                         name="checkOut"
                         class="input"
                         value="<%=r.getCheckOut()%>">

              </div>

          </div>


          <!-- Buttons -->
          <div class="action-row">

              <button class="btn primary">
                  Update Reservation
              </button>

              <a class="btn ghost"
                 href="<%=request.getContextPath()%>/receptionist">
                 Cancel
              </a>

          </div>

        </form>

        <% } %>

      </div>

  </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

</body>
</html>
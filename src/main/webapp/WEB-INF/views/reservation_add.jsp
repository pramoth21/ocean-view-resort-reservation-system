<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Add Reservation</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/reservation-add.css">
</head>
<body>
<div class="container">

  <div class="topbar">
    <div class="brand">
      <span>➕ New Reservation</span>
      <span class="badge">Receptionist</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/receptionist">Back</a>
      <a href="#" onclick="confirmLogout()">Logout</a>
    </div>
  </div>

  <div class="card">
    <% if(error != null){ %>
      <div class="msg err"><%=error%></div>
    <% } %>

    <form method="post">

      <input type="hidden" id="guestId" name="guestId">

      <div class="row">
        <label>Search Existing Guest (by name)</label>
        <div style="display:flex;gap:10px;">
          <input id="searchName" class="input" placeholder="e.g. Kasun">
          <button type="button" class="btn btn-ghost" onclick="searchGuestByName()">Search</button>
        </div>
        <small id="guestSearchMsg"></small>
      </div>

      <div class="row">
        <label>Contact Number</label>
        <input id="contact" name="contact" class="input" maxlength="10" onkeyup="fetchGuestByContact()">
      </div>

      <div class="row">
        <label>Guest Name</label>
        <input id="guestName" name="guestName" class="input">
      </div>

      <div class="row">
        <label>Address</label>
        <input id="address" name="address" class="input">
      </div>

      <div class="row">
        <label>Room Type</label>
        <select id="roomType" name="roomType" onchange="loadAvailableRooms()">
          <option value="">Select</option>
          <option>STANDARD</option>
          <option>DELUXE</option>
          <option>SUITE</option>
        </select>
      </div>

      <div class="row">
        <label>Check-in</label>
        <input id="checkIn" type="date" name="checkIn" class="input" onchange="loadAvailableRooms()">
      </div>

      <div class="row">
        <label>Check-out</label>
        <input id="checkOut" type="date" name="checkOut" class="input" onchange="loadAvailableRooms()">
      </div>

      <div class="row">
        <label>Available Rooms</label>
        <select id="roomId" name="roomId">
          <option value="">Select dates + room type first</option>
        </select>
        <small id="availMsg"></small>
      </div>

      <button class="btn">Create Reservation</button>
    </form>
  </div>

</div>

<!-- ✅ IMPORTANT: inject context path for app.js -->
<script>
  window.APP_CTX = "<%=request.getContextPath()%>";
</script>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
</body>
</html>
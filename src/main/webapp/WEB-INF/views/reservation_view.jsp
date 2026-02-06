<%@ page contentType="text/html;charset=UTF-8" %>
<%
  com.oceanview.model.Reservation r =
      (com.oceanview.model.Reservation) request.getAttribute("reservation");
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>View Reservation</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">

  <div class="topbar">
    <div class="brand">
      <span>📄 Reservation Details</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/receptionist">Back</a>
    </div>
  </div>

  <div class="card">
    <% if(error != null){ %>
      <div class="msg err"><%=error%></div>
    <% } else if(r != null){ %>
      <p><b>Guest:</b> <%=r.getGuest().getName()%></p>
      <p><b>Room:</b> <%=r.getRoomType()%></p>
      <p><b>Check-in:</b> <%=r.getCheckIn()%></p>
      <p><b>Check-out:</b> <%=r.getCheckOut()%></p>

      <a class="btn btn-ghost"
         href="<%=request.getContextPath()%>/receptionist/reservations/modify?id=<%=r.getReservationNo()%>">
        Modify
      </a>

      <a class="btn btn-danger"
         href="<%=request.getContextPath()%>/receptionist/reservations/cancel?id=<%=r.getReservationNo()%>">
        Cancel
      </a>
    <% } %>
  </div>

</div>
</body>
</html>
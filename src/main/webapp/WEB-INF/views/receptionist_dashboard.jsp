<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.Reservation" %>
<%
  List<Reservation> reservations =
      (List<Reservation>) request.getAttribute("reservations");

  int total = reservations == null ? 0 : reservations.size();
%>
<!DOCTYPE html>
<html>
<head>
  <title>Receptionist | Dashboard</title>
  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/receptionist-dashboard.css">
</head>
<body>

<div class="dashboard-wrapper">

  <!-- TOP BAR -->
  <div class="topbar">
      <div class="brand">
          🧾 Receptionist Dashboard
          <span class="badge">Front Desk</span>
      </div>
      <div class="nav">
          <a href="<%=request.getContextPath()%>/receptionist/reservations/add">Add Reservation</a>
          <a href="<%=request.getContextPath()%>/receptionist/bill">Generate Bill</a>
          <a href="<%=request.getContextPath()%>/help">Help</a>
          <a href="#" onclick="confirmLogout()">Logout</a>
      </div>
  </div>

  <!-- SUMMARY -->
  <div class="summary-section">

      <div class="summary-card">
          <h3>Total Active Reservations</h3>
          <p><%=total%></p>
      </div>

      <div class="summary-card">
          <h3>Today's Date</h3>
          <p><%=java.time.LocalDate.now()%></p>
      </div>

      <div class="summary-card action-card">
          <a href="<%=request.getContextPath()%>/receptionist/reservations/add">
              + New Booking
          </a>
      </div>

  </div>

  <!-- TABLE -->
  <div class="table-card">

      <div class="table-header">
          <h2>Active Reservations</h2>
          <input type="text"
                 id="tableSearch"
                 placeholder="Search by Guest Name..."
                 onkeyup="filterTable()">
      </div>

      <table id="reservationTable">
          <thead>
              <tr>
                  <th>ID</th>
                  <th>Guest</th>
                  <th>Room Type</th>
                  <th>Check-in</th>
                  <th>Check-out</th>
                  <th>Status</th>
                  <th>Action</th>
              </tr>
          </thead>
          <tbody>
          <% if(reservations != null){ %>
              <% for(Reservation r : reservations){ %>
              <tr>
                  <td><%=r.getReservationNo()%></td>
                  <td><%=r.getGuest().getName()%></td>
                  <td><%=r.getRoomType()%></td>
                  <td><%=r.getCheckIn()%></td>
                  <td><%=r.getCheckOut()%></td>
                  <td><span class="status"><%=r.getStatus()%></span></td>
                  <td>
                      <a class="btn-view"
                         href="<%=request.getContextPath()%>/receptionist/reservations/view?id=<%=r.getReservationNo()%>">
                          View
                      </a>
                  </td>
              </tr>
              <% } %>
          <% } %>
          </tbody>
      </table>

  </div>

</div>

<script>
function filterTable(){
    const input = document.getElementById("tableSearch");
    const filter = input.value.toLowerCase();
    const rows = document.querySelectorAll("#reservationTable tbody tr");

    rows.forEach(row => {
        const guest = row.cells[1].innerText.toLowerCase();
        row.style.display = guest.includes(filter) ? "" : "none";
    });
}
</script>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
</body>
</html>
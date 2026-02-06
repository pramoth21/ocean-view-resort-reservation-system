<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.Reservation" %>

<%
    Object revenueObj = request.getAttribute("revenue");
    double revenue = (revenueObj instanceof Double) ? (Double) revenueObj : 0.0;

    List<Reservation> reservations =
            (List<Reservation>) request.getAttribute("reservations");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Ocean View Resort</title>
    <link rel="stylesheet"
          href="<%=request.getContextPath()%>/assets/css/admin-dashboard.css">
</head>
<body>

<div class="dashboard-wrapper">

    <!-- ===== HEADER ===== -->
    <div class="header">
        <div class="title">
            🛡️ Admin Dashboard
            <span class="badge">Manager Panel</span>
        </div>

        <div class="nav">
            <a href="<%=request.getContextPath()%>/admin/users">Users</a>
            <a href="<%=request.getContextPath()%>/admin/reports">Reports</a>
            <a href="<%=request.getContextPath()%>/logout">Logout</a>
        </div>
    </div>

    <!-- ===== SUMMARY CARDS ===== -->
    <div class="summary-grid">

        <div class="summary-card revenue">
            <h3>Total Revenue</h3>
            <p>LKR <%=String.format("%,.2f", revenue)%></p>
        </div>

        <div class="summary-card count">
            <h3>Active Reservations</h3>
            <p><%= (reservations != null) ? reservations.size() : 0 %></p>
        </div>

        <div class="summary-card system">
            <h3>System Status</h3>
            <p class="online">Online</p>
        </div>

    </div>

    <!-- ===== MANAGEMENT SECTION ===== -->
    <div class="management-section">
        <h2>System Management</h2>

        <div class="management-grid">

            <!-- ✅ UPDATED: One unified Room Management page -->
            <a class="manage-btn"
               href="<%=request.getContextPath()%>/admin/rooms">
                Manage Rooms & Types
            </a>

            <a class="manage-btn"
               href="<%=request.getContextPath()%>/admin/rates">
                Manage Room Rates
            </a>

            <a class="manage-btn"
               href="<%=request.getContextPath()%>/admin/services">
                Manage Services
            </a>

            <a class="manage-btn"
               href="<%=request.getContextPath()%>/admin/users">
                Manage Users
            </a>

        </div>
    </div>

    <!-- ===== ACTIVE RESERVATIONS ===== -->
    <div class="reservation-section">
        <h2>Active Reservations</h2>

        <table class="reservation-table">
            <tr>
                <th>ID</th>
                <th>Guest</th>
                <th>Room Type</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <% if (reservations != null && !reservations.isEmpty()) { %>
                <% for (Reservation r : reservations) { %>
                    <tr>
                        <td><%=r.getReservationNo()%></td>
                        <td><%=r.getGuest().getName()%></td>
                        <td><%=r.getRoomType()%></td>
                        <td><%=r.getStatus()%></td>
                        <td>
                            <a class="view-btn"
                               href="<%=request.getContextPath()%>/receptionist/reservations/view?id=<%=r.getReservationNo()%>">
                                View
                            </a>
                        </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="5" style="text-align:center;">
                        No active reservations.
                    </td>
                </tr>
            <% } %>

        </table>
    </div>

</div>

<script>
    window.APP_CTX = "<%=request.getContextPath()%>";
</script>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

</body>
</html>
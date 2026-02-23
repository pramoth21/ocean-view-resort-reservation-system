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

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">

        <div class="logo">🛡️ Admin Panel</div>

        <ul class="menu">

            <li class="active">
                Dashboard
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/admin/users">
                    Manage Users
                </a>
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/admin/rooms">
                    Rooms & Types
                </a>
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/admin/rates">
                    Room Rates
                </a>
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/admin/services">
                    Services
                </a>
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/admin/reports">
                    Reports
                </a>
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/logout">
                    Logout
                </a>
            </li>

        </ul>

    </aside>


    <!-- MAIN CONTENT -->
    <main class="main-content">

        <!-- Header -->
        <div class="page-header">

            <h2>Admin Dashboard</h2>

            <span class="badge">Ocean View Resort</span>

        </div>


        <!-- Summary Cards -->
        <div class="summary-grid">

            <div class="card">

                <label>Total Revenue</label>

                <div class="value">
                    LKR <%=String.format("%,.2f", revenue)%>
                </div>

            </div>


            <div class="card">

                <label>Active Reservations</label>

                <div class="value">
                    <%= (reservations != null) ? reservations.size() : 0 %>
                </div>

            </div>


            <div class="card">

                <label>System Status</label>

                <div class="value online">
                    ● Online
                </div>

            </div>

        </div>


        <!-- Management Section -->
        <div class="card">

            <h3>System Management</h3>

            <div class="management-grid">

                <a class="btn primary"
                   href="<%=request.getContextPath()%>/admin/rooms">
                    Manage Rooms
                </a>

                <a class="btn primary"
                   href="<%=request.getContextPath()%>/admin/rates">
                    Manage Rates
                </a>

                <a class="btn primary"
                   href="<%=request.getContextPath()%>/admin/services">
                    Manage Services
                </a>

                <a class="btn primary"
                   href="<%=request.getContextPath()%>/admin/users">
                    Manage Users
                </a>

                <a class="btn primary"
                   href="<%=request.getContextPath()%>/admin/reports">
                    View Reports
                </a>

            </div>

        </div>


        <!-- Active Reservations Table -->
        <div class="card">

            <h3>Active Reservations</h3>

            <table class="table">

                <tr>
                    <th>ID</th>
                    <th>Guest</th>
                    <th>Room Type</th>
                    <th>Status</th>
                </tr>

                <% if (reservations != null && !reservations.isEmpty()) { %>

                    <% for (Reservation res : reservations) { %>

                        <tr>

                            <td><%=res.getReservationNo()%></td>

                            <td><%=res.getGuest().getName()%></td>

                            <td><%=res.getRoomType()%></td>

                            <td>
                                <span class="status">
                                    <%=res.getStatus()%>
                                </span>
                            </td>

                        </tr>

                    <% } %>

                <% } else { %>

                    <tr>
                        <td colspan="4">No active reservations</td>
                    </tr>

                <% } %>

            </table>

        </div>

    </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

</body>
</html>
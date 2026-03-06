<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="java.util.List,com.oceanview.model.Reservation" %>
        <% List<Reservation> reservations =
            (List<Reservation>) request.getAttribute("reservations");

                int total = reservations == null ? 0 : reservations.size();
                %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Receptionist | Dashboard</title>
                    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/receptionist-dashboard.css">
                </head>

                <body>

                    <div class="layout">

                        <!-- SIDEBAR -->
                        <aside class="sidebar">
                            <div class="logo">
                                🌊 Ocean View
                            </div>

                            <ul class="menu">
                                <li class="active">Dashboard</li>
                                <li>
                                    <a href="<%=request.getContextPath()%>/receptionist/reservations/add">
                                        Add Reservation
                                    </a>
                                </li>
                                <li>
                                    <a href="<%=request.getContextPath()%>/receptionist/bill">
                                        Generate Bill
                                    </a>
                                </li>
                                <li>
                                    <a href="<%=request.getContextPath()%>/help">
                                        Help
                                    </a>
                                </li>
                                <li>
                                    <!-- ✅ FIXED LOGOUT -->
                                    <a href="javascript:void(0)" onclick="confirmLogout()">
                                        Logout
                                    </a>
                                </li>
                            </ul>
                        </aside>


                        <!-- MAIN CONTENT -->
                        <main class="main-content">

                            <!-- HEADER -->
                            <div class="dashboard-header">
                                <h2>Receptionist Dashboard</h2>
                                <span class="date">
                                    <%=java.time.LocalDate.now()%>
                                </span>
                            </div>

                            <!-- SUMMARY CARDS -->
                            <div class="summary-grid">

                                <div class="summary-box">
                                    <h4>Total Reservations</h4>
                                    <p>
                                        <%=total%>
                                    </p>
                                </div>

                                <div class="summary-box action">
                                    <a href="<%=request.getContextPath()%>/receptionist/reservations/add">
                                        + New Booking
                                    </a>
                                </div>

                            </div>

                            <!-- TABLE SECTION -->
                            <div class="table-container">

                                <div class="table-top">
                                    <h3>Reservations</h3>
                                    <input type="text" id="tableSearch" placeholder="Search by Guest..."
                                        onkeyup="filterTable()">
                                </div>

                                <table id="reservationTable">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Guest</th>
                                            <th>Room</th>
                                            <th>Check-in</th>
                                            <th>Check-out</th>
                                            <th>Status</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% if(reservations !=null){ %>
                                            <% for(Reservation r : reservations){ %>
                                                <tr>
                                                    <td>
                                                        <%=r.getReservationNo()%>
                                                    </td>
                                                    <td>
                                                        <%=r.getGuest().getName()%>
                                                    </td>
                                                    <td>
                                                        <%=r.getRoomType()%>
                                                    </td>
                                                    <td>
                                                        <%=r.getCheckIn()%>
                                                    </td>
                                                    <td>
                                                        <%=r.getCheckOut()%>
                                                    </td>
                                                    <td>
                                                        <span class="status-badge">
                                                            <%=r.getStatus()%>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <a class="view-btn"
                                                            href="<%=request.getContextPath()%>/receptionist/reservations/view?id=<%=r.getReservationNo()%>">
                                                            View
                                                        </a>
                                                        <a class="view-btn"
                                                            style="background: rgba(16, 185, 129, 0.1); color: #10b981; margin-left: 5px;"
                                                            href="<%=request.getContextPath()%>/receptionist/bill?id=<%=r.getReservationNo()%>">
                                                            Bill
                                                        </a>
                                                    </td>
                                                </tr>
                                                <% } %>
                                                    <% } %>
                                    </tbody>
                                </table>

                            </div>

                        </main>

                    </div>

                    <!-- ============================================
     EXISTING TABLE FILTER
     ============================================ -->
                    <script>
                        function filterTable() {
                            const input = document.getElementById("tableSearch");
                            const filter = input.value.toLowerCase();
                            const rows = document.querySelectorAll("#reservationTable tbody tr");

                            rows.forEach(row => {
                                const guest = row.cells[1].innerText.toLowerCase();
                                row.style.display = guest.includes(filter) ? "" : "none";
                            });
                        }
                    </script>

                    <script>
                        window.APP_CTX = "<%=request.getContextPath()%>";
                    </script>
                    <script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

                </body>

                </html>
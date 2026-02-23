<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String error = (String) request.getAttribute("error");
  com.oceanview.model.Bill bill = (com.oceanview.model.Bill) request.getAttribute("bill");
  com.oceanview.model.Reservation r = (com.oceanview.model.Reservation) request.getAttribute("reservation");

  Double extrasTotalObj = (Double) request.getAttribute("extrasTotal");
  Double grandTotalObj = (Double) request.getAttribute("grandTotal");
  double extrasTotal = extrasTotalObj == null ? 0.0 : extrasTotalObj;
  double grandTotal = grandTotalObj == null ? 0.0 : grandTotalObj;
%>
<!DOCTYPE html>
<html>
<head>
  <title>Generate Bill | Ocean View Resort</title>

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/bill-calculator.css">

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
                Generate Bill
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
            <h2>💰 Generate Bill</h2>
            <span class="badge">Receptionist</span>
        </div>

        <div class="bill-grid">

            <!-- LEFT FORM CARD -->
            <div class="card">

                <% if(error != null){ %>
                    <div class="msg err"><%=error%></div>
                <% } %>

                <form method="post">

                    <div class="form-group">
                        <label>Reservation Number</label>
                        <input class="input" name="id">
                    </div>

                    <div class="form-group">
                        <label>Discount (%)</label>
                        <input class="input" name="discount" value="0">
                    </div>

                    <div class="form-group">
                        <label>Extras</label>

                        <label class="check">
                            <input type="checkbox" name="extra" value="POOL">
                            Pool Usage
                        </label>

                        <label class="check">
                            <input type="checkbox" name="extra" value="DINING">
                            Dining Package
                        </label>

                        <label class="check">
                            <input type="checkbox" name="extra" value="LAUNDRY">
                            Laundry
                        </label>
                    </div>

                    <button class="btn primary">
                        Calculate Bill
                    </button>

                </form>

            </div>

            <!-- RIGHT RESULT CARD -->
            <div class="card result-card">

                <div class="result-header">
                    Final Amount
                </div>

                <div class="amount">
                    LKR <%=String.format("%,.2f", grandTotal)%>
                </div>

                <% if(bill != null && r != null){ %>
                    <div class="details">
                        <p><b>Guest:</b> <%=r.getGuest().getName()%></p>
                        <p><b>Nights:</b> <%=bill.getNights()%></p>
                        <p><b>Room Rate:</b> LKR <%=String.format("%,.2f", bill.getRate())%></p>
                        <p><b>Room Total:</b> LKR <%=String.format("%,.2f", bill.getTotal())%></p>
                        <p><b>Extras:</b> LKR <%=String.format("%,.2f", extrasTotal)%></p>
                    </div>
                <% } %>

            </div>

        </div>

    </main>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
</body>
</html>
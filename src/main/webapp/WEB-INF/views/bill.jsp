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
  <title>Generate Bill</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">

  <div class="topbar">
    <div class="brand">
      <span>💰 Billing</span>
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
      <div class="row">
        <label>Reservation Number</label>
        <input class="input" name="id">
      </div>

      <div class="row">
        <label>Discount (%)</label>
        <input class="input" name="discount" value="0">
      </div>

      <div class="row">
        <label>Extras</label>
        <label><input type="checkbox" name="extra" value="POOL"> Pool Usage</label><br>
        <label><input type="checkbox" name="extra" value="DINING"> Dining Package</label><br>
        <label><input type="checkbox" name="extra" value="LAUNDRY"> Laundry</label>
      </div>

      <button class="btn">Calculate Bill</button>
    </form>

    <% if(bill != null && r != null){ %>
      <div style="height:14px"></div>
      <div class="msg ok">
        Guest: <b><%=r.getGuest().getName()%></b><br>
        Nights: <%=bill.getNights()%><br>
        Rate: <%=String.format("%,.2f", bill.getRate())%><br>
        Room Total (after discount): <b>LKR <%=String.format("%,.2f", bill.getTotal())%></b><br>
        Extras Total: <b>LKR <%=String.format("%,.2f", extrasTotal)%></b><br>
        <hr>
        Grand Total: <b style="font-size:18px;">LKR <%=String.format("%,.2f", grandTotal)%></b>
      </div>
    <% } %>
  </div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
</body>
</html>
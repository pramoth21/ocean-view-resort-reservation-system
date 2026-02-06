<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Cancel Reservation</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">

  <div class="card">
    <h2>Cancel Reservation</h2>

    <% if(error != null){ %>
      <div class="msg err"><%=error%></div>
    <% } %>

    <form method="post">
      <label>Reservation Number</label>
      <input class="input" name="id">
      <button class="btn btn-danger">Confirm Cancel</button>
    </form>
  </div>

</div>
</body>
</html>
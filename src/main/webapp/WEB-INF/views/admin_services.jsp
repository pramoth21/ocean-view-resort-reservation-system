<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.ServiceItem" %>
<%
  List<ServiceItem> services = (List<ServiceItem>) request.getAttribute("services");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin | Services</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">
  <div class="topbar">
    <div class="brand"><span>🧺 Services</span><span class="badge">Admin</span></div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/admin/roomtypes">Room Types</a>
      <a href="<%=request.getContextPath()%>/admin/rooms">Rooms</a>
      <a href="<%=request.getContextPath()%>/admin/rates">Rates</a>
    </div>
  </div>

  <div class="grid grid-2" style="margin-top:16px;">
    <div class="card">
      <h2>Add Service</h2>
      <form method="post">
        <input type="hidden" name="action" value="create">
        <div class="row"><label>Code</label><input class="input" name="serviceCode" placeholder="POOL"></div>
        <div class="row"><label>Name</label><input class="input" name="serviceName" placeholder="Pool Usage"></div>
        <div class="row"><label>Price</label><input class="input" name="price" placeholder="2000"></div>
        <div class="row"><label>Active?</label><select name="active"><option value="1">Yes</option><option value="0">No</option></select></div>
        <button class="btn">Create</button>
      </form>
    </div>

    <div class="card">
      <h2>Existing Services</h2>
      <table class="table">
        <tr><th>ID</th><th>Code</th><th>Name</th><th>Price</th><th>Status</th><th>Actions</th></tr>
        <% for(ServiceItem s : services){ %>
        <tr>
          <td><%=s.getServiceId()%></td>
          <td><%=s.getServiceCode()%></td>
          <td><%=s.getServiceName()%></td>
          <td><%=String.format("%,.2f", s.getPrice())%></td>
          <td><%=s.isActive() ? "ACTIVE" : "INACTIVE"%></td>
          <td>
            <form method="post" style="display:inline">
              <input type="hidden" name="action" value="update">
              <input type="hidden" name="serviceId" value="<%=s.getServiceId()%>">
              <input class="input" name="serviceCode" style="width:90px;display:inline" value="<%=s.getServiceCode()%>">
              <input class="input" name="serviceName" style="width:130px;display:inline" value="<%=s.getServiceName()%>">
              <input class="input" name="price" style="width:90px;display:inline" value="<%=s.getPrice()%>">
              <button class="btn btn-ghost">Update</button>
            </form>

            <form method="post" style="display:inline">
              <input type="hidden" name="action" value="toggle">
              <input type="hidden" name="serviceId" value="<%=s.getServiceId()%>">
              <input type="hidden" name="active" value="<%=s.isActive()?0:1%>">
              <button class="btn <%=s.isActive() ? "btn-danger" : ""%>"><%=s.isActive() ? "Deactivate" : "Activate"%></button>
            </form>
          </td>
        </tr>
        <% } %>
      </table>
    </div>
  </div>
</div>
</body>
</html>
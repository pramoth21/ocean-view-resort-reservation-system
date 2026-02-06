<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.RoomRate2,com.oceanview.model.RoomType" %>
<%
  List<RoomRate2> rates = (List<RoomRate2>) request.getAttribute("rates");
  List<RoomType> types = (List<RoomType>) request.getAttribute("types");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin | Rates</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">
  <div class="topbar">
    <div class="brand"><span>💵 Room Rates</span><span class="badge">Admin</span></div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/admin/roomtypes">Room Types</a>
      <a href="<%=request.getContextPath()%>/admin/rooms">Rooms</a>
      <a href="<%=request.getContextPath()%>/admin/services">Services</a>
    </div>
  </div>

  <div class="grid grid-2" style="margin-top:16px;">
    <div class="card">
      <h2>Add Rate</h2>
      <form method="post">
        <input type="hidden" name="action" value="create">
        <div class="row"><label>Room Type</label>
          <select name="roomTypeId">
            <% for(RoomType t : types){ %>
              <option value="<%=t.getRoomTypeId()%>"><%=t.getTypeCode()%></option>
            <% } %>
          </select>
        </div>
        <div class="row"><label>Price Per Night</label><input class="input" name="price" placeholder="15000"></div>
        <div class="row"><label>Active?</label><select name="active"><option value="1">Yes</option><option value="0">No</option></select></div>
        <button class="btn">Create</button>
      </form>
    </div>

    <div class="card">
      <h2>Existing Rates</h2>
      <table class="table">
        <tr><th>ID</th><th>Type</th><th>Price</th><th>Status</th><th>Actions</th></tr>
        <% for(RoomRate2 r : rates){ %>
        <tr>
          <td><%=r.getRateId()%></td>
          <td><%=r.getTypeCode()%></td>
          <td><%=String.format("%,.2f", r.getPricePerNight())%></td>
          <td><%=r.isActive() ? "ACTIVE" : "INACTIVE"%></td>
          <td>
            <form method="post" style="display:inline">
              <input type="hidden" name="action" value="update">
              <input type="hidden" name="rateId" value="<%=r.getRateId()%>">
              <input class="input" name="price" style="width:120px;display:inline" value="<%=r.getPricePerNight()%>">
              <button class="btn btn-ghost">Update</button>
            </form>

            <form method="post" style="display:inline">
              <input type="hidden" name="action" value="toggle">
              <input type="hidden" name="rateId" value="<%=r.getRateId()%>">
              <input type="hidden" name="active" value="<%=r.isActive()?0:1%>">
              <button class="btn <%=r.isActive() ? "btn-danger" : ""%>"><%=r.isActive() ? "Deactivate" : "Activate"%></button>
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
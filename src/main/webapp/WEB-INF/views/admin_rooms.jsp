<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.Room,com.oceanview.model.RoomType" %>
<%
  List<Room> rooms = (List<Room>) request.getAttribute("rooms");
  List<RoomType> types = (List<RoomType>) request.getAttribute("types");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin | Rooms & Types</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>

<div class="container">

  <div class="topbar">
    <div class="brand">
      🏨 Room Management
      <span class="badge">Admin</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/admin">Dashboard</a>
      <a href="<%=request.getContextPath()%>/admin/rates">Rates</a>
      <a href="<%=request.getContextPath()%>/admin/services">Services</a>
    </div>
  </div>

  <div class="grid grid-2" style="margin-top:20px;">

    <!-- ================= ROOM TYPES ================= -->
    <div class="card">
      <h2>Add Room Type</h2>
      <form method="post">
        <input type="hidden" name="action" value="createType">
        <div class="row"><label>Type Code</label><input class="input" name="typeCode"></div>
        <div class="row"><label>Name</label><input class="input" name="typeName"></div>
        <div class="row"><label>Description</label><input class="input" name="description"></div>
        <div class="row"><label>Image Path</label><input class="input" name="imagePath"></div>
        <div class="row">
          <label>Active?</label>
          <select name="active">
            <option value="1">Yes</option>
            <option value="0">No</option>
          </select>
        </div>
        <button class="btn">Create Type</button>
      </form>

      <h3 style="margin-top:20px;">Existing Types</h3>
      <table class="table">
        <tr><th>ID</th><th>Code</th><th>Status</th><th>Action</th></tr>
        <% for(RoomType t : types){ %>
        <tr>
          <td><%=t.getRoomTypeId()%></td>
          <td><%=t.getTypeCode()%></td>
          <td><%=t.isActive() ? "ACTIVE" : "INACTIVE"%></td>
          <td>
            <form method="post">
              <input type="hidden" name="action" value="toggleType">
              <input type="hidden" name="id" value="<%=t.getRoomTypeId()%>">
              <input type="hidden" name="active" value="<%=t.isActive()?0:1%>">
              <button class="btn <%=t.isActive() ? "btn-danger" : ""%>">
                <%=t.isActive() ? "Deactivate" : "Activate"%>
              </button>
            </form>
          </td>
        </tr>
        <% } %>
      </table>
    </div>

    <!-- ================= ROOMS ================= -->
    <div class="card">
      <h2>Add Room</h2>
      <form method="post">
        <input type="hidden" name="action" value="createRoom">
        <div class="row"><label>Room No</label><input class="input" name="roomNo"></div>
        <div class="row">
          <label>Room Type</label>
          <select name="roomTypeId">
            <% for(RoomType t : types){ %>
              <option value="<%=t.getRoomTypeId()%>">
                <%=t.getTypeCode()%>
              </option>
            <% } %>
          </select>
        </div>
        <div class="row">
          <label>Active?</label>
          <select name="active">
            <option value="1">Yes</option>
            <option value="0">No</option>
          </select>
        </div>
        <button class="btn">Create Room</button>
      </form>

      <h3 style="margin-top:20px;">Existing Rooms</h3>
      <table class="table">
        <tr><th>ID</th><th>Room No</th><th>Type</th><th>Status</th><th>Action</th></tr>
        <% for(Room r : rooms){ %>
        <tr>
          <td><%=r.getRoomId()%></td>
          <td><%=r.getRoomNo()%></td>
          <td><%=r.getTypeCode()%></td>
          <td><%=r.isActive() ? "ACTIVE" : "INACTIVE"%></td>
          <td>
            <form method="post">
              <input type="hidden" name="action" value="toggleRoom">
              <input type="hidden" name="id" value="<%=r.getRoomId()%>">
              <input type="hidden" name="active" value="<%=r.isActive()?0:1%>">
              <button class="btn <%=r.isActive() ? "btn-danger" : ""%>">
                <%=r.isActive() ? "Deactivate" : "Activate"%>
              </button>
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
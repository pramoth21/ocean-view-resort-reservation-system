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

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/admin-rooms.css">

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">

      <div class="logo">🛡️ Admin Panel</div>

      <ul class="menu">

          <li>
              <a href="<%=request.getContextPath()%>/admin">
                  Dashboard
              </a>
          </li>

          <li class="active">
              Rooms & Types
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
              <a href="<%=request.getContextPath()%>/admin/users">
                  Users
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

      <div class="page-header">

          <h2>Room Management</h2>

          <span class="badge">Admin</span>

      </div>


      <div class="grid">


          <!-- ROOM TYPES -->
          <div class="card">

              <h3>Create Room Type</h3>

              <form method="post">

                  <input type="hidden" name="action" value="createType">

                  <div class="form-group">
                      <label>Type Code</label>
                      <input class="input" name="typeCode">
                  </div>

                  <div class="form-group">
                      <label>Name</label>
                      <input class="input" name="typeName">
                  </div>

                  <div class="form-group">
                      <label>Description</label>
                      <input class="input" name="description">
                  </div>

                  <div class="form-group">
                      <label>Image Path</label>
                      <input class="input" name="imagePath">
                  </div>

                  <div class="form-group">
                      <label>Status</label>
                      <select class="input" name="active">
                          <option value="1">Active</option>
                          <option value="0">Inactive</option>
                      </select>
                  </div>

                  <button class="btn primary">
                      Create Type
                  </button>

              </form>


              <h3 class="section-title">Existing Types</h3>

              <table class="table">

                  <tr>
                      <th>ID</th>
                      <th>Code</th>
                      <th>Status</th>
                      <th>Action</th>
                  </tr>

                  <% for(RoomType t : types){ %>

                  <tr>

                      <td><%=t.getRoomTypeId()%></td>

                      <td><%=t.getTypeCode()%></td>

                      <td>

                          <span class="<%=t.isActive()?"status-active":"status-inactive"%>">

                              <%=t.isActive()?"ACTIVE":"INACTIVE"%>

                          </span>

                      </td>

                      <td>

                          <form method="post">

                              <input type="hidden" name="action" value="toggleType">

                              <input type="hidden" name="id"
                                     value="<%=t.getRoomTypeId()%>">

                              <input type="hidden" name="active"
                                     value="<%=t.isActive()?0:1%>">

                              <button class="btn ghost">

                                  <%=t.isActive()?"Deactivate":"Activate"%>

                              </button>

                          </form>

                      </td>

                  </tr>

                  <% } %>

              </table>

          </div>



          <!-- ROOMS -->
          <div class="card">

              <h3>Create Room</h3>

              <form method="post">

                  <input type="hidden" name="action" value="createRoom">

                  <div class="form-group">

                      <label>Room Number</label>

                      <input class="input" name="roomNo">

                  </div>


                  <div class="form-group">

                      <label>Room Type</label>

                      <select class="input" name="roomTypeId">

                          <% for(RoomType t : types){ %>

                              <option value="<%=t.getRoomTypeId()%>">

                                  <%=t.getTypeCode()%>

                              </option>

                          <% } %>

                      </select>

                  </div>


                  <div class="form-group">

                      <label>Status</label>

                      <select class="input" name="active">

                          <option value="1">Active</option>

                          <option value="0">Inactive</option>

                      </select>

                  </div>


                  <button class="btn primary">

                      Create Room

                  </button>

              </form>


              <h3 class="section-title">Existing Rooms</h3>

              <table class="table">

                  <tr>
                      <th>ID</th>
                      <th>Room No</th>
                      <th>Type</th>
                      <th>Status</th>
                      <th>Action</th>
                  </tr>


                  <% for(Room r : rooms){ %>

                  <tr>

                      <td><%=r.getRoomId()%></td>

                      <td><%=r.getRoomNo()%></td>

                      <td><%=r.getTypeCode()%></td>

                      <td>

                          <span class="<%=r.isActive()?"status-active":"status-inactive"%>">

                              <%=r.isActive()?"ACTIVE":"INACTIVE"%>

                          </span>

                      </td>

                      <td>

                          <form method="post">

                              <input type="hidden" name="action" value="toggleRoom">

                              <input type="hidden" name="id"
                                     value="<%=r.getRoomId()%>">

                              <input type="hidden" name="active"
                                     value="<%=r.isActive()?0:1%>">

                              <button class="btn ghost">

                                  <%=r.isActive()?"Deactivate":"Activate"%>

                              </button>

                          </form>

                      </td>

                  </tr>

                  <% } %>

              </table>

          </div>

      </div>

  </main>

</div>

</body>
</html>
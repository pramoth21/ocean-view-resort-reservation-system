<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.RoomRate2,com.oceanview.model.RoomType" %>

<%
  List<RoomRate2> rates = (List<RoomRate2>) request.getAttribute("rates");
  List<RoomType> types = (List<RoomType>) request.getAttribute("types");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin | Room Rates</title>

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/admin-rates.css">

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

          <li>
              <a href="<%=request.getContextPath()%>/admin/rooms">
                  Rooms
              </a>
          </li>

          <li class="active">
              Room Rates
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

          <h2>Room Rates Management</h2>

          <span class="badge">Admin</span>

      </div>


      <div class="grid">

          <!-- ADD RATE CARD -->
          <div class="card">

              <h3>Create New Rate</h3>

              <form method="post">

                  <input type="hidden" name="action" value="create">

                  <div class="form-group">

                      <label>Room Type</label>

                      <select name="roomTypeId" class="input">

                          <% for(RoomType t : types){ %>

                              <option value="<%=t.getRoomTypeId()%>">
                                  <%=t.getTypeCode()%>
                              </option>

                          <% } %>

                      </select>

                  </div>


                  <div class="form-group">

                      <label>Price Per Night</label>

                      <input name="price"
                             class="input"
                             placeholder="15000">

                  </div>


                  <div class="form-group">

                      <label>Status</label>

                      <select name="active" class="input">

                          <option value="1">Active</option>

                          <option value="0">Inactive</option>

                      </select>

                  </div>


                  <button class="btn primary">
                      Create Rate
                  </button>

              </form>

          </div>


          <!-- EXISTING RATES -->
          <div class="card">

              <h3>Existing Rates</h3>

              <table class="table">

                  <tr>
                      <th>ID</th>
                      <th>Room Type</th>
                      <th>Price</th>
                      <th>Status</th>
                      <th>Actions</th>
                  </tr>


                  <% for(RoomRate2 r : rates){ %>

                  <tr>

                      <td><%=r.getRateId()%></td>

                      <td><%=r.getTypeCode()%></td>

                      <td>
                          LKR <%=String.format("%,.2f", r.getPricePerNight())%>
                      </td>

                      <td>

                          <span class="<%=r.isActive() ? "status-active" : "status-inactive"%>">

                              <%=r.isActive() ? "ACTIVE" : "INACTIVE"%>

                          </span>

                      </td>

                      <td>

                          <!-- Update -->
                          <form method="post" class="inline">

                              <input type="hidden" name="action" value="update">

                              <input type="hidden" name="rateId"
                                     value="<%=r.getRateId()%>">

                              <input name="price"
                                     value="<%=r.getPricePerNight()%>"
                                     class="input small">

                              <button class="btn ghost">
                                  Update
                              </button>

                          </form>


                          <!-- Toggle -->
                          <form method="post" class="inline">

                              <input type="hidden" name="action" value="toggle">

                              <input type="hidden" name="rateId"
                                     value="<%=r.getRateId()%>">

                              <input type="hidden" name="active"
                                     value="<%=r.isActive()?0:1%>">

                              <button class="btn <%=r.isActive()?"danger":"success"%>">

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
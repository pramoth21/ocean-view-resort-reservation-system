<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.ServiceItem" %>

<%
  List<ServiceItem> services =
      (List<ServiceItem>) request.getAttribute("services");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin | Services</title>

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/admin-services.css">

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
                  Rooms & Types
              </a>
          </li>

          <li>
              <a href="<%=request.getContextPath()%>/admin/rates">
                  Room Rates
              </a>
          </li>

          <li class="active">
              Services
          </li>

          <li>
              <a href="<%=request.getContextPath()%>/admin/users">
                  Manage Users
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

      <div class="page-header">

          <h2>Service Management</h2>

          <span class="badge">Admin</span>

      </div>



      <div class="grid">


          <!-- CREATE SERVICE -->
          <div class="card">

              <h3>Create Service</h3>

              <form method="post">

                  <input type="hidden" name="action" value="create">

                  <div class="form-group">

                      <label>Service Code</label>

                      <input class="input"
                             name="serviceCode"
                             placeholder="POOL">

                  </div>


                  <div class="form-group">

                      <label>Service Name</label>

                      <input class="input"
                             name="serviceName"
                             placeholder="Pool Usage">

                  </div>


                  <div class="form-group">

                      <label>Price</label>

                      <input class="input"
                             name="price"
                             placeholder="1500">

                  </div>


                  <div class="form-group">

                      <label>Status</label>

                      <select class="input" name="active">

                          <option value="1">Active</option>

                          <option value="0">Inactive</option>

                      </select>

                  </div>


                  <button class="btn primary">
                      Create Service
                  </button>

              </form>

          </div>



          <!-- EXISTING SERVICES -->
          <div class="card">

              <h3>Existing Services</h3>

              <table class="table">

                  <tr>

                      <th>ID</th>
                      <th>Code</th>
                      <th>Name</th>
                      <th>Price</th>
                      <th>Status</th>
                      <th>Actions</th>

                  </tr>


                  <% if(services != null){ %>

                      <% for(ServiceItem s : services){ %>

                      <tr>

                          <td><%=s.getServiceId()%></td>

                          <td><%=s.getServiceCode()%></td>

                          <td><%=s.getServiceName()%></td>

                          <td>LKR <%=String.format("%,.2f", s.getPrice())%></td>

                          <td>

                              <span class="<%=s.isActive() ? "status-active" : "status-inactive"%>">

                                  <%=s.isActive() ? "ACTIVE" : "INACTIVE"%>

                              </span>

                          </td>


                          <td>

                              <!-- UPDATE -->
                              <form method="post" class="inline">

                                  <input type="hidden" name="action" value="update">

                                  <input type="hidden"
                                         name="serviceId"
                                         value="<%=s.getServiceId()%>">

                                  <input class="input small"
                                         name="serviceCode"
                                         value="<%=s.getServiceCode()%>">

                                  <input class="input small"
                                         name="serviceName"
                                         value="<%=s.getServiceName()%>">

                                  <input class="input small"
                                         name="price"
                                         value="<%=s.getPrice()%>">

                                  <button class="btn ghost">
                                      Update
                                  </button>

                              </form>


                              <!-- TOGGLE -->
                              <form method="post" class="inline">

                                  <input type="hidden" name="action" value="toggle">

                                  <input type="hidden"
                                         name="serviceId"
                                         value="<%=s.getServiceId()%>">

                                  <input type="hidden"
                                         name="active"
                                         value="<%=s.isActive()?0:1%>">

                                  <button class="btn <%=s.isActive()?"danger":"success"%>">

                                      <%=s.isActive()?"Deactivate":"Activate"%>

                                  </button>

                              </form>

                          </td>

                      </tr>

                      <% } %>

                  <% } %>

              </table>

          </div>

      </div>

  </main>

</div>

</body>
</html>
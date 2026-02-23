<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.User" %>

<%
  List<User> users = (List<User>) request.getAttribute("users");
  String msg = request.getParameter("msg");
  String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>

  <title>Admin | Manage Users</title>

  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/admin-users.css">

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
        rel="stylesheet">

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

          <li>
              <a href="<%=request.getContextPath()%>/admin/services">
                  Services
              </a>
          </li>

          <li class="active">
              Manage Users
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

          <h2>Receptionist Management</h2>

          <span class="badge">Admin</span>

      </div>



      <!-- MESSAGES -->
      <% if(msg != null){ %>
          <div class="msg success"><%=msg%></div>
      <% } %>

      <% if(error != null){ %>
          <div class="msg error"><%=error%></div>
      <% } %>



      <div class="grid">


          <!-- CREATE USER -->
          <div class="card">

              <h3>Register Receptionist</h3>

              <p>Create secure login for front desk staff</p>

              <form method="post"
                    action="<%=request.getContextPath()%>/admin/users/create">

                  <div class="form-group">

                      <label>Username</label>

                      <input class="input"
                             name="username"
                             placeholder="recep01"
                             required>

                  </div>


                  <div class="form-group">

                      <label>Password</label>

                      <input class="input"
                             type="password"
                             name="password"
                             required>

                  </div>


                  <button class="btn primary">
                      Create Receptionist
                  </button>

              </form>

          </div>



          <!-- USER LIST -->
          <div class="card">

              <h3>Existing Receptionists</h3>

              <table class="table">

                  <tr>
                      <th>ID</th>
                      <th>Username</th>
                      <th>Action</th>
                  </tr>

                  <% if(users != null){ %>

                      <% for(User u : users){ %>

                          <tr>

                              <td><%=u.getUserId()%></td>

                              <td><%=u.getUsername()%></td>

                              <td>

                                  <form method="post"
                                        action="<%=request.getContextPath()%>/admin/users/delete"
                                        class="inline">

                                      <input type="hidden"
                                             name="userId"
                                             value="<%=u.getUserId()%>">

                                      <button class="btn danger">
                                          Delete
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


<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

</body>
</html>
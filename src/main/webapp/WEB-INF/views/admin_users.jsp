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
  <title>Admin | Manage Receptionists</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">

  <!-- TOP BAR -->
  <div class="topbar">
    <div class="brand">
      <span>👥 Receptionist Management</span>
      <span class="badge">Admin</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/admin">Dashboard</a>
      <a href="#" onclick="confirmLogout()">Logout</a>
    </div>
  </div>

  <div style="height:16px"></div>

  <!-- MESSAGES -->
  <% if(msg != null){ %>
    <div class="msg ok"><%=msg%></div>
  <% } %>

  <% if(error != null){ %>
    <div class="msg err"><%=error%></div>
  <% } %>

  <div style="height:16px"></div>

  <div class="grid grid-2">

    <!-- CREATE RECEPTIONIST -->
    <div class="card">
      <h2>Register New Receptionist</h2>
      <p>Create a secure login for front desk staff.</p>

      <form method="post"
            action="<%=request.getContextPath()%>/admin/users/create">

        <div class="row">
          <label>Username</label>
          <input class="input" name="username" placeholder="e.g. recep01">
        </div>

        <div class="row">
          <label>Password</label>
          <input class="input" type="password" name="password">
        </div>

        <div style="height:12px"></div>

        <button class="btn">Create Receptionist →</button>
      </form>

      <small>Password will be stored securely (hashed).</small>
    </div>

    <!-- LIST RECEPTIONISTS -->
    <div class="card">
      <h2>Existing Receptionists</h2>

      <table class="table">
        <tr>
          <th>ID</th>
          <th>Username</th>
          <th>Action</th>
        </tr>

        <% for(User u : users){ %>
          <tr>
            <td><%=u.getUserId()%></td>
            <td><%=u.getUsername()%></td>
            <td>
              <form method="post" style="display:inline">
                <input type="hidden" name="userId" value="<%=u.getUserId()%>">
                <button class="btn btn-danger">Delete</button>
              </form>
            </td>
          </tr>
        <% } %>
      </table>
    </div>

  </div>

</div>

<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
</body>
</html>
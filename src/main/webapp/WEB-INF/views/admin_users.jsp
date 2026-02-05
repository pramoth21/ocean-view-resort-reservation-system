<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.oceanview.model.User" %>

<%
  List<User> users = (List<User>) request.getAttribute("users");
  String msg = request.getParameter("msg");
%>

<!DOCTYPE html>
<html>
<head>
  <title>Admin | Manage Receptionists</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">

  <div class="topbar">
    <div class="brand">👩‍💼 Receptionist Management</div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/admin">Dashboard</a>
      <a href="<%=request.getContextPath()%>/admin/users/create">+ Add Receptionist</a>
      <a href="<%=request.getContextPath()%>/logout">Logout</a>
    </div>
  </div>

  <div style="height:16px"></div>

  <% if(msg != null){ %>
    <div class="msg ok"><%=msg%></div>
  <% } %>

  <div class="card">
    <h2>Receptionist Accounts</h2>

    <table class="table">
      <thead>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Role</th>
        <th>Action</th>
      </tr>
      </thead>
      <tbody>
      <% for(User u : users){ %>
        <tr>
          <td><%=u.getUserId()%></td>
          <td><%=u.getUsername()%></td>
          <td><%=u.getRole()%></td>
          <td>
            <form method="post" style="display:inline">
              <input type="hidden" name="userId" value="<%=u.getUserId()%>"/>
              <button class="btn btn-danger" name="action" value="deactivate">
                Deactivate
              </button>
            </form>
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>

    <% if(users.isEmpty()){ %>
      <small>No receptionists found.</small>
    <% } %>
  </div>

</div>
</body>
</html>
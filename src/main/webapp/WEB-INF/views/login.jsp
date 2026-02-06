<%@ page contentType="text/html;charset=UTF-8" %>
<%
  String role = (String) request.getAttribute("role");
  if(role == null) role = request.getParameter("role");
  if(role == null) role = "RECEPTIONIST";
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Login | Ocean View Resort</title>
  <link rel="stylesheet"
        href="<%=request.getContextPath()%>/assets/css/login.css">
</head>
<body>

<div class="login-wrapper">

    <div class="login-card">

        <div class="login-header">
            <h2>🌿 Ocean View Resort</h2>
            <p class="role"><%=role%> Login</p>
        </div>

        <% if(error != null){ %>
            <div class="error-box"><%=error%></div>
        <% } %>

        <form method="post"
              action="<%=request.getContextPath()%>/login">

            <input type="hidden" name="role" value="<%=role%>">

            <div class="form-group">
                <label>Username</label>
                <input type="text"
                       name="username"
                       required>
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password"
                       name="password"
                       required>
            </div>

            <button class="btn-login">
                Login →
            </button>

        </form>

        <div class="login-footer">
            <a href="<%=request.getContextPath()%>/home">Back to Home</a>
        </div>

    </div>

</div>

</body>
</html>
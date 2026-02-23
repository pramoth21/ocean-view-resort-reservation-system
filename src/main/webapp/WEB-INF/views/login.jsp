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

  <!-- Modern Font -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="login-wrapper">

    <!-- Background Image Section -->
    <div class="login-bg">
        <div class="bg-overlay"></div>

        <div class="bg-content">
            <h1>EXPLORE OCEAN<br>HORIZONS</h1>
            <p>
                Sustainable hospitality begins here.
                Welcome to Ocean View Resort management portal.
            </p>
        </div>
    </div>

    <!-- Glass Login Card -->
    <div class="login-card-container">

        <div class="glass-card">

            <div class="login-header">
                <h2>Ocean View Resort</h2>
                <p class="role"><%=role%> Login</p>
            </div>

            <% if(error != null){ %>
                <div class="error-box"><%=error%></div>
            <% } %>

            <form method="post"
                  action="<%=request.getContextPath()%>/login">

                <input type="hidden" name="role" value="<%=role%>">

                <div class="form-group">
                    <label>Email / Username</label>
                    <input type="text"
                           name="username"
                           placeholder="Enter your username"
                           required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password"
                           name="password"
                           placeholder="Enter your password"
                           required>
                </div>

                <button class="btn-login">
                    SIGN IN
                </button>

            </form>

            <div class="login-footer">
                <a href="<%=request.getContextPath()%>/home">
                    ← Back to Home
                </a>
            </div>

        </div>

    </div>

</div>

</body>
</html>
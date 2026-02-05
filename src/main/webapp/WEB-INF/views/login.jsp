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
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">
  <div class="topbar">
    <div class="brand">
      <span>🌊 Ocean View Resort</span>
      <span class="badge">Login</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/home">Home</a>
      <a href="<%=request.getContextPath()%>/help">Help</a>
    </div>
  </div>

  <div style="height:16px"></div>

  <div class="card" style="max-width:520px; margin:0 auto;">
    <h2><%=role%> Login</h2>
    <p>Enter your username and password to continue.</p>

    <% if(error != null){ %>
      <div class="msg err"><%=error%></div>
      <div style="height:10px"></div>
    <% } %>

    <form method="post" action="<%=request.getContextPath()%>/login">
      <input type="hidden" name="role" value="<%=role%>"/>

      <div class="row">
        <label>Username</label>
        <input class="input" name="username" placeholder="e.g. receptionist1" />
      </div>

      <div class="row">
        <label>Password</label>
        <input class="input" type="password" name="password" placeholder="••••••••" />
      </div>

      <div style="height:14px"></div>

      <button class="btn" type="submit">Login →</button>
      <a class="btn btn-ghost" href="<%=request.getContextPath()%>/home">Cancel</a>
    </form>

    <div style="height:10px"></div>
    <small>Tip: If you are Admin, you can create receptionist accounts from the Admin dashboard.</small>
  </div>
</div>
</body>
</html>
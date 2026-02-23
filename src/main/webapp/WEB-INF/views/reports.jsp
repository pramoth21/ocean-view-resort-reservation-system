<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.Reservation" %>

<%
List<Reservation> reservations =
        (List<Reservation>) request.getAttribute("reservations");

Double revenue =
        (Double) request.getAttribute("revenue");

if(revenue == null) revenue = 0.0;
%>

<!DOCTYPE html>
<html>
<head>

<title>Admin | Reports</title>

<link rel="stylesheet"
href="<%=request.getContextPath()%>/assets/css/admin-reports.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
rel="stylesheet">

</head>

<body>

<div class="layout">


<!-- ================= SIDEBAR ================= -->

<aside class="sidebar">

<div class="logo">🛡️ Admin Panel</div>

<ul class="menu">

<li>
<a href="<%=request.getContextPath()%>/admin">
Dashboard
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/admin/users">
Manage Users
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
Reports
</li>

<li>
<a href="<%=request.getContextPath()%>/logout">
Logout
</a>
</li>

</ul>

</aside>



<!-- ================= MAIN CONTENT ================= -->

<main class="main-content">


<!-- HEADER -->

<div class="page-header">

<h2>Reports & Analytics</h2>

<span class="badge">Ocean View Resort</span>

</div>



<!-- ================= SUMMARY ================= -->

<div class="summary-grid">


<div class="card">

<label>Total Revenue</label>

<div class="value">
LKR <%=String.format("%,.2f", revenue)%>
</div>

</div>


<div class="card">

<label>Total Reservations</label>

<div class="value">
<%= reservations == null ? 0 : reservations.size() %>
</div>

</div>


<div class="card">

<label>System Status</label>

<div class="value online">
● Online
</div>

</div>


</div>



<!-- ================= CHART ================= -->

<div class="card">

<h3>Daily Revenue (Last 7 Days)</h3>

<canvas id="chart"></canvas>

</div>



<!-- ================= RESERVATION TABLE ================= -->

<div class="card">

<h3>Recent Reservations</h3>

<table class="table">

<tr>
<th>ID</th>
<th>Guest</th>
<th>Room Type</th>
<th>Check-In</th>
<th>Status</th>
</tr>

<% if(reservations != null && !reservations.isEmpty()){ %>

<% for(Reservation r : reservations){ %>

<tr>

<td><%=r.getReservationNo()%></td>

<td><%=r.getGuest().getName()%></td>

<td><%=r.getRoomType()%></td>

<td><%=r.getCheckIn()%></td>

<td>
<span class="status">
<%=r.getStatus()%>
</span>
</td>

</tr>

<% } %>

<% } else { %>

<tr>
<td colspan="5" style="text-align:center;">
No reservations found.
</td>
</tr>

<% } %>

</table>

</div>


</main>

</div>



<!-- ================= SAFE CHART SCRIPT ================= -->

<script>

window.addEventListener("load", drawChart);


async function drawChart(){

const canvas =
document.getElementById("chart");

if(!canvas) return;

const ctx =
canvas.getContext("2d");

canvas.width = 800;
canvas.height = 300;

ctx.clearRect(0,0,canvas.width,canvas.height);

try{

const response =
await fetch("<%=request.getContextPath()%>/api/dailyIncome");

if(!response.ok){

drawEmptyChart(ctx, canvas);
return;

}

const data =
await response.json();

if(!data.ok || !data.days || data.days.length === 0){

drawEmptyChart(ctx, canvas);
return;

}

const days =
data.days;

const maxRevenue =
Math.max(...days.map(d => d.revenue), 1);

const padding = 50;

const usableWidth =
canvas.width - padding*2;

const usableHeight =
canvas.height - padding*2;

const barWidth =
usableWidth / days.length;

ctx.font = "12px Poppins";


days.forEach(function(day, index){

const revenue =
day.revenue;

const height =
(revenue / maxRevenue) * usableHeight;

const x =
padding + index * barWidth;

const y =
canvas.height - padding - height;


// bar
ctx.fillStyle="#0077b6";

ctx.fillRect(
x+10,
y,
barWidth-20,
height
);


// date
ctx.fillStyle="#333";

ctx.fillText(
day.date.substring(5),
x+10,
canvas.height-20
);


// value
ctx.fillText(
"LKR "+revenue.toFixed(0),
x+10,
y-5
);

});


}
catch(error){

drawEmptyChart(ctx, canvas);

}

}



function drawEmptyChart(ctx, canvas){

ctx.clearRect(0,0,canvas.width,canvas.height);

ctx.font="16px Poppins";

ctx.fillStyle="#888";

ctx.textAlign="center";

ctx.fillText(
"No revenue data available",
canvas.width/2,
canvas.height/2
);

}

</script>



</body>
</html>
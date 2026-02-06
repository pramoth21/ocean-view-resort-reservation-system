<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Reports</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
</head>
<body>
<div class="container">

  <div class="topbar">
    <div class="brand">
      <span>📊 Reports</span>
      <span class="badge">Admin</span>
    </div>
    <div class="nav">
      <a href="<%=request.getContextPath()%>/admin">Back</a>
    </div>
  </div>

  <div class="card">
    <p>Daily income chart (last 7 days)</p>
    <canvas id="chart" width="700" height="260"
            style="border:1px solid #ddd;border-radius:10px;"></canvas>
  </div>

</div>

<script>
async function drawChart(){
  const res = await fetch("<%=request.getContextPath()%>/api/dailyIncome");
  const data = await res.json();
  if(!data.ok) return;

  const canvas = document.getElementById("chart");
  const ctx = canvas.getContext("2d");

  ctx.clearRect(0,0,canvas.width,canvas.height);

  const days = data.days;
  const max = Math.max(...days.map(x => x.revenue), 1);

  const padding = 30;
  const barW = (canvas.width - padding*2) / days.length;

  days.forEach((d, i) => {
    const h = (d.revenue / max) * (canvas.height - padding*2);
    const x = padding + i*barW;
    const y = canvas.height - padding - h;

    ctx.fillRect(x+10, y, barW-20, h);
    ctx.fillText(d.date.substring(5), x+12, canvas.height-12);
  });
}

drawChart();
</script>
</body>
</html>
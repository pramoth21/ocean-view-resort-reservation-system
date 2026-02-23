<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List,com.oceanview.model.RoomType" %>

<%
String error = (String) request.getAttribute("error");
List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
%>

<!DOCTYPE html>
<html>
<head>
<title>Add Reservation | Ocean View Resort</title>

<link rel="stylesheet"
href="<%=request.getContextPath()%>/assets/css/reservation-add.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

</head>

<body>

<div class="layout">

<!-- ================= SIDEBAR ================= -->

<aside class="sidebar">

<div class="logo">🌊 Ocean View</div>

<ul class="menu">

<li>
<a href="<%=request.getContextPath()%>/receptionist">
Dashboard
</a>
</li>

<li class="active">
Add Reservation
</li>

<li>
<a href="<%=request.getContextPath()%>/receptionist/bill">
Generate Bill
</a>
</li>

<li>
<a href="<%=request.getContextPath()%>/help">
Help
</a>
</li>

<li>
<a href="javascript:void(0)" onclick="confirmLogout()">
Logout
</a>
</li>

</ul>

</aside>


<!-- ================= MAIN CONTENT ================= -->

<main class="main-content">

<div class="page-header">

<h2>➕ Create New Reservation</h2>

<span class="badge">Receptionist</span>

</div>


<div class="form-card">

<% if(error != null){ %>

<div class="msg err"><%=error%></div>

<% } %>


<form method="post">

<input type="hidden" id="guestId" name="guestId">


<div class="grid">


<!-- ================= SEARCH GUEST ================= -->

<div class="form-group">

<label>Search Existing Guest</label>

<div class="inline">

<input id="searchName"
class="input"
placeholder="Search by Guest Name">

<button type="button"
class="btn ghost"
onclick="searchGuestByName()">
Search
</button>

</div>


<select id="guestDropdown"
class="input"
style="display:none;margin-top:8px;"
onchange="selectGuestFromDropdown()">
</select>


<small id="guestSearchMsg"></small>

</div>


<!-- ================= CONTACT ================= -->

<div class="form-group">

<label>Contact Number</label>

<input id="contact"
name="contact"
class="input"
maxlength="10"
onkeyup="fetchGuestByContact()"
placeholder="Enter 10 digit contact number">

</div>


<!-- ================= NAME ================= -->

<div class="form-group">

<label>Guest Name</label>

<input id="guestName"
name="guestName"
class="input">

</div>


<!-- ================= ADDRESS ================= -->

<div class="form-group">

<label>Address</label>

<input id="address"
name="address"
class="input">

</div>


<!-- ================= ROOM TYPE (FROM DATABASE) ================= -->

<div class="form-group">

<label>Room Type</label>

<select id="roomType"
name="roomType"
onchange="loadAvailableRooms()"
class="input">

<option value="">Select Room Type</option>

<% if(roomTypes != null){ %>

<% for(RoomType t : roomTypes){ %>

<option value="<%=t.getTypeCode()%>">

<%=t.getTypeCode()%> - <%=t.getTypeName()%>

</option>

<% } %>

<% } %>

</select>

</div>


<!-- ================= CHECK-IN ================= -->

<div class="form-group">

<label>Check-in</label>

<input id="checkIn"
type="date"
name="checkIn"
class="input"
onchange="loadAvailableRooms()">

</div>


<!-- ================= CHECK-OUT ================= -->

<div class="form-group">

<label>Check-out</label>

<input id="checkOut"
type="date"
name="checkOut"
class="input"
onchange="loadAvailableRooms()">

</div>


<!-- ================= AVAILABLE ROOMS ================= -->

<div class="form-group">

<label>Available Rooms</label>

<select id="roomId"
name="roomId"
class="input">

<option value="">
Select dates + room type first
</option>

</select>

<small id="availMsg"></small>

</div>


</div>


<div class="submit-row">

<button class="btn primary">

Create Reservation

</button>

</div>


</form>

</div>

</main>

</div>



<script>

window.APP_CTX = "<%=request.getContextPath()%>";


// ================= SEARCH GUEST BY NAME =================

async function searchGuestByName(){

const name =
document.getElementById("searchName").value.trim();

const dropdown =
document.getElementById("guestDropdown");

const msg =
document.getElementById("guestSearchMsg");

dropdown.innerHTML = "";
dropdown.style.display = "none";


if(!name){

msg.innerText = "Enter guest name";

return;

}


msg.innerText = "Searching...";


try{

const res =
await fetch(APP_CTX + "/api/guestSearch?name=" + encodeURIComponent(name));

const data = await res.json();


if(!data.ok){

msg.innerText = data.message || "Guest not found";

return;

}


dropdown.style.display = "block";


data.results.forEach(g => {

const opt =
document.createElement("option");

opt.value = g.guestId;

opt.text =
g.name + " | " + g.contact;

opt.dataset.name = g.name;
opt.dataset.contact = g.contact;
opt.dataset.address = g.address;

dropdown.appendChild(opt);

});


msg.innerText =
"Select guest from dropdown";

}
catch(e){

msg.innerText = "Search failed";

}

}



// ================= SELECT GUEST =================

function selectGuestFromDropdown(){

const dropdown =
document.getElementById("guestDropdown");

const opt =
dropdown.options[dropdown.selectedIndex];


document.getElementById("guestId").value =
opt.value;

document.getElementById("guestName").value =
opt.dataset.name;

document.getElementById("contact").value =
opt.dataset.contact;

document.getElementById("address").value =
opt.dataset.address;


document.getElementById("guestSearchMsg").innerText =
"Guest selected successfully";

}



// ================= AUTO LOAD BY CONTACT =================

async function fetchGuestByContact(){

const contact =
document.getElementById("contact").value.trim();

if(contact.length != 10) return;


try{

const res =
await fetch(APP_CTX + "/api/guestByContact?contact=" + contact);

const data = await res.json();

if(!data.ok) return;


document.getElementById("guestId").value =
data.guestId;

document.getElementById("guestName").value =
data.name;

document.getElementById("address").value =
data.address;


document.getElementById("guestSearchMsg").innerText =
"Guest auto-loaded";

}
catch(e){}

}

</script>


<script src="<%=request.getContextPath()%>/assets/js/app.js"></script>


</body>

</html>
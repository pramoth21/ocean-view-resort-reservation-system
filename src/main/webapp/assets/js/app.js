/* ============================================
   OCEAN VIEW RESORT - GLOBAL JS
   ============================================ */

function confirmLogout() {
    if (confirm("Are you sure you want to logout?")) {
        window.location = window.APP_CTX + "/logout";
    }
}

/* ============================================
   GUEST SEARCH BY CONTACT
   ============================================ */
function fetchGuestByContact() {

    const contact = document.getElementById("contact").value.trim();
    if (contact.length !== 10) return;

    fetch(window.APP_CTX + "/api/guestSearch?contact=" + contact)
        .then(res => res.json())
        .then(data => {

            if (!data.ok) return;

            document.getElementById("guestId").value = data.guestId;
            document.getElementById("guestName").value = data.name;
            document.getElementById("address").value = data.address;

            document.getElementById("guestSearchMsg").innerText =
                "Existing guest loaded ✓";

        })
        .catch(err => console.error(err));
}


/* ============================================
   GUEST SEARCH BY NAME
   ============================================ */
function searchGuestByName() {

    const name = document.getElementById("searchName").value.trim();
    if (name === "") return;

    fetch(window.APP_CTX + "/api/guestSearch?name=" + encodeURIComponent(name))
        .then(res => res.json())
        .then(data => {

            const msgBox = document.getElementById("guestSearchMsg");

            if (!data.ok || !data.results || data.results.length === 0) {
                msgBox.innerText = "No guests found.";
                return;
            }

            let g = data.results[0];

            document.getElementById("guestId").value = g.guestId;
            document.getElementById("guestName").value = g.name;
            document.getElementById("address").value = g.address;
            document.getElementById("contact").value = g.contact;

            msgBox.innerText =
                "Guest selected: " + g.name + " ✓";

        })
        .catch(err => console.error(err));
}


/* ============================================
   LOAD AVAILABLE ROOMS
   ============================================ */
function loadAvailableRooms() {

    const type = document.getElementById("roomType").value;
    const checkIn = document.getElementById("checkIn").value;
    const checkOut = document.getElementById("checkOut").value;

    if (!type || !checkIn || !checkOut) return;

    fetch(
        window.APP_CTX +
        "/api/availableRooms?type=" + type +
        "&checkIn=" + checkIn +
        "&checkOut=" + checkOut
    )
        .then(res => res.json())
        .then(data => {

            const select = document.getElementById("roomId");
            const msg = document.getElementById("availMsg");

            select.innerHTML = "";

            if (!data.ok) {
                msg.innerText = "Error loading rooms.";
                return;
            }

            if (data.rooms.length === 0) {
                msg.innerText = "No rooms available.";
                select.innerHTML =
                    "<option value=''>No rooms available</option>";
                return;
            }

            msg.innerText = data.count + " room(s) available.";

            data.rooms.forEach(room => {

                let opt = document.createElement("option");
                opt.value = room.roomId;
                opt.textContent = "Room " + room.roomNo;

                select.appendChild(opt);
            });

        })
        .catch(err => console.error(err));
}
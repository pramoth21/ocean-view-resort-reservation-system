/* ============================================
   OCEAN VIEW RESORT - GLOBAL JS (FINAL FIXED)
   ============================================ */

function confirmLogout() {
    if (confirm("Are you sure you want to logout?")) {
        window.location = window.APP_CTX + "/logout";
    }
}

/* ============================================
   SEARCH GUEST BY CONTACT
   ============================================ */
function fetchGuestByContact() {

    const contactInput = document.getElementById("contact");
    const msgBox = document.getElementById("guestSearchMsg");

    if (!contactInput) return;

    const contact = contactInput.value.trim();

    // Only search when 10 digits entered
    if (contact.length !== 10) {
        msgBox.innerText = "";
        return;
    }

    fetch(window.APP_CTX + "/api/guestSearch?contact=" + contact)
        .then(res => {
            if (!res.ok) throw new Error("Server error");
            return res.json();
        })
        .then(data => {

            if (!data.ok) {
                msgBox.innerText = "Guest not found.";
                clearGuestFields();
                return;
            }

            populateGuestFields(data);
            msgBox.innerText = "Existing guest loaded ✓";

        })
        .catch(err => {
            console.error("Contact search error:", err);
            msgBox.innerText = "Error connecting to server.";
        });
}

/* ============================================
   SEARCH GUEST BY NAME (WITH DROPDOWN)
   ============================================ */
function searchGuestByName() {

    const name = document.getElementById("searchName").value.trim();
    const msgBox = document.getElementById("guestSearchMsg");
    const dropdown = document.getElementById("guestDropdown");

    dropdown.innerHTML = "";
    dropdown.style.display = "none";

    if (name === "") return;

    fetch(window.APP_CTX + "/api/guestSearch?name=" + encodeURIComponent(name))
        .then(res => res.json())
        .then(data => {

            if (!data.ok || !data.results || data.results.length === 0) {
                msgBox.innerText = "No guests found.";
                return;
            }

            msgBox.innerText = data.results.length + " guest(s) found.";
            dropdown.style.display = "block";

            data.results.forEach(g => {
                let opt = document.createElement("option");
                opt.value = JSON.stringify(g);
                opt.textContent = g.name + " (" + g.contact + ")";
                dropdown.appendChild(opt);
            });

        })
        .catch(err => {
            console.error(err);
            msgBox.innerText = "Search failed.";
        });
}

/* ============================================
   SELECT GUEST FROM DROPDOWN
   ============================================ */
function selectGuestFromDropdown() {

    const dropdown = document.getElementById("guestDropdown");
    const selected = dropdown.value;

    if (!selected) return;

    const guest = JSON.parse(selected);

    populateGuestFields(guest);

    document.getElementById("guestSearchMsg").innerText =
        "Guest selected: " + guest.name + " ✓";

    dropdown.style.display = "none";
}

/* ============================================
   POPULATE FIELDS
   ============================================ */
function populateGuestFields(g) {

    document.getElementById("guestId").value = g.guestId;
    document.getElementById("guestName").value = g.name;
    document.getElementById("address").value = g.address;
    document.getElementById("contact").value = g.contact;
}

function clearGuestFields() {
    document.getElementById("guestId").value = "";
    document.getElementById("guestName").value = "";
    document.getElementById("address").value = "";
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
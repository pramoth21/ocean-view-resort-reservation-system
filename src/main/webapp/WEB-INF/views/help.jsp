<%@ page contentType="text/html;charset=UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Help | Ocean View Resort</title>

        <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/help.css">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
            rel="stylesheet">
    </head>

    <body>

        <div class="layout">

            <!-- SIDEBAR -->
            <aside class="sidebar">
                <div class="logo">🌊 Ocean View</div>

                <ul class="menu">
                    <li>
                        <a href="<%=request.getContextPath()%>/receptionist">
                            Dashboard
                        </a>
                    </li>
                    <li>
                        <a href="<%=request.getContextPath()%>/receptionist/reservations/add">
                            Add Reservation
                        </a>
                    </li>
                    <li>
                        <a href="<%=request.getContextPath()%>/receptionist/bill">
                            Generate Bill
                        </a>
                    </li>
                    <li class="active">Help</li>
                    <li>
                        <a href="javascript:void(0)" onclick="confirmLogout()">
                            Logout
                        </a>
                    </li>
                </ul>
            </aside>

            <!-- MAIN CONTENT -->
            <main class="main-content">

                <div class="page-header">
                    <h2>💬 Help & Support</h2>
                    <span class="badge">Ocean Assistance</span>
                </div>

                <!-- Help Cards -->
                <div class="help-grid">

                    <div class="help-card">
                        <div class="icon">📘</div>
                        <h3>Reservations</h3>
                        <p>Learn how to create, edit and manage guest reservations efficiently.</p>
                    </div>

                    <div class="help-card">
                        <div class="icon">💰</div>
                        <h3>Billing</h3>
                        <p>Understand how billing, discounts and extras are calculated.</p>
                    </div>

                    <div class="help-card">
                        <div class="icon">⚙️</div>
                        <h3>System Settings</h3>
                        <p>Manage roles, access levels and operational settings.</p>
                    </div>

                </div>

                <!-- FAQ SECTION -->
                <div class="faq-section">

                    <h3>Frequently Asked Questions</h3>

                    <div class="faq-item">
                        <button class="faq-question">How do I create a new reservation?</button>
                        <div class="faq-answer">
                            Go to "Add Reservation" from the sidebar, fill in guest details and submit.
                        </div>
                    </div>

                    <div class="faq-item">
                        <button class="faq-question">How are extras calculated in billing?</button>
                        <div class="faq-answer">
                            Selected extras are added to room total and discounts are applied automatically.
                        </div>
                    </div>

                    <div class="faq-item">
                        <button class="faq-question">Can I edit an existing reservation?</button>
                        <div class="faq-answer">
                            Yes, navigate to Dashboard → View Reservation → Edit details.
                        </div>
                    </div>

                </div>

            </main>

        </div>

        <script>
            document.querySelectorAll(".faq-question").forEach(btn => {
                btn.addEventListener("click", () => {
                    const answer = btn.nextElementSibling;
                    answer.classList.toggle("open");
                });
            });
        </script>

        <script>
            window.APP_CTX = "<%=request.getContextPath()%>";
        </script>
        <script src="<%=request.getContextPath()%>/assets/js/app.js"></script>

    </body>

    </html>
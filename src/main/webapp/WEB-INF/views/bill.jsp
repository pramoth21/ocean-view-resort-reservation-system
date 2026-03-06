<%@ page contentType="text/html;charset=UTF-8" %>
    <% String error=(String) request.getAttribute("error"); com.oceanview.model.Bill bill=(com.oceanview.model.Bill)
        request.getAttribute("bill"); com.oceanview.model.Reservation r=(com.oceanview.model.Reservation)
        request.getAttribute("reservation"); Double extrasTotalObj=(Double) request.getAttribute("extrasTotal"); Double
        grandTotalObj=(Double) request.getAttribute("grandTotal"); double extrasTotal=extrasTotalObj==null ? 0.0 :
        extrasTotalObj; double grandTotal=grandTotalObj==null ? 0.0 : grandTotalObj; %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Generate Bill | Ocean View Resort</title>

            <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bill-calculator.css">

            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
                rel="stylesheet">
            <!-- Include html2pdf library via CDN -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
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
                        <li class="active">
                            Generate Bill
                        </li>
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
                        <h2>💰 Generate Bill</h2>
                        <span class="badge">Receptionist</span>
                    </div>

                    <div class="bill-grid">

                        <!-- LEFT FORM CARD -->
                        <div class="card">

                            <% if(error !=null){ %>
                                <div class="msg err">
                                    <%=error%>
                                </div>
                                <% } %>

                                    <% if(Boolean.TRUE.equals(request.getAttribute("noBillFound"))){ %>
                                        <div class="msg warn"
                                            style="background: #fff7ed; color: #9a3412; padding: 15px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid #f97316;">
                                            <strong>No Bill Calculated:</strong> This reservation does not have a bill
                                            calculated yet.
                                        </div>
                                        <% } %>

                                            <form method="post">

                                                <div class="form-group">
                                                    <label>Reservation Number</label>
                                                    <input class="input" name="id"
                                                        value="<%= r != null ? r.getReservationNo() : "" %>">
                                                </div>

                                                <div class="form-group">
                                                    <label>Discount (%)</label>
                                                    <input class="input" name="discount" value="0">
                                                </div>

                                                <div class="form-group">
                                                    <label>Extras</label>
                                                    <% java.util.List<com.oceanview.model.ServiceItem> itemList =
                                                        (java.util.List<com.oceanview.model.ServiceItem>)
                                                            request.getAttribute("services");
                                                            if(itemList != null) {
                                                            for(com.oceanview.model.ServiceItem s : itemList) {
                                                            if(s.isActive()) {
                                                            %>
                                                            <label class="check">
                                                                <input type="checkbox" name="extra"
                                                                    value="<%=s.getServiceCode()%>">
                                                                <%=s.getServiceName()%>
                                                            </label>
                                                            <% } } } %>
                                                </div>

                                                <button class="btn primary">
                                                    Calculate Bill
                                                </button>

                                            </form>

                        </div>

                        <!-- RIGHT RESULT CARD -->
                        <div class="card result-card" id="bill-content" style="position: relative;">

                            <!-- Hidden header exclusively for PDF -->
                            <div id="pdf-header"
                                style="display: none; text-align: center; margin-bottom: 20px; border-bottom: 2px solid #eee; padding-bottom: 15px;">
                                <h1 style="margin: 0; color: #1e3a8a; font-size: 28px;">🌊 Ocean View Resort</h1>
                                <p style="margin: 5px 0 0; color: #64748b; font-size: 14px;">123 Galle Road, Paradise
                                    Island • Tel: +94 74 044 0552</p>
                                <p style="margin: 0; color: #64748b; font-size: 14px;">Email: billing@oceanview.com •
                                    Website: www.oceanview.com</p>
                                <h2
                                    style="margin: 20px 0 5px; color: #334155; text-transform: uppercase; letter-spacing: 2px;">
                                    Official Invoice</h2>
                                <% if(r !=null) { %>
                                    <p style="margin: 0; color: #94a3b8; font-size: 12px; text-align: right;">Invoice
                                        No: #INV-<%=r.getReservationNo()%>-<%=System.currentTimeMillis()%>
                                    </p>
                                    <% } %>
                            </div>

                            <div class="result-header" style="font-weight: 600; font-size: 1.2rem;">
                                Final Amount
                            </div>

                            <div class="amount"
                                style="color: #0f172a; font-size: 2rem; font-weight: 700; margin: 15px 0;">
                                LKR <%=String.format("%,.2f", grandTotal)%>
                            </div>

                            <% if(bill !=null && r !=null){ %>
                                <div class="details"
                                    style="background: #f8fafc; padding: 20px; border-radius: 8px; margin-top: 20px; text-align: left; line-height: 1.8;">
                                    <div
                                        style="display: flex; justify-content: space-between; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 10px;">
                                        <span style="color: #64748b; font-weight: 500;">Guest Name:</span>
                                        <span style="color: #0f172a; font-weight: 600;">
                                            <%=r.getGuest().getName()%>
                                        </span>
                                    </div>
                                    <div
                                        style="display: flex; justify-content: space-between; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 10px;">
                                        <span style="color: #64748b; font-weight: 500;">Nights Stayed:</span>
                                        <span style="color: #0f172a; font-weight: 600;">
                                            <%=bill.getNights()%>
                                        </span>
                                    </div>
                                    <div
                                        style="display: flex; justify-content: space-between; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 10px;">
                                        <span style="color: #64748b; font-weight: 500;">Room Rate (per night):</span>
                                        <span style="color: #0f172a; font-weight: 600;">LKR <%=String.format("%,.2f",
                                                bill.getRate())%></span>
                                    </div>
                                    <div
                                        style="display: flex; justify-content: space-between; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 10px;">
                                        <span style="color: #64748b; font-weight: 500;">Room Total:</span>
                                        <span style="color: #0f172a; font-weight: 600;">LKR <%=String.format("%,.2f",
                                                bill.getTotal())%></span>
                                    </div>
                                    <div style="display: flex; justify-content: space-between; padding-bottom: 5px;">
                                        <span style="color: #64748b; font-weight: 500;">Additional Extras:</span>
                                        <span style="color: #0f172a; font-weight: 600;">LKR <%=String.format("%,.2f",
                                                extrasTotal)%></span>
                                    </div>
                                </div>
                                <div id="pdf-footer"
                                    style="display: none; text-align: center; margin-top: 40px; font-size: 12px; color: #94a3b8; border-top: 1px solid #eee; padding-top: 15px;">
                                    Thank you for staying at Ocean View Resort. We hope to see you again soon!
                                </div>

                                <button class="btn primary" id="download-btn" onclick="downloadBillPDF()"
                                    style="margin-top: 25px; width: 100%; padding: 12px; font-weight: 600; border-radius: 8px; background: #1e40af; color: white; border: none; cursor: pointer; transition: background 0.3s;">
                                    📥 Download Professional Invoice
                                </button>
                                <% } %>

                        </div>

                    </div>

                </main>

            </div>

            <script>
                window.APP_CTX = "<%=request.getContextPath()%>";
            </script>
            <script src="<%=request.getContextPath()%>/assets/js/app.js"></script>
            <script>
                function downloadBillPDF() {
                    // Hide the download button during PDF generation
                    const downloadBtn = document.getElementById('download-btn');
                    if (downloadBtn) {
                        downloadBtn.style.display = 'none';
                    }

                    const element = document.getElementById('bill-content');

                    const opt = {
                        margin: 0.5,
                        filename: 'Ocean_View_Invoice_<%= r != null ? r.getReservationNo() : "" %>.pdf',
                        image: { type: 'jpeg', quality: 0.98 },
                        html2canvas: { scale: 2 },
                        jsPDF: { unit: 'in', format: 'letter', orientation: 'portrait' }
                    };

                    // Setup view for PDF Generation
                    const pdfHeader = document.getElementById('pdf-header');
                    const pdfFooter = document.getElementById('pdf-footer');
                    if (pdfHeader) pdfHeader.style.display = 'block';
                    if (pdfFooter) pdfFooter.style.display = 'block';

                    // Generate PDF
                    html2pdf().set(opt).from(element).save().then(() => {
                        // Restore view back to web format
                        if (downloadBtn) downloadBtn.style.display = 'block';
                        if (pdfHeader) pdfHeader.style.display = 'none';
                        if (pdfFooter) pdfFooter.style.display = 'none';
                    });
                }
            </script>
        </body>

        </html>
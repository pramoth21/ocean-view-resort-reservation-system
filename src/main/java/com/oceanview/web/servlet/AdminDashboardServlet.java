package com.oceanview.web.servlet;

import com.oceanview.service.ReportService;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {

    private final ReportService reportService = new ReportService();
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Total revenue
        req.setAttribute("revenue",
                reportService.getTotalRevenueFromBills());

        // ✅ ADD THIS — Active reservations
        req.setAttribute("reservations",
                reservationService.listActiveReservations());

        req.getRequestDispatcher("/WEB-INF/views/admin_dashboard.jsp")
                .forward(req, resp);
    }
}
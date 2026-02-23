package com.oceanview.web.servlet;

import com.oceanview.service.ReportService;
import com.oceanview.service.ReservationService;
import com.oceanview.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ReportsServlet extends HttpServlet {

    private final ReportService reportService = new ReportService();
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            // ✅ Get total revenue
            double revenue =
                    reportService.getTotalRevenueFromBills();

            // ✅ Get all active reservations
            List<Reservation> reservations =
                    reservationService.listActiveReservations();

            // ✅ Send to JSP
            req.setAttribute("revenue", revenue);

            req.setAttribute("reservations", reservations);

        }
        catch(Exception e){
            e.printStackTrace();
        }

        req.getRequestDispatcher("/WEB-INF/views/reports.jsp")
                .forward(req, resp);
    }
}
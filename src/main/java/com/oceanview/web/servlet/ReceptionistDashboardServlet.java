package com.oceanview.web.servlet;

import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ReceptionistDashboardServlet extends HttpServlet {
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("reservations", reservationService.listActiveReservations());
        req.getRequestDispatcher("/WEB-INF/views/receptionist_dashboard.jsp").forward(req, resp);
    }
}

package com.oceanview.web.servlet;

import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ReservationCancelServlet extends HttpServlet {
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/reservation_cancel.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean ok = reservationService.cancelReservation(id);
            if (ok) resp.sendRedirect(req.getContextPath() + "/receptionist?msg=Reservation+Cancelled:+#" + id);
            else {
                req.setAttribute("error", "Cancel failed. Check reservation number.");
                req.getRequestDispatcher("/WEB-INF/views/reservation_cancel.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Please enter a valid reservation number.");
            req.getRequestDispatcher("/WEB-INF/views/reservation_cancel.jsp").forward(req, resp);
        }
    }
}

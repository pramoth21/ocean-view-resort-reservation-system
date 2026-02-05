package com.oceanview.web.servlet;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ReservationViewServlet extends HttpServlet {
    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        try {
            int id = Integer.parseInt(idStr);
            Reservation r = reservationService.getReservation(id);
            if (r == null) {
                req.setAttribute("error", "Reservation not found.");
            } else {
                req.setAttribute("reservation", r);
            }
        } catch (Exception e) {
            req.setAttribute("error", "Please enter a valid reservation number.");
        }
        req.getRequestDispatcher("/WEB-INF/views/reservation_view.jsp").forward(req, resp);
    }
}

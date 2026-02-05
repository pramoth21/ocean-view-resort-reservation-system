package com.oceanview.web.api;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import com.oceanview.util.JsonUtil;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * REST-style API to fetch reservation details as JSON.
 */
public class ReservationApiServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);

            Reservation r = reservationService.getReservation(id);

            if (r == null) {
                resp.getWriter().write(
                        "{\"ok\":false,\"message\":\"Reservation not found\"}"
                );
                return;
            }

            // Build JSON response using Guest object
            String json = "{"
                    + "\"ok\":true,"
                    + "\"reservationNo\":" + r.getReservationNo() + ","
                    + "\"guestName\":\"" + JsonUtil.escape(r.getGuest().getName()) + "\","
                    + "\"contact\":\"" + JsonUtil.escape(r.getGuest().getContactNumber()) + "\","
                    + "\"roomType\":\"" + JsonUtil.escape(r.getRoomType()) + "\","
                    + "\"checkIn\":\"" + r.getCheckIn() + "\","
                    + "\"checkOut\":\"" + r.getCheckOut() + "\","
                    + "\"status\":\"" + JsonUtil.escape(r.getStatus()) + "\""
                    + "}";

            resp.getWriter().write(json);

        } catch (Exception e) {
            resp.getWriter().write(
                    "{\"ok\":false,\"message\":\"Invalid reservation number\"}"
            );
        }
    }
}

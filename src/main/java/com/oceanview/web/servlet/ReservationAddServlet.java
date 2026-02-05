package com.oceanview.web.servlet;

import com.oceanview.model.Guest;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import com.oceanview.util.DateUtil;
import com.oceanview.util.Validation;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

/**
 * Handles adding new reservations by receptionist.
 */
public class ReservationAddServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            // 1️⃣ Read guest details
            String guestName = req.getParameter("guestName");
            String address = req.getParameter("address");
            String contact = req.getParameter("contact");

            // 2️⃣ Read reservation details
            String roomType = req.getParameter("roomType");
            LocalDate checkIn = DateUtil.parseDate(req.getParameter("checkIn"));
            LocalDate checkOut = DateUtil.parseDate(req.getParameter("checkOut"));

            // 3️⃣ Validate inputs
            String error = Validation.validateReservationInputs(
                    guestName, address, contact, roomType, checkIn, checkOut
            );

            if (error != null) {
                req.setAttribute("error", error);
                req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                        .forward(req, resp);
                return;
            }

            // 4️⃣ Create Guest object
            Guest guest = new Guest(guestName, address, contact);

            // 5️⃣ Create Reservation object
            Reservation reservation = new Reservation();
            reservation.setRoomType(roomType);
            reservation.setCheckIn(checkIn);
            reservation.setCheckOut(checkOut);

            // 6️⃣ Call service (guest check + reservation save)
            int newReservationNo =
                    reservationService.addReservation(guest, reservation);

            if (newReservationNo > 0) {
                resp.sendRedirect(
                        req.getContextPath()
                                + "/receptionist?msg=Reservation+Created+Successfully:+#"
                                + newReservationNo
                );
            } else {
                req.setAttribute("error",
                        "Failed to create reservation. Please try again.");
                req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                        .forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error",
                    "Invalid input. Please check details and try again.");
            req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                    .forward(req, resp);
        }
    }
}

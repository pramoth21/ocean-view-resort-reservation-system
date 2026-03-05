package com.oceanview.web.servlet;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.Reservation;
import com.oceanview.model.RoomType;
import com.oceanview.service.ReservationService;
import com.oceanview.util.DateUtil;
import com.oceanview.util.Validation;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * Handles modification of existing reservations.
 * Guest details are NOT modified here.
 */
public class ReservationModifyServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    private void loadRoomTypes(HttpServletRequest req) {
        List<RoomType> roomTypes = DaoFactory.roomTypeDao().findAll();
        req.setAttribute("roomTypes", roomTypes);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        loadRoomTypes(req);

        String idStr = req.getParameter("id");

        try {
            int id = Integer.parseInt(idStr);
            Reservation reservation = reservationService.getReservation(id);

            if (reservation == null) {
                req.setAttribute("error", "Reservation not found.");
            } else {
                req.setAttribute("reservation", reservation);
            }

        } catch (Exception e) {
            req.setAttribute("error", "Invalid reservation number.");
        }

        req.getRequestDispatcher("/WEB-INF/views/reservation_modify.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        loadRoomTypes(req);

        try {
            int reservationNo = Integer.parseInt(req.getParameter("reservationNo"));

            // Reservation details ONLY
            String roomType = req.getParameter("roomType");
            LocalDate checkIn = DateUtil.parseDate(req.getParameter("checkIn"));
            LocalDate checkOut = DateUtil.parseDate(req.getParameter("checkOut"));

            // Validate reservation data (guest fields removed)
            String error = Validation.validateReservationDates(
                    roomType, checkIn, checkOut);

            if (error != null) {
                req.setAttribute("error", error);
                req.getRequestDispatcher("/WEB-INF/views/reservation_modify.jsp")
                        .forward(req, resp);
                return;
            }

            // Load existing reservation
            Reservation reservation = reservationService.getReservation(reservationNo);

            if (reservation == null) {
                req.setAttribute("error", "Reservation not found.");
                req.getRequestDispatcher("/WEB-INF/views/reservation_modify.jsp")
                        .forward(req, resp);
                return;
            }

            // Update allowed fields
            reservation.setRoomType(roomType);
            reservation.setCheckIn(checkIn);
            reservation.setCheckOut(checkOut);

            boolean success = reservationService.modifyReservation(reservation);

            if (success) {
                resp.sendRedirect(
                        req.getContextPath()
                                + "/receptionist?msg=Reservation+Updated:+#"
                                + reservationNo);
            } else {
                req.setAttribute("error",
                        "Update failed. Reservation may be cancelled.");
                req.getRequestDispatcher("/WEB-INF/views/reservation_modify.jsp")
                        .forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error",
                    "Invalid input. Please check values and try again.");
            req.getRequestDispatcher("/WEB-INF/views/reservation_modify.jsp")
                    .forward(req, resp);
        }
    }
}

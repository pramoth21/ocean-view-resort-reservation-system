package com.oceanview.web.servlet;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.Guest;
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

public class ReservationAddServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    private void loadRoomTypes(HttpServletRequest req) {
        List<RoomType> roomTypes = DaoFactory.roomTypeDao().findAll();
        req.setAttribute("roomTypes", roomTypes);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ✅ Always load room types for dropdown
        loadRoomTypes(req);

        req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // ✅ VERY IMPORTANT: load room types again for dropdown on POST too
        loadRoomTypes(req);

        try {
            // Guest fields
            String guestIdStr = req.getParameter("guestId");
            String guestName = req.getParameter("guestName");
            String address = req.getParameter("address");
            String contact = req.getParameter("contact");

            // Reservation details
            String roomType = req.getParameter("roomType");
            String roomIdStr = req.getParameter("roomId");
            LocalDate checkIn = DateUtil.parseDate(req.getParameter("checkIn"));
            LocalDate checkOut = DateUtil.parseDate(req.getParameter("checkOut"));

            // Validation
            if (guestIdStr == null || guestIdStr.trim().isEmpty()) {
                String error = Validation.validateReservationInputs(
                        guestName, address, contact, roomType, checkIn, checkOut
                );
                if (error != null) {
                    req.setAttribute("error", error);
                    req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                            .forward(req, resp);
                    return;
                }
            } else {
                String error = Validation.validateReservationDates(roomType, checkIn, checkOut);
                if (error != null) {
                    req.setAttribute("error", error);
                    req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                            .forward(req, resp);
                    return;
                }
            }

            // Build reservation
            Reservation reservation = new Reservation();
            reservation.setRoomType(roomType);
            reservation.setCheckIn(checkIn);
            reservation.setCheckOut(checkOut);

            if (roomIdStr != null && !roomIdStr.trim().isEmpty()) {
                reservation.setRoomId(Integer.parseInt(roomIdStr));
            } else {
                req.setAttribute("error", "Please select an available room.");
                req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                        .forward(req, resp);
                return;
            }

            // Build guest
            Guest guest;
            if (guestIdStr != null && !guestIdStr.trim().isEmpty()) {
                int gid = Integer.parseInt(guestIdStr);
                Guest dbGuest = reservationService.getGuestById(gid);
                if (dbGuest == null) {
                    req.setAttribute("error", "Selected guest not found. Please search again.");
                    req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                            .forward(req, resp);
                    return;
                }
                guest = dbGuest;
            } else {
                guest = new Guest(guestName, address, contact);
            }

            int newReservationNo = reservationService.addReservation(guest, reservation);

            if (newReservationNo > 0) {
                resp.sendRedirect(req.getContextPath()
                        + "/receptionist?msg=Reservation+Created+Successfully:+#"
                        + newReservationNo);
            } else {
                req.setAttribute("error", "Failed to create reservation. Please try again.");
                req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                        .forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Invalid input. Please check details and try again.");
            req.getRequestDispatcher("/WEB-INF/views/reservation_add.jsp")
                    .forward(req, resp);
        }
    }
}
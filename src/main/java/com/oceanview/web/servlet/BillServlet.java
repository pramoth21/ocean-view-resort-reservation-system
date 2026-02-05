package com.oceanview.web.servlet;

import com.oceanview.config.DBConnection;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.service.BillingService;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class BillServlet extends HttpServlet {
    private final ReservationService reservationService = new ReservationService();
    private final BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            double discount = 0.0;
            try { discount = Double.parseDouble(req.getParameter("discount")); } catch (Exception ignored) {}

            Reservation r = reservationService.getReservation(id);
            if (r == null) {
                req.setAttribute("error", "Reservation not found.");
                req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);
                return;
            }

            Bill bill = billingService.calculateBill(r, discount);
            saveBill(bill);

            req.setAttribute("bill", bill);
            req.setAttribute("reservation", r);
            req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Please enter a valid reservation number.");
            req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);
        }
    }

    private void saveBill(Bill bill) {
        String sql = "INSERT INTO bills(reservation_no,nights,rate,discount,total) VALUES(?,?,?,?,?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bill.getReservationNo());
            ps.setInt(2, bill.getNights());
            ps.setDouble(3, bill.getRate());
            ps.setDouble(4, bill.getDiscount());
            ps.setDouble(5, bill.getTotal());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

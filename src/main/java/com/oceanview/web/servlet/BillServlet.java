package com.oceanview.web.servlet;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.DaoFactory;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.service.BillingService;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

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
            int reservationId = Integer.parseInt(req.getParameter("id"));

            double discountPercent = 0.0;
            try { discountPercent = Double.parseDouble(req.getParameter("discount")); } catch (Exception ignored) {}

            // extras (POOL, DINING, LAUNDRY)
            String[] extras = req.getParameterValues("extra");

            Reservation r = reservationService.getReservation(reservationId);
            if (r == null) {
                req.setAttribute("error", "Reservation not found.");
                req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);
                return;
            }

            // base room bill (discount applies only to room part)
            Bill baseBill = billingService.calculateBill(r, discountPercent);

            // extras total
            double extrasTotal = 0.0;
            Map<String, Double> servicePrices = DaoFactory.serviceDao().getActiveServicePricesByCodes(extras);
            for (String code : servicePrices.keySet()) {
                extrasTotal += servicePrices.get(code);
            }

            double grandTotal = baseBill.getTotal() + extrasTotal;

            // save bill row + get bill_id
            int billId = saveBillAndReturnId(baseBill, grandTotal);

            // save bill items (simple)
            saveBillItem(billId, "Room Stay (after discount)", 1, baseBill.getTotal(), baseBill.getTotal());
            if (extras != null) {
                for (String code : extras) {
                    Double price = servicePrices.get(code);
                    if (price != null) {
                        saveBillItem(billId, code, 1, price, price);
                    }
                }
            }

            // attributes for JSP
            req.setAttribute("bill", baseBill);
            req.setAttribute("reservation", r);
            req.setAttribute("extrasTotal", extrasTotal);
            req.setAttribute("grandTotal", grandTotal);

            req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "Please enter a valid reservation number.");
            req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);
        }
    }

    private int saveBillAndReturnId(Bill bill, double grandTotal) {
        String sql = "INSERT INTO bills(reservation_no,nights,rate,discount,total) VALUES(?,?,?,?,?)";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, bill.getReservationNo());
            ps.setInt(2, bill.getNights());
            ps.setDouble(3, bill.getRate());
            ps.setDouble(4, bill.getDiscount());
            ps.setDouble(5, grandTotal);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    private void saveBillItem(int billId, String itemName, int qty, double unitPrice, double total) {
        if (billId <= 0) return;

        String sql = "INSERT INTO bill_items(bill_id,item_name,qty,unit_price,total) VALUES(?,?,?,?,?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, billId);
            ps.setString(2, itemName);
            ps.setInt(3, qty);
            ps.setDouble(4, unitPrice);
            ps.setDouble(5, total);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
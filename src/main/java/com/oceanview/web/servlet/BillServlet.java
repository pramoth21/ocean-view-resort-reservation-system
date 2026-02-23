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
import java.sql.*;
import java.util.Map;

public class BillServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();
    private final BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/bill.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String idStr = req.getParameter("id");

            if (idStr == null || idStr.trim().isEmpty()) {
                req.setAttribute("error", "Reservation number is required.");
                req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);
                return;
            }

            int reservationId = Integer.parseInt(idStr.trim());

            Reservation r = reservationService.getReservation(reservationId);

            if (r == null) {
                req.setAttribute("error", "Reservation not found.");
                req.getRequestDispatcher("/WEB-INF/views/bill.jsp").forward(req, resp);
                return;
            }

            double discountPercent = 0.0;
            try {
                discountPercent =
                        Double.parseDouble(req.getParameter("discount"));
            } catch (Exception ignored) {}

            String[] extras = req.getParameterValues("extra");

            Bill baseBill =
                    billingService.calculateBill(r, discountPercent);

            Map<String, Double> servicePrices =
                    DaoFactory.serviceDao()
                            .getActiveServicePricesByCodes(extras);

            double extrasTotal = 0.0;
            for (double price : servicePrices.values())
                extrasTotal += price;

            double grandTotal =
                    baseBill.getTotal() + extrasTotal;

            int billId =
                    saveBillWithItems(baseBill, grandTotal,
                            extras, servicePrices);

            if (billId <= 0) {
                req.setAttribute("error",
                        "Failed to save bill. Check database.");
                req.getRequestDispatcher("/WEB-INF/views/bill.jsp")
                        .forward(req, resp);
                return;
            }

            req.setAttribute("bill", baseBill);
            req.setAttribute("reservation", r);
            req.setAttribute("extrasTotal", extrasTotal);
            req.setAttribute("grandTotal", grandTotal);

            req.getRequestDispatcher("/WEB-INF/views/bill.jsp")
                    .forward(req, resp);

        } catch (NumberFormatException e) {

            req.setAttribute("error",
                    "Reservation number must be numeric.");

            req.getRequestDispatcher("/WEB-INF/views/bill.jsp")
                    .forward(req, resp);

        } catch (RuntimeException e) {

            req.setAttribute("error", e.getMessage());

            req.getRequestDispatcher("/WEB-INF/views/bill.jsp")
                    .forward(req, resp);

        } catch (Exception e) {

            e.printStackTrace();

            req.setAttribute("error",
                    "Unexpected error. Check server console.");

            req.getRequestDispatcher("/WEB-INF/views/bill.jsp")
                    .forward(req, resp);
        }
    }

    private int saveBillWithItems(
            Bill bill,
            double grandTotal,
            String[] extras,
            Map<String, Double> servicePrices) {

        String billSql =
                "INSERT INTO bills(reservation_no,nights,rate,discount,total) VALUES(?,?,?,?,?)";

        String itemSql =
                "INSERT INTO bill_items(bill_id,item_name,qty,unit_price,total) VALUES(?,?,?,?,?)";

        try (Connection con =
                     DBConnection.getInstance().getConnection()) {

            con.setAutoCommit(false);

            int billId;

            try (PreparedStatement ps =
                         con.prepareStatement(billSql,
                                 Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, bill.getReservationNo());
                ps.setInt(2, bill.getNights());
                ps.setDouble(3, bill.getRate());
                ps.setDouble(4, bill.getDiscount());
                ps.setDouble(5, grandTotal);

                ps.executeUpdate();

                try (ResultSet rs =
                             ps.getGeneratedKeys()) {

                    if (!rs.next()) {
                        con.rollback();
                        return -1;
                    }

                    billId = rs.getInt(1);
                }
            }

            try (PreparedStatement ps =
                         con.prepareStatement(itemSql)) {

                ps.setInt(1, billId);
                ps.setString(2,
                        "Room Stay (after discount)");
                ps.setInt(3, 1);
                ps.setDouble(4, bill.getTotal());
                ps.setDouble(5, bill.getTotal());
                ps.executeUpdate();
            }

            if (extras != null) {
                for (String code : extras) {
                    Double price =
                            servicePrices.get(code);

                    if (price != null) {
                        try (PreparedStatement ps =
                                     con.prepareStatement(itemSql)) {

                            ps.setInt(1, billId);
                            ps.setString(2, code);
                            ps.setInt(3, 1);
                            ps.setDouble(4, price);
                            ps.setDouble(5, price);
                            ps.executeUpdate();
                        }
                    }
                }
            }

            con.commit();
            return billId;

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
}
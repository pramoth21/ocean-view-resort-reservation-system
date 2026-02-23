package com.oceanview.service;

import com.oceanview.config.DBConnection;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.util.DateUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BillingService {

    public Bill calculateBill(Reservation reservation, double discountPercent) {

        int nights = DateUtil.nightsBetween(
                reservation.getCheckIn(),
                reservation.getCheckOut()
        );

        if (nights <= 0) {
            throw new RuntimeException("Invalid check-in / check-out dates.");
        }

        double ratePerNight = findActiveRate(reservation.getRoomType());

        if (ratePerNight == 0.0) {
            throw new RuntimeException(
                    "No active room rate found for type: "
                            + reservation.getRoomType()
            );
        }

        if (discountPercent < 0) discountPercent = 0;
        if (discountPercent > 100) discountPercent = 100;

        double gross = nights * ratePerNight;
        double discount = gross * (discountPercent / 100.0);
        double total = gross - discount;

        return new Bill(
                reservation.getReservationNo(),
                nights,
                ratePerNight,
                discount,
                total
        );
    }

    private double findActiveRate(String typeCode) {

        String sql =
                "SELECT rr.price_per_night " +
                        "FROM room_rates2 rr " +
                        "JOIN room_types rt ON rr.room_type_id = rt.room_type_id " +
                        "WHERE rt.type_code = ? AND rr.is_active = 1 " +
                        "ORDER BY rr.created_at DESC LIMIT 1";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, typeCode);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("price_per_night");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }
}
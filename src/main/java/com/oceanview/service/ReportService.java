package com.oceanview.service;

import com.oceanview.config.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

/**
 * Handles revenue and reporting queries.
 */
public class ReportService {

    /**
     * Total revenue from all bills.
     */
    public double getTotalRevenueFromBills() {

        String sql = "SELECT COALESCE(SUM(total),0) AS revenue FROM bills";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("revenue");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }


    public double getRevenueForDate(LocalDate date) {

        String sql =
                "SELECT COALESCE(SUM(total),0) AS revenue " +
                        "FROM bills " +
                        "WHERE DATE(created_at)=?";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDate(1, java.sql.Date.valueOf(date));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("revenue");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }
}
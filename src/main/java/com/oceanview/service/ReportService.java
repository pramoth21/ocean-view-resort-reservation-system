package com.oceanview.service;

import com.oceanview.config.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportService {
    public double getTotalRevenueFromBills() {
        String sql = "SELECT COALESCE(SUM(total),0) AS revenue FROM bills";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble("revenue");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }
}

package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.RoomDao;
import com.oceanview.util.JsonUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

public class RoomDaoImpl implements RoomDao {

    @Override
    public String availableRoomsJson(String typeCode, LocalDate checkIn, LocalDate checkOut) {

        // overlap rule:
        // existing.check_in < new.check_out AND existing.check_out > new.check_in
        String sql =
                "SELECT rm.room_id, rm.room_no " +
                        "FROM rooms rm " +
                        "JOIN room_types rt ON rm.room_type_id=rt.room_type_id " +
                        "WHERE rm.is_active=1 AND rt.is_active=1 AND rt.type_code=? " +
                        "AND rm.room_id NOT IN ( " +
                        "  SELECT r.room_id FROM reservations r " +
                        "  WHERE r.status='ACTIVE' AND r.room_id IS NOT NULL " +
                        "    AND r.check_in < ? AND r.check_out > ? " +
                        ") " +
                        "ORDER BY rm.room_no";

        StringBuilder sb = new StringBuilder();
        sb.append("{\"ok\":true,\"rooms\":[");

        int count = 0;

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, typeCode);
            ps.setDate(2, java.sql.Date.valueOf(checkOut));
            ps.setDate(3, java.sql.Date.valueOf(checkIn));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (count > 0) sb.append(",");
                sb.append("{")
                        .append("\"roomId\":").append(rs.getInt("room_id")).append(",")
                        .append("\"roomNo\":\"").append(JsonUtil.escape(rs.getString("room_no"))).append("\"")
                        .append("}");
                count++;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"ok\":false,\"message\":\"DB error\"}";
        }

        sb.append("],\"count\":").append(count).append("}");
        return sb.toString();
    }
}
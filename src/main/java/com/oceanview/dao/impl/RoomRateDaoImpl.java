package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.RoomRateDao;
import com.oceanview.model.RoomRate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class RoomRateDaoImpl implements RoomRateDao {

    @Override
    public RoomRate getRoomRate(String roomType) {
        String sql = "SELECT room_type, price_per_night, image_path FROM room_rates WHERE room_type=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, roomType);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new RoomRate(
                        rs.getString("room_type"),
                        rs.getDouble("price_per_night"),
                        rs.getString("image_path")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

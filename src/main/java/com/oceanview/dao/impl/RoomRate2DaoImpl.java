package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.RoomRate2Dao;
import com.oceanview.model.RoomRate2;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomRate2DaoImpl implements RoomRate2Dao {

    @Override
    public List<RoomRate2> findAll() {
        List<RoomRate2> list = new ArrayList<>();
        String sql =
                "SELECT rr.rate_id, rr.room_type_id, rt.type_code, rr.price_per_night, rr.is_active " +
                        "FROM room_rates2 rr JOIN room_types rt ON rr.room_type_id=rt.room_type_id " +
                        "ORDER BY rr.rate_id DESC";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new RoomRate2(
                        rs.getInt("rate_id"),
                        rs.getInt("room_type_id"),
                        rs.getString("type_code"),
                        rs.getDouble("price_per_night"),
                        rs.getInt("is_active") == 1
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public boolean create(int roomTypeId, double price, boolean active) {
        String sql = "INSERT INTO room_rates2(room_type_id, price_per_night, is_active) VALUES(?,?,?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomTypeId);
            ps.setDouble(2, price);
            ps.setInt(3, active ? 1 : 0);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean update(int rateId, double price) {
        String sql = "UPDATE room_rates2 SET price_per_night=? WHERE rate_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDouble(1, price);
            ps.setInt(2, rateId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean setActive(int rateId, boolean active) {
        String sql = "UPDATE room_rates2 SET is_active=? WHERE rate_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, active ? 1 : 0);
            ps.setInt(2, rateId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.RoomAdminDao;
import com.oceanview.model.Room;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomAdminDaoImpl implements RoomAdminDao {

    @Override
    public List<Room> findAll() {
        List<Room> list = new ArrayList<>();
        String sql =
                "SELECT rm.room_id, rm.room_no, rm.room_type_id, rt.type_code, rm.is_active " +
                        "FROM rooms rm JOIN room_types rt ON rm.room_type_id=rt.room_type_id " +
                        "ORDER BY rm.room_id DESC";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Room(
                        rs.getInt("room_id"),
                        rs.getString("room_no"),
                        rs.getInt("room_type_id"),
                        rs.getString("type_code"),
                        rs.getInt("is_active") == 1
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public boolean create(String roomNo, int roomTypeId, boolean active) {
        String sql = "INSERT INTO rooms(room_no, room_type_id, is_active) VALUES(?,?,?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, roomNo);
            ps.setInt(2, roomTypeId);
            ps.setInt(3, active ? 1 : 0);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean setActive(int roomId, boolean active) {
        String sql = "UPDATE rooms SET is_active=? WHERE room_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, active ? 1 : 0);
            ps.setInt(2, roomId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.RoomTypeDao;
import com.oceanview.model.RoomType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDaoImpl implements RoomTypeDao {

    @Override
    public List<RoomType> findAll() {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT room_type_id, type_code, type_name, description, image_path, is_active FROM room_types ORDER BY room_type_id DESC";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new RoomType(
                        rs.getInt("room_type_id"),
                        rs.getString("type_code"),
                        rs.getString("type_name"),
                        rs.getString("description"),
                        rs.getString("image_path"),
                        rs.getInt("is_active") == 1
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public RoomType findById(int id) {
        String sql = "SELECT room_type_id, type_code, type_name, description, image_path, is_active FROM room_types WHERE room_type_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new RoomType(
                        rs.getInt("room_type_id"),
                        rs.getString("type_code"),
                        rs.getString("type_name"),
                        rs.getString("description"),
                        rs.getString("image_path"),
                        rs.getInt("is_active") == 1
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public boolean create(RoomType t) {
        String sql = "INSERT INTO room_types(type_code,type_name,description,image_path,is_active) VALUES(?,?,?,?,?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getTypeCode());
            ps.setString(2, t.getTypeName());
            ps.setString(3, t.getDescription());
            ps.setString(4, t.getImagePath());
            ps.setInt(5, t.isActive() ? 1 : 0);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean update(RoomType t) {
        String sql = "UPDATE room_types SET type_code=?, type_name=?, description=?, image_path=? WHERE room_type_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, t.getTypeCode());
            ps.setString(2, t.getTypeName());
            ps.setString(3, t.getDescription());
            ps.setString(4, t.getImagePath());
            ps.setInt(5, t.getRoomTypeId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean setActive(int id, boolean active) {
        String sql = "UPDATE room_types SET is_active=? WHERE room_type_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, active ? 1 : 0);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.GuestDao;
import com.oceanview.model.Guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GuestDaoImpl implements GuestDao {

    @Override
    public Guest findByContactNumber(String contactNumber) {

        String sql = "SELECT guest_id, name, address, contact_number " +
                "FROM guests WHERE contact_number = ?";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, contactNumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Guest(
                        rs.getInt("guest_id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("contact_number")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public int save(Guest guest) {
        String sql = "INSERT INTO guests(name, address, contact_number) VALUES(?,?,?)";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql,
                     PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, guest.getName());
            ps.setString(2, guest.getAddress());
            ps.setString(3, guest.getContactNumber());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }
}

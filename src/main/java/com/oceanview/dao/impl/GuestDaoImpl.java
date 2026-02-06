package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.GuestDao;
import com.oceanview.model.Guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GuestDaoImpl implements GuestDao {

    @Override
    public Guest findByContactNumber(String contactNumber) {
        String sql = "SELECT guest_id, name, address, contact_number FROM guests WHERE contact_number = ?";
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
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public int save(Guest guest) {
        String sql = "INSERT INTO guests(name, address, contact_number) VALUES(?,?,?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, guest.getName());
            ps.setString(2, guest.getAddress());
            ps.setString(3, guest.getContactNumber());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }

    @Override
    public Guest findById(int guestId) {
        String sql = "SELECT guest_id, name, address, contact_number FROM guests WHERE guest_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, guestId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Guest(
                        rs.getInt("guest_id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("contact_number")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public List<Guest> findByNameLike(String name) {
        List<Guest> list = new ArrayList<>();
        String sql = "SELECT guest_id, name, address, contact_number FROM guests WHERE name LIKE ? ORDER BY guest_id DESC";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Guest(
                        rs.getInt("guest_id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("contact_number")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public Guest findByReservationNo(int reservationNo) {
        String sql =
                "SELECT g.guest_id, g.name, g.address, g.contact_number " +
                        "FROM reservations r JOIN guests g ON r.guest_id=g.guest_id " +
                        "WHERE r.reservation_no=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reservationNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Guest(
                        rs.getInt("guest_id"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("contact_number")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}
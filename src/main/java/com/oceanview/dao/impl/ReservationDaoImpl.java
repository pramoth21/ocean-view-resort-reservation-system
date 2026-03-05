package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.ReservationDao;
import com.oceanview.model.Guest;
import com.oceanview.model.Reservation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDaoImpl implements ReservationDao {

    @Override
    public int insert(Reservation r) {

        String sql = "INSERT INTO reservations (guest_id, room_type, room_id, check_in, check_out, status) " +
                "VALUES (?, ?, ?, ?, ?, 'ACTIVE')";

        try (Connection con = DBConnection.getInstance().getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, r.getGuest().getGuestId());
            ps.setString(2, r.getRoomType());

            if (r.getRoomId() == null)
                ps.setNull(3, Types.INTEGER);
            else
                ps.setInt(3, r.getRoomId());

            ps.setDate(4, Date.valueOf(r.getCheckIn()));
            ps.setDate(5, Date.valueOf(r.getCheckOut()));

            int rows = ps.executeUpdate();

            if (rows > 0) {
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next())
                    return keys.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public Reservation findById(int reservationNo) {

        String sql = "SELECT r.reservation_no, r.room_type, r.room_id, r.check_in, r.check_out, r.status, " +
                "g.guest_id, g.name, g.address, g.contact_number " +
                "FROM reservations r " +
                "JOIN guests g ON r.guest_id = g.guest_id " +
                "WHERE r.reservation_no = ?";

        try (Connection con = DBConnection.getInstance().getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reservationNo);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return map(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean update(Reservation r) {

        String sql = "UPDATE reservations SET room_type=?, room_id=?, check_in=?, check_out=? " +
                "WHERE reservation_no=? AND status='ACTIVE'";

        try (Connection con = DBConnection.getInstance().getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getRoomType());

            if (r.getRoomId() == null)
                ps.setNull(2, Types.INTEGER);
            else
                ps.setInt(2, r.getRoomId());

            ps.setDate(3, Date.valueOf(r.getCheckIn()));
            ps.setDate(4, Date.valueOf(r.getCheckOut()));
            ps.setInt(5, r.getReservationNo());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean cancel(int reservationNo) {

        String sql = "UPDATE reservations SET status='CANCELLED' WHERE reservation_no=? AND status='ACTIVE'";

        try (Connection con = DBConnection.getInstance().getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reservationNo);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateStatus(int reservationNo, String status) {

        String sql = "UPDATE reservations SET status=? WHERE reservation_no=?";

        try (Connection con = DBConnection.getInstance().getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, reservationNo);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Reservation> findAllActive() {

        List<Reservation> list = new ArrayList<>();

        String sql = "SELECT r.reservation_no, r.room_type, r.room_id, r.check_in, r.check_out, r.status, " +
                "g.guest_id, g.name, g.address, g.contact_number " +
                "FROM reservations r " +
                "JOIN guests g ON r.guest_id = g.guest_id " +
                "WHERE r.status IN ('ACTIVE', 'COMPLETED', 'CANCELLED') " +
                "ORDER BY r.reservation_no DESC";

        try (Connection con = DBConnection.getInstance().getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Reservation map(ResultSet rs) throws SQLException {

        Guest guest = new Guest(
                rs.getInt("guest_id"),
                rs.getString("name"),
                rs.getString("address"),
                rs.getString("contact_number"));

        Reservation reservation = new Reservation();
        reservation.setReservationNo(rs.getInt("reservation_no"));
        reservation.setGuest(guest);
        reservation.setRoomType(rs.getString("room_type"));

        int rid = rs.getInt("room_id");
        if (rs.wasNull())
            reservation.setRoomId(null);
        else
            reservation.setRoomId(rid);

        reservation.setCheckIn(rs.getDate("check_in").toLocalDate());
        reservation.setCheckOut(rs.getDate("check_out").toLocalDate());
        reservation.setStatus(rs.getString("status"));

        return reservation;
    }
}
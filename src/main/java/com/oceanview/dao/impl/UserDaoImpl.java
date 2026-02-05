package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.UserDao;
import com.oceanview.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {

    @Override
    public User findByUsernameAndPassword(String username, String password) {

        String sql = "SELECT user_id, username, role FROM users " +
                "WHERE username=? AND password=?";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ================= ADMIN FEATURES =================

    @Override
    public boolean createReceptionist(String username, String hashedPassword) {

        String sql = "INSERT INTO users(username, password, role) " +
                "VALUES (?, ?, 'RECEPTIONIST')";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            return ps.executeUpdate() > 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            // Username already exists
            return false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> findAllReceptionists() {

        List<User> list = new ArrayList<>();

        String sql = "SELECT user_id, username, role " +
                "FROM users WHERE role='RECEPTIONIST'";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("role")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean deleteReceptionist(int userId) {

        String sql = "DELETE FROM users WHERE user_id=? AND role='RECEPTIONIST'";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
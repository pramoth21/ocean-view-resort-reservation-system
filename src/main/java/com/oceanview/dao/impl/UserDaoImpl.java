package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.UserDao;
import com.oceanview.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDaoImpl implements UserDao {

    @Override
    public User findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT user_id, username, role FROM users WHERE username=? AND password=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("user_id"),
                            rs.getString("username"),
                            rs.getString("role")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

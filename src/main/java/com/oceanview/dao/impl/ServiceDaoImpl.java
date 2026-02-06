package com.oceanview.dao.impl;

import com.oceanview.config.DBConnection;
import com.oceanview.dao.ServiceDao;
import com.oceanview.model.ServiceItem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class ServiceDaoImpl implements ServiceDao {

    @Override
    public Map<String, Double> getActiveServicePricesByCodes(String[] codes) {
        Map<String, Double> map = new HashMap<>();
        if (codes == null || codes.length == 0) return map;

        StringBuilder in = new StringBuilder();
        for (int i = 0; i < codes.length; i++) {
            if (i > 0) in.append(",");
            in.append("?");
        }

        String sql = "SELECT service_code, price FROM services WHERE is_active=1 AND service_code IN (" + in + ")";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (int i = 0; i < codes.length; i++) ps.setString(i + 1, codes[i]);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("service_code"), rs.getDouble("price"));
            }

        } catch (Exception e) { e.printStackTrace(); }

        return map;
    }

    @Override
    public List<ServiceItem> findAll() {
        List<ServiceItem> list = new ArrayList<>();
        String sql = "SELECT service_id, service_code, service_name, price, is_active FROM services ORDER BY service_id DESC";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ServiceItem(
                        rs.getInt("service_id"),
                        rs.getString("service_code"),
                        rs.getString("service_name"),
                        rs.getDouble("price"),
                        rs.getInt("is_active") == 1
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public boolean create(ServiceItem s) {
        String sql = "INSERT INTO services(service_code, service_name, price, is_active) VALUES(?,?,?,?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getServiceCode());
            ps.setString(2, s.getServiceName());
            ps.setDouble(3, s.getPrice());
            ps.setInt(4, s.isActive() ? 1 : 0);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean update(ServiceItem s) {
        String sql = "UPDATE services SET service_code=?, service_name=?, price=? WHERE service_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, s.getServiceCode());
            ps.setString(2, s.getServiceName());
            ps.setDouble(3, s.getPrice());
            ps.setInt(4, s.getServiceId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean setActive(int serviceId, boolean active) {
        String sql = "UPDATE services SET is_active=? WHERE service_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, active ? 1 : 0);
            ps.setInt(2, serviceId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
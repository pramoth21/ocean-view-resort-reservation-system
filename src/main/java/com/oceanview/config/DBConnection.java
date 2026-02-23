package com.oceanview.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static DBConnection instance;

    // 🔥 STATIC BLOCK — runs ONCE when class is loaded
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ MySQL JDBC Driver Loaded");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL JDBC Driver NOT FOUND");
            e.printStackTrace();
        }
    }

    private DBConnection() {}

    public static synchronized DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                DBConfig.JDBC_URL,
                DBConfig.JDBC_USER,
                DBConfig.JDBC_PASS
        );
    }

}

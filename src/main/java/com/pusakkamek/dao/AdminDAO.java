package com.pusakkamek.dao;

import com.pusakkamek.model.Admin;
import com.pusakkamek.util.DBConnection;
import java.sql.*;

public class AdminDAO {

    private Connection conn;

    public AdminDAO() {
        conn = DBConnection.getConnection();
    }

    public Admin login(String username, String password) {
        String sql = "SELECT * FROM admins WHERE username=? AND password=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setUsername(rs.getString("username"));
                return admin;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

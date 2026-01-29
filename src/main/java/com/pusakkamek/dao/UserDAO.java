package com.pusakkamek.dao;

import com.pusakkamek.model.User;
import java.sql.*;

public class UserDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/pusak_kamek";
    private String jdbcUsername = "root"; // change if needed
    private String jdbcPassword = "";     // change if needed

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Register new user
    public boolean register(User user) {
        String sql = "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getPassword()); // optional: hash password

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Login user
    public User login(String emailOrPhone, String password) {
        String sql = "SELECT * FROM users WHERE (email=? OR phone=?) AND password=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, emailOrPhone);
            stmt.setString(2, emailOrPhone);
            stmt.setString(3, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

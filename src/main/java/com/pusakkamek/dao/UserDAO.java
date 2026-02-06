package com.pusakkamek.dao;

import com.pusakkamek.model.User;
import java.sql.*;

public class UserDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/pusak_kamek";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_USER_SQL =
        "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)";

    private static final String LOGIN_USER_SQL =
        "SELECT * FROM users WHERE (email = ? OR phone = ?) AND password = ?";

    // ✅ NEW: update without password
    private static final String UPDATE_PROFILE_SQL =
        "UPDATE users SET name=?, email=?, phone=? WHERE id=?";

    // ✅ NEW: update with password
    private static final String UPDATE_PROFILE_WITH_PASSWORD_SQL =
        "UPDATE users SET name=?, email=?, phone=?, password=? WHERE id=?";

    // ✅ NEW: get by id (refresh session)
    private static final String GET_BY_ID_SQL =
        "SELECT * FROM users WHERE id=?";

    public UserDAO() {}

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Register new user
    public boolean registerUser(User user) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL)) {

            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setString(4, user.getPassword());

            int row = preparedStatement.executeUpdate();
            return row > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Login method
    public User login(String emailOrPhone, String password) {
        User user = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_USER_SQL)) {

            preparedStatement.setString(1, emailOrPhone);
            preparedStatement.setString(2, emailOrPhone);
            preparedStatement.setString(3, password);

            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setPassword(rs.getString("password"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // ✅ NEW: Update profile (name/email/phone only)
    public boolean updateProfile(User user) {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_PROFILE_SQL)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setInt(4, user.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ NEW: Update profile + password
    public boolean updateProfileWithPassword(User user) {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_PROFILE_WITH_PASSWORD_SQL)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setInt(5, user.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ NEW: Refresh user data by id
    public User getById(int id) {
        User user = null;

        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(GET_BY_ID_SQL)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setPassword(rs.getString("password"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }
}

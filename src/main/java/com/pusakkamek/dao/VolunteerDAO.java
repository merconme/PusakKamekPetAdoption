package com.pusakkamek.dao;

import com.pusakkamek.model.VolunteerApplication;
import com.pusakkamek.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VolunteerDAO {

    // ✅ Insert Volunteer Application
    public boolean insertApplication(VolunteerApplication v) throws SQLException {

        // ✅ prevent null for NOT NULL column
        String exp = v.getExperience();
        if (exp == null || exp.trim().isEmpty()) exp = "NO";

        String sql = "INSERT INTO volunteer_applications " +
                "(user_id, full_name, phone, email, address, role, availability, experience, reason, status) " +
                "VALUES (?,?,?,?,?,?,?,?,?, 'PENDING')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, v.getUserId());
            ps.setString(2, v.getFullName());
            ps.setString(3, v.getPhone());
            ps.setString(4, v.getEmail());
            ps.setString(5, v.getAddress());
            ps.setString(6, v.getRole());
            ps.setString(7, v.getAvailability());
            ps.setString(8, exp);
            ps.setString(9, v.getReason());

            return ps.executeUpdate() > 0;
        }
    }

    // ✅ Block duplicate pending application
    public boolean hasPending(int userId) throws SQLException {
        String sql = "SELECT 1 FROM volunteer_applications WHERE user_id=? AND status='PENDING' LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // ✅ Count active volunteers (APPROVED)
    public int countActiveVolunteers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM volunteer_applications WHERE status='APPROVED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ✅ User history
    public List<VolunteerApplication> getByUserId(int userId) throws SQLException {
        List<VolunteerApplication> list = new ArrayList<>();
        String sql = "SELECT * FROM volunteer_applications WHERE user_id=? ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(map(rs));
            }
        }
        return list;
    }

    // ✅ Admin list
    public List<VolunteerApplication> getAllForAdmin() throws SQLException {
        List<VolunteerApplication> list = new ArrayList<>();
        String sql = "SELECT * FROM volunteer_applications ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    // ✅ Admin update status (APPROVED / REJECTED / PENDING)
    public boolean updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE volunteer_applications SET status=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;
        }
    }

    private VolunteerApplication map(ResultSet rs) throws SQLException {
        VolunteerApplication v = new VolunteerApplication();
        v.setId(rs.getInt("id"));
        v.setUserId(rs.getInt("user_id"));
        v.setFullName(rs.getString("full_name"));
        v.setPhone(rs.getString("phone"));
        v.setEmail(rs.getString("email"));
        v.setAddress(rs.getString("address"));
        v.setRole(rs.getString("role"));
        v.setAvailability(rs.getString("availability"));
        v.setExperience(rs.getString("experience"));
        v.setReason(rs.getString("reason"));
        v.setStatus(rs.getString("status"));
        v.setCreatedAt(rs.getTimestamp("created_at"));
        return v;
    }
}

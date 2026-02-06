package com.pusakkamek.dao;

import com.pusakkamek.model.AdoptionApplication;
import com.pusakkamek.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdoptionDAO {

    private final Connection conn;

    public AdoptionDAO() throws SQLException {
        conn = DBConnection.getConnection();
    }

    // ✅ USER APPLY
    public boolean insertApplication(AdoptionApplication a) throws SQLException {

        String sql = "INSERT INTO adoption_applications " +
                "(pet_id, user_id, full_name, phone, email, address, reason, status) " +
                "VALUES (?,?,?,?,?,?,?, 'PENDING')";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, a.getPetId());
            ps.setInt(2, a.getUserId());
            ps.setString(3, a.getFullName());
            ps.setString(4, a.getPhone());
            ps.setString(5, a.getEmail());
            ps.setString(6, a.getAddress());
            ps.setString(7, a.getReason());
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ USER HISTORY (My Adoptions)
    public List<AdoptionApplication> getByUserId(int userId) throws SQLException {

        List<AdoptionApplication> list = new ArrayList<>();

        String sql =
                "SELECT a.*, p.name AS pet_name " +
                "FROM adoption_applications a " +
                "JOIN pets p ON a.pet_id = p.id " +
                "WHERE a.user_id = ? " +
                "ORDER BY a.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AdoptionApplication a = map(rs);
                    a.setPetName(rs.getString("pet_name"));
                    list.add(a);
                }
            }
        }
        return list;
    }

    // ✅ FIXED: Successful adoptions count
    public int countSuccessfulAdoptions() throws SQLException {
        String sql = "SELECT COUNT(*) FROM adoption_applications WHERE status='APPROVED'";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // ✅ ADMIN LIST
    public List<AdoptionApplication> getAllForAdmin() throws SQLException {

        List<AdoptionApplication> list = new ArrayList<>();

        String sql =
                "SELECT a.*, p.name AS pet_name " +
                "FROM adoption_applications a " +
                "JOIN pets p ON a.pet_id = p.id " +
                "ORDER BY a.created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdoptionApplication a = map(rs);
                a.setPetName(rs.getString("pet_name"));
                list.add(a);
            }
        }
        return list;
    }

    // ✅ ADMIN: update application status
    public boolean updateStatus(int applicationId, String status) throws SQLException {
        String sql = "UPDATE adoption_applications SET status=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, applicationId);
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ OPTIONAL: mark pet adopted
    public boolean markPetAdopted(int petId) throws SQLException {
        String sql = "UPDATE pets SET status='ADOPTED' WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, petId);
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ mapper
    private AdoptionApplication map(ResultSet rs) throws SQLException {
        AdoptionApplication a = new AdoptionApplication();
        a.setId(rs.getInt("id"));
        a.setPetId(rs.getInt("pet_id"));
        a.setUserId(rs.getInt("user_id"));
        a.setFullName(rs.getString("full_name"));
        a.setPhone(rs.getString("phone"));
        a.setEmail(rs.getString("email"));
        a.setAddress(rs.getString("address"));
        a.setReason(rs.getString("reason"));
        a.setStatus(rs.getString("status"));
        try { a.setCreatedAt(rs.getTimestamp("created_at")); } catch (Exception ignored) {}
        return a;
    }
}

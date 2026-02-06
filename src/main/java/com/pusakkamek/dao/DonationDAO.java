package com.pusakkamek.dao;

import com.pusakkamek.model.Donation;
import com.pusakkamek.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DonationDAO {

    // ✅ Insert donation (default PENDING)
    public boolean insertDonation(Donation d) throws SQLException {

        String sql = "INSERT INTO donations " +
                "(user_id, donor_name, donor_email, donor_phone, amount, method, bank, note, status) " +
                "VALUES (?,?,?,?,?,?,?,?, 'PAID')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (d.getUserId() == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, d.getUserId());
            }

            ps.setString(2, d.getDonorName());
            ps.setString(3, d.getDonorEmail());
            ps.setString(4, d.getDonorPhone());
            ps.setDouble(5, d.getAmount());
            ps.setString(6, d.getMethod()); // QR / FPX
            ps.setString(7, d.getBank());
            ps.setString(8, d.getNote());

            return ps.executeUpdate() > 0;
        }
    }

    // Get TOTAL  donations 
   public double getTotalPaidDonations() throws SQLException {
    String sql = "SELECT COALESCE(SUM(amount), 0) FROM donations WHERE status='PAID'";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        return rs.next() ? rs.getDouble(1) : 0.0;
    }
}


    // ✅ Admin: list all donations
    public List<Donation> getAllDonations() throws SQLException {
        List<Donation> list = new ArrayList<>();

        String sql = "SELECT * FROM donations ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Donation d = map(rs);
                list.add(d);
            }
        }
        return list;
    }

    // ✅ Admin: approve / reject donation
    public boolean updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE donations SET status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ✅ OPTIONAL: get one donation by id (useful)
    public Donation getDonationById(int id) throws SQLException {
        String sql = "SELECT * FROM donations WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return map(rs);
            }
        }
        return null;
    }

    // ✅ Map ResultSet → Donation model
    private Donation map(ResultSet rs) throws SQLException {
        Donation d = new Donation();
        d.setId(rs.getInt("id"));
        d.setUserId((Integer) rs.getObject("user_id"));
        d.setDonorName(rs.getString("donor_name"));
        d.setDonorEmail(rs.getString("donor_email"));
        d.setDonorPhone(rs.getString("donor_phone"));
        d.setAmount(rs.getDouble("amount"));
        d.setMethod(rs.getString("method"));
        d.setBank(rs.getString("bank"));
        d.setNote(rs.getString("note"));
        d.setStatus(rs.getString("status"));
        d.setCreatedAt(rs.getTimestamp("created_at"));
        return d;
    }
}

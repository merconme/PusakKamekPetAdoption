package com.pusakkamek.dao;

import com.pusakkamek.model.Donation;
import com.pusakkamek.util.DBConnection;

import java.sql.*;

public class DonationDAO {

    public void insert(Donation donation) {
        String sql = "INSERT INTO donation(donor_name, email, amount, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, donation.getDonorName());
            stmt.setString(2, donation.getEmail());
            stmt.setDouble(3, donation.getAmount());
            stmt.setString(4, donation.getMessage());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ResultSet getAllDonations() {
        String sql = "SELECT * FROM donation ORDER BY donated_at DESC";
        try {
            Connection conn = DBConnection.getConnection();
            Statement stmt = conn.createStatement();
            return stmt.executeQuery(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

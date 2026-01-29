/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.dao;

import com.pusakkamek.model.Adoption;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdoptionDAO {

    public List<Adoption> getAll() {
        List<Adoption> list = new ArrayList<>();
        String sql = "SELECT * FROM adoptions";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Adoption a = new Adoption();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("userId"));
                a.setPetId(rs.getInt("petId"));
                a.setStatus(rs.getString("status"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(Adoption a) {
        String sql = "INSERT INTO adoptions (userId, petId, status) VALUES (?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, a.getUserId());
            pstmt.setInt(2, a.getPetId());
            pstmt.setString(3, a.getStatus());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

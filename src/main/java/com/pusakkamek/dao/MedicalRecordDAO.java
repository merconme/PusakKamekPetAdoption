/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.dao;

import com.pusakkamek.model.MedicalRecord;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDAO {

    public List<MedicalRecord> getAll() {
        List<MedicalRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM medical_records";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                MedicalRecord m = new MedicalRecord();
                m.setId(rs.getInt("id"));
                m.setPetId(rs.getInt("petId"));
                m.setVaccine(rs.getString("vaccine"));
                m.setDate(rs.getString("date"));
                m.setStatus(rs.getString("status"));
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insert(MedicalRecord m) {
        String sql = "INSERT INTO medical_records (petId, vaccine, date, status) VALUES (?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, m.getPetId());
            pstmt.setString(2, m.getVaccine());
            pstmt.setString(3, m.getDate());
            pstmt.setString(4, m.getStatus());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

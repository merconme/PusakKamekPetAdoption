/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.dao;

import com.pusakkamek.model.Pet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetDAO {

    public List<Pet> getAllPets() throws SQLException {
        List<Pet> list = new ArrayList<>();
        String sql = "SELECT * FROM pet";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Pet p = new Pet();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setSpecies(rs.getString("species"));
                p.setBreed(rs.getString("breed"));
                p.setAge(rs.getString("age"));
                p.setVaccinationStatus(rs.getString("vaccination_status"));
                list.add(p);
            }
        }
        return list;
    }
}

package com.pusakkamek.dao;

import com.pusakkamek.model.Pet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetDAO {

    private Connection conn;

    public PetDAO() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Update with your DB credentials
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pusak_kamek?useSSL=false&serverTimezone=UTC",
                    "root",
                    ""); 
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException(e);
        }
    }

    // Get all pets
    public List<Pet> getAllPets() throws SQLException {
        List<Pet> list = new ArrayList<>();
        String sql = "SELECT * FROM pets";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Pet pet = new Pet(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("species"),
                        rs.getString("breed"),
                        rs.getInt("age"),
                        rs.getString("vaccination_status"),
                        rs.getString("condition"),
                        rs.getString("neutered"),
                        rs.getString("color"),
                        rs.getString("image_url")
                );
                list.add(pet);
            }
        }
        return list;
    }

    // Search pets by name, species, or breed
    public List<Pet> searchPets(String keyword) throws SQLException {
        List<Pet> list = new ArrayList<>();
        String sql = "SELECT * FROM pets WHERE name LIKE ? OR species LIKE ? OR breed LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String q = "%" + keyword + "%";
            ps.setString(1, q);
            ps.setString(2, q);
            ps.setString(3, q);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pet pet = new Pet(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("species"),
                            rs.getString("breed"),
                            rs.getInt("age"),
                            rs.getString("vaccination_status"),
                            rs.getString("condition"),
                            rs.getString("neutered"),
                            rs.getString("color"),
                            rs.getString("image_url")
                    );
                    list.add(pet);
                }
            }
        }
        return list;
    }

    // Insert new pet
    public void insertPet(Pet pet) throws SQLException {
        String sql = "INSERT INTO pets (name, species, breed, age, vaccination_status, `condition`, neutered, color, image_url) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pet.getName());
            ps.setString(2, pet.getSpecies());
            ps.setString(3, pet.getBreed());
            ps.setInt(4, pet.getAge());
            ps.setString(5, pet.getVaccinationStatus());
            ps.setString(6, pet.getCondition());
            ps.setString(7, pet.getNeutered());
            ps.setString(8, pet.getColor());
            ps.setString(9, pet.getImageUrl());
            ps.executeUpdate();
        }
    }
}

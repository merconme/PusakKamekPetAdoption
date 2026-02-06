package com.pusakkamek.dao;

import com.pusakkamek.model.Pet;
import com.pusakkamek.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetDAO {

    private Connection conn;

    public PetDAO() throws SQLException {
        conn = DBConnection.getConnection();
    }

    // ================= PET BROWSE =================

    public List<Pet> getAllPets() throws SQLException {
        List<Pet> pets = new ArrayList<>();
        String sql = "SELECT * FROM pets WHERE status='AVAILABLE' ORDER BY created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                pets.add(mapPet(rs));
            }
        }
        return pets;
    }

    public List<Pet> searchPets(String keyword) throws SQLException {
        List<Pet> pets = new ArrayList<>();

        String sql = "SELECT * FROM pets WHERE status='AVAILABLE' " +
                "AND (LOWER(name) LIKE ? OR LOWER(species) LIKE ? OR LOWER(breed) LIKE ?) " +
                "ORDER BY created_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String k = "%" + keyword.toLowerCase() + "%";
            ps.setString(1, k);
            ps.setString(2, k);
            ps.setString(3, k);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    pets.add(mapPet(rs));
                }
            }
        }
        return pets;
    }

    public Pet getPetById(int id) throws SQLException {
        String sql = "SELECT * FROM pets WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapPet(rs);
            }
        }
        return null;
    }

    // ✅ NEW: Latest available pets for HOME PAGE
    public List<Pet> getLatestAvailablePets(int limit) throws SQLException {
        List<Pet> pets = new ArrayList<>();

        String sql = "SELECT * FROM pets WHERE status='AVAILABLE' ORDER BY created_at DESC LIMIT ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    pets.add(mapPet(rs));
                }
            }
        }
        return pets;
    }

    // ================= ADMIN COUNTS =================

    public int countAvailablePets() throws SQLException {
        return count("SELECT COUNT(*) FROM pets WHERE status='AVAILABLE'");
    }

    public int countAdoptedPets() throws SQLException {
        return count("SELECT COUNT(*) FROM pets WHERE status='ADOPTED'");
    }

    public int countPendingApplications() throws SQLException {
        return count("SELECT COUNT(*) FROM adoption_applications WHERE status='PENDING'");
    }

    // ================= HELPERS =================

    private int count(String sql) throws SQLException {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private Pet mapPet(ResultSet rs) throws SQLException {
    Pet pet = new Pet();
    pet.setId(rs.getInt("id"));
    pet.setSpecies(rs.getString("species"));
    pet.setName(rs.getString("name"));
    pet.setBreed(rs.getString("breed"));
    pet.setAge(rs.getInt("age"));
    pet.setVaccinationStatus(rs.getString("vaccination_status"));
    pet.setCondition(rs.getString("pet_condition"));
    pet.setNeutered(rs.getString("neutered"));
    pet.setColor(rs.getString("color"));
    pet.setImageUrl(rs.getString("image_url"));
    pet.setStatus(rs.getString("status"));

    // ✅ ADD THIS (because you insert description already)
    pet.setDescription(rs.getString("description"));

    return pet;
}


    // ================= ADD PET (INSERT) =================
    public boolean insertPet(Pet pet) throws SQLException {

        String sql = "INSERT INTO pets (species, name, breed, age, vaccination_status, pet_condition, neutered, color, description, image_url, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pet.getSpecies());
            ps.setString(2, pet.getName());
            ps.setString(3, pet.getBreed());
            ps.setInt(4, pet.getAge());
            ps.setString(5, pet.getVaccinationStatus());
            ps.setString(6, pet.getCondition());
            ps.setString(7, pet.getNeutered());
            ps.setString(8, pet.getColor());
            ps.setString(9, pet.getDescription());
            ps.setString(10, pet.getImageUrl());
            ps.setString(11, pet.getStatus());
            
            return ps.executeUpdate() > 0;
        }
    }
    
    // ================= UPDATE PET =================
public boolean updatePet(Pet pet) throws SQLException {
    String sql = "UPDATE pets SET species=?, name=?, breed=?, age=?, vaccination_status=?, pet_condition=?, " +
                 "neutered=?, color=?, description=?, image_url=?, status=? WHERE id=?";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, pet.getSpecies());
        ps.setString(2, pet.getName());
        ps.setString(3, pet.getBreed());
        ps.setInt(4, pet.getAge());
        ps.setString(5, pet.getVaccinationStatus());
        ps.setString(6, pet.getCondition());
        ps.setString(7, pet.getNeutered());
        ps.setString(8, pet.getColor());
        ps.setString(9, pet.getDescription());
        ps.setString(10, pet.getImageUrl());
        ps.setString(11, pet.getStatus());
        ps.setInt(12, pet.getId());

        return ps.executeUpdate() > 0;
    }
}

// ================= DELETE PET =================
public boolean deletePet(int id) throws SQLException {
    String sql = "DELETE FROM pets WHERE id=?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }
}

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.dao;

import com.pusakkamek.model.Volunteer;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VolunteerDAO {
    private final String jdbcURL = "jdbc:mysql://localhost:3306/pusakkamekdb";
    private final String jdbcUsername = "root";
    private final String jdbcPassword = "password";

    private static final String INSERT_VOLUNTEER_SQL = 
        "INSERT INTO volunteers (name, email, age, role, availability) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_VOLUNTEERS = 
        "SELECT * FROM volunteers";
    
    public VolunteerDAO() {}

    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Add new volunteer
    public void addVolunteer(Volunteer volunteer) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_VOLUNTEER_SQL)) {
            preparedStatement.setString(1, volunteer.getName());
            preparedStatement.setString(2, volunteer.getEmail());
            preparedStatement.setInt(3, volunteer.getAge());
            preparedStatement.setString(4, volunteer.getRole());
            preparedStatement.setString(5, volunteer.getAvailability());
            preparedStatement.executeUpdate();
        }
    }

    // Get all volunteers
    public List<Volunteer> getAllVolunteers() throws SQLException {
        List<Volunteer> volunteers = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_VOLUNTEERS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                volunteers.add(new Volunteer(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getInt("age"),
                    rs.getString("role"),
                    rs.getString("availability")
                ));
            }
        }
        return volunteers;
    }
}


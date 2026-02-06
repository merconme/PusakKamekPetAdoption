package com.pusakkamek.dao;

import com.pusakkamek.model.Story;
import com.pusakkamek.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StoryDAO {

    public boolean insert(Story s) throws SQLException {
        String sql = "INSERT INTO stories (title, content, image_file) VALUES (?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, s.getTitle());
            ps.setString(2, s.getContent());

            if (s.getImageFile() == null || s.getImageFile().trim().isEmpty()) {
                ps.setNull(3, Types.VARCHAR);
            } else {
                ps.setString(3, s.getImageFile());
            }

            return ps.executeUpdate() > 0;
        }
    }

    public List<Story> getAll() throws SQLException {
        List<Story> list = new ArrayList<>();
        String sql = "SELECT * FROM stories ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(map(rs));
        }
        return list;
    }

    public boolean deleteById(int id) throws SQLException {
        String sql = "DELETE FROM stories WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    private Story map(ResultSet rs) throws SQLException {
        Story s = new Story();
        s.setId(rs.getInt("id"));
        s.setTitle(rs.getString("title"));
        s.setContent(rs.getString("content"));
        s.setImageFile(rs.getString("image_file"));
        s.setCreatedAt(rs.getTimestamp("created_at"));
        return s;
    }
}

package com.pusakkamek.controller;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Pet;
import com.pusakkamek.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;   // ✅ IMPORTANT
import java.util.List;

@WebServlet("/petbrowse")
public class PetServlet extends HttpServlet {

    private PetDAO dao;

    @Override
    public void init() throws ServletException {
        try {
            dao = new PetDAO(); // ✅ constructor throws SQLException
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize PetDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String searchQuery = request.getParameter("search");
        List<Pet> pets;

        try {
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                pets = dao.searchPets(searchQuery.trim());
            } else {
                pets = dao.getAllPets();
            }
        } catch (SQLException e) { // ✅ catch SQLException
            throw new ServletException("Error fetching pets from database", e);
        }

        request.setAttribute("pets", pets);
        request.getRequestDispatcher("/petbrowse.jsp").forward(request, response);
    }
}

package com.pusakkamek.controller;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Pet;
import com.pusakkamek.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/petbrowse")
public class PetServlet extends HttpServlet {

    private PetDAO dao;

    @Override
    public void init() throws ServletException {
        try {
            dao = new PetDAO();  // now wrapped in try-catch
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize PetDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure user is logged in
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String searchQuery = request.getParameter("search"); // get search parameter
        List<Pet> pets;

        try {
            if (searchQuery != null && !searchQuery.isEmpty()) {
                pets = dao.searchPets(searchQuery); // search by name/species/breed
            } else {
                pets = dao.getAllPets();
            }
        } catch (Exception e) {
            throw new ServletException("Error fetching pets from database", e);
        }

        request.setAttribute("pets", pets);
        request.setAttribute("currentUser", currentUser); // pass user to JSP
        request.getRequestDispatcher("petbrowse.jsp").forward(request, response);
    }
}

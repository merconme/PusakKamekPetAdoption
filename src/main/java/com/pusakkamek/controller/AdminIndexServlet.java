package com.pusakkamek.controller;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;   // ✅ IMPORTANT

@WebServlet("/admin/index")
public class AdminIndexServlet extends HttpServlet {

    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        try {
            petDAO = new PetDAO(); // ✅ constructor throws SQLException
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize PetDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("adminUser") : null;

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        try {
            int available = petDAO.countAvailablePets();
            int adopted = petDAO.countAdoptedPets();
            int pendingApps = petDAO.countPendingApplications();

            request.setAttribute("availablePets", available);
            request.setAttribute("adoptedPets", adopted);
            request.setAttribute("pendingApps", pendingApps);

            request.getRequestDispatcher("/admin-index.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error loading admin dashboard counts", e);
        }
    }
}

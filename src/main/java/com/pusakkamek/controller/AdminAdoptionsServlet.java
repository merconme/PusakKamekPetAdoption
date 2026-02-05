package com.pusakkamek.controller;

import com.pusakkamek.dao.AdoptionDAO;
import com.pusakkamek.model.Admin;
import com.pusakkamek.model.AdoptionApplication;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/adoptions")
public class AdminAdoptionsServlet extends HttpServlet {

    private AdoptionDAO adoptionDAO;

    @Override
    public void init() throws ServletException {
        try {
            adoptionDAO = new AdoptionDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to init AdoptionDAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();

        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("adminUser") : null;

        if (admin == null) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            // ✅ IMPORTANT: use getAllForAdmin()
            List<AdoptionApplication> list = adoptionDAO.getAllForAdmin();

            request.setAttribute("adoptionList", list);
            request.getRequestDispatcher("/admin-adoptions.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}

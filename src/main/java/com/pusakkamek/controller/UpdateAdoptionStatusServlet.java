package com.pusakkamek.controller;

import com.pusakkamek.dao.AdoptionDAO;
import com.pusakkamek.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/adoptions/update")
public class UpdateAdoptionStatusServlet extends HttpServlet {

    private AdoptionDAO adoptionDAO;

    @Override
    public void init() throws ServletException {
        try {
            adoptionDAO = new AdoptionDAO();
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();

        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("adminUser") : null;

        if (admin == null) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            int appId = Integer.parseInt(request.getParameter("appId"));
            int petId = Integer.parseInt(request.getParameter("petId"));
            String action = request.getParameter("action"); // APPROVE / REJECT

            if ("APPROVE".equalsIgnoreCase(action)) {
                adoptionDAO.updateStatus(appId, "APPROVED");
                adoptionDAO.markPetAdopted(petId); // optional but recommended
            } else if ("REJECT".equalsIgnoreCase(action)) {
                adoptionDAO.updateStatus(appId, "REJECTED");
            }

            response.sendRedirect(cp + "/admin/adoptions");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(cp + "/admin/adoptions?err=1");
        }
    }
}

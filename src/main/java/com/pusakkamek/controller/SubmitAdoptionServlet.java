package com.pusakkamek.controller;

import com.pusakkamek.dao.AdoptionDAO;
import com.pusakkamek.model.AdoptionApplication;
import com.pusakkamek.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/adopt/apply")
public class SubmitAdoptionServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(cp + "/login.jsp");
            return;
        }

        try {
            int petId = Integer.parseInt(request.getParameter("petId"));

            AdoptionApplication app = new AdoptionApplication();
            app.setPetId(petId);
            app.setUserId(user.getId());
            app.setFullName(request.getParameter("fullName"));
            app.setPhone(request.getParameter("phone"));
            app.setEmail(request.getParameter("email"));
            app.setAddress(request.getParameter("address"));
            app.setReason(request.getParameter("reason"));

            boolean ok = adoptionDAO.insertApplication(app);

            if (ok) {
                response.sendRedirect(cp + "/pet?id=" + petId + "&ok=1");
            } else {
                response.sendRedirect(cp + "/pet?id=" + petId + "&err=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(cp + "/petbrowse.jsp?err=1");
        }
    }
}

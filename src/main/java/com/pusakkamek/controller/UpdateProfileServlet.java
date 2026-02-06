package com.pusakkamek.controller;

import com.pusakkamek.dao.UserDAO;
import com.pusakkamek.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(cp + "/login.jsp");
            return;
        }

        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            String newPassword = request.getParameter("new_password");
            String confirmPassword = request.getParameter("confirm_password");

            // Validate required fields
            if (name == null || name.trim().isEmpty()) {
                session.setAttribute("profileError", "❌ Name cannot be empty.");
                response.sendRedirect(cp + "/profile.jsp");
                return;
            }
            if (email == null || email.trim().isEmpty()) {
                session.setAttribute("profileError", "❌ Email cannot be empty.");
                response.sendRedirect(cp + "/profile.jsp");
                return;
            }

            // Update current user object
            currentUser.setName(name.trim());
            currentUser.setEmail(email.trim());
            currentUser.setPhone(phone != null ? phone.trim() : null);

            UserDAO dao = new UserDAO();

            boolean ok;

            // If user wants to change password
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                if (confirmPassword == null || !newPassword.equals(confirmPassword)) {
                    session.setAttribute("profileError", "❌ Password confirmation does not match.");
                    response.sendRedirect(cp + "/profile.jsp");
                    return;
                }

                currentUser.setPassword(newPassword); // plain text for now
                ok = dao.updateProfileWithPassword(currentUser);
            } else {
                ok = dao.updateProfile(currentUser);
            }

            if (ok) {
                // refresh session user
                User refreshed = dao.getById(currentUser.getId());
                if (refreshed != null) session.setAttribute("currentUser", refreshed);

                session.setAttribute("profileSuccess", "✅ Profile updated successfully!");
            } else {
                session.setAttribute("profileError", "❌ Failed to update profile. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("profileError", "❌ System error. Please try again later.");
        }

        response.sendRedirect(cp + "/profile.jsp");
    }
}

package com.pusakkamek.controller;

import com.pusakkamek.dao.VolunteerDAO;
import com.pusakkamek.model.User;
import com.pusakkamek.model.VolunteerApplication;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/volunteer-apply")
public class VolunteerApplyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        // ✅ Login check
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(cp + "/login.jsp");
            return;
        }

        try {
            VolunteerDAO dao = new VolunteerDAO();

            // ✅ Block duplicate pending applications
            if (dao.hasPending(currentUser.getId())) {
                session.setAttribute("volunteerError",
                        "❌ You already have a pending volunteer application.");
                response.sendRedirect(cp + "/volunteer.jsp");
                return;
            }

            VolunteerApplication v = new VolunteerApplication();
            v.setUserId(currentUser.getId());
            v.setFullName(request.getParameter("full_name"));
            v.setPhone(request.getParameter("phone"));
            v.setEmail(request.getParameter("email"));
            v.setAddress(request.getParameter("address"));
            v.setRole(request.getParameter("role"));
            v.setAvailability(request.getParameter("availability"));

            // ✅ Prevent NULL for NOT NULL column experience
            String exp = request.getParameter("experience");
            if (exp == null || exp.trim().isEmpty()) exp = "NO";
            v.setExperience(exp);

            v.setReason(request.getParameter("reason"));

            // ✅ CORRECT METHOD NAME (matches DAO)
            if (dao.insertApplication(v)) {
                session.setAttribute("volunteerSuccess",
                        "✅ Your volunteer application has been submitted successfully!");
            } else {
                session.setAttribute("volunteerError",
                        "❌ Failed to submit application. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("volunteerError",
                    "❌ System error: " + e.getMessage());
        }

        response.sendRedirect(cp + "/volunteer.jsp");
    }
}

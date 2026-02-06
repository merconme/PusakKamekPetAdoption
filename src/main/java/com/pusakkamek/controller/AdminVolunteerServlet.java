package com.pusakkamek.controller;

import com.pusakkamek.dao.VolunteerDAO;
import com.pusakkamek.model.VolunteerApplication;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/volunteers")
public class AdminVolunteerServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session){
        return session.getAttribute("adminUser") != null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        if (!isAdmin(session)) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            VolunteerDAO dao = new VolunteerDAO();

            // ✅ FIX: correct DAO method name
            List<VolunteerApplication> list = dao.getAllForAdmin();

            request.setAttribute("volunteers", list);

        } catch (Exception e){
            e.printStackTrace();
            request.setAttribute("error", "❌ Failed to load volunteer applications: " + e.getMessage());
        }

        request.getRequestDispatcher("/admin-volunteers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        if (!isAdmin(session)) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status"); // APPROVED / REJECTED / PENDING

            VolunteerDAO dao = new VolunteerDAO();
            boolean ok = dao.updateStatus(id, status);

            session.setAttribute("adminVolunteerMsg",
                    ok ? "✅ Updated volunteer status!" : "❌ Failed to update status.");

        } catch (Exception e){
            e.printStackTrace();
            session.setAttribute("adminVolunteerMsg", "❌ System error updating volunteer status: " + e.getMessage());
        }

        response.sendRedirect(cp + "/admin/volunteers");
    }
}

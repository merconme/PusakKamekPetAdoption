package com.pusakkamek.controller;

import com.pusakkamek.dao.StoryDAO;
import com.pusakkamek.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/stories/delete")
public class AdminStoryDeleteServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session) {
        return session.getAttribute("adminUser") != null;
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
            StoryDAO dao = new StoryDAO();
            boolean ok = dao.deleteById(id);
            session.setAttribute("adminStoryMsg", ok ? "✅ Story deleted!" : "❌ Failed to delete story.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("adminStoryMsg", "❌ Delete error: " + e.toString());
        }

        response.sendRedirect(cp + "/admin/stories");
    }
}

package com.pusakkamek.controller;

import com.pusakkamek.dao.AdminDAO;
import com.pusakkamek.model.Admin;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    private AdminDAO dao;

    @Override
    public void init() {
        dao = new AdminDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = dao.login(username, password);

        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", admin);

            // ✅ CORRECT REDIRECT
            response.sendRedirect(request.getContextPath() + "admin-index.jsp");

        } else {
            request.setAttribute("error", "Invalid admin credentials");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}

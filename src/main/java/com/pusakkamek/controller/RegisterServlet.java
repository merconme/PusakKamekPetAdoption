package com.pusakkamek.controller;

import com.pusakkamek.dao.UserDAO;
import com.pusakkamek.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        User user = new User();
        user.setFullname(request.getParameter("fullname"));
        user.setUsername(request.getParameter("username"));
        user.setPhone(request.getParameter("phone"));
        user.setPassword(request.getParameter("password"));

        userDAO.insert(user);
        response.sendRedirect("login.jsp");
    }
}

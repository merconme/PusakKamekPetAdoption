package com.pusakkamek.controller;

import com.pusakkamek.dao.UserDAO;
import com.pusakkamek.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String emailOrPhone = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.login(emailOrPhone, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            // redirect to index.jsp
            session.setAttribute("loginSuccess", "Login successful. Welcome back, " + user.getName() + "!");
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
            
            
        } else {
            request.setAttribute("error", "Invalid email/phone or password!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}

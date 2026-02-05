package com.pusakkamek.controller;

import com.pusakkamek.dao.AdoptionDAO;
import com.pusakkamek.model.AdoptionApplication;
import com.pusakkamek.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/my-adoptions")
public class MyAdoptionServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(cp + "/login.jsp");
            return;
        }

        try {
            List<AdoptionApplication> list = adoptionDAO.getByUserId(user.getId());
            request.setAttribute("applications", list);
            request.getRequestDispatcher("/my-adoptions.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}

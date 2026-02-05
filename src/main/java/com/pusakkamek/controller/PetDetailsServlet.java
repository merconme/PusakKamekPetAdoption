package com.pusakkamek.controller;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Pet;
import com.pusakkamek.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/pet")
public class PetDetailsServlet extends HttpServlet {

    private PetDAO petDAO;

    @Override
    public void init() throws ServletException {
        try {
            petDAO = new PetDAO();
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect(request.getContextPath() + "/petbrowse.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Pet pet = petDAO.getPetById(id);

            if (pet == null) {
                response.sendRedirect(request.getContextPath() + "/petbrowse.jsp");
                return;
            }

            request.setAttribute("pet", pet);
            request.getRequestDispatcher("/adopt-application.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

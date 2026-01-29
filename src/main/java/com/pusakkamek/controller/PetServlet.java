/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.controller;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Pet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/petbrowse")
public class PetServlet extends HttpServlet {
    private PetDAO dao;

    public void init() {
        dao = new PetDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Pet> list = dao.getAllPets();
            request.setAttribute("pets", list);
            request.getRequestDispatcher("petbrowse.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}


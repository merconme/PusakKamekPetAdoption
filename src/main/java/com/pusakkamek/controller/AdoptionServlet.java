/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.controller;

import com.pusakkamek.dao.AdoptionDAO;
import com.pusakkamek.model.Adoption;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdoptionServlet", value = "/AdoptionServlet")
public class AdoptionServlet extends HttpServlet {
    private AdoptionDAO adoptionDAO;

    @Override
    public void init() {
        adoptionDAO = new AdoptionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Adoption> list = adoptionDAO.getAll();
        request.setAttribute("adoptionList", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("adopt.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Adoption adoption = new Adoption();
        adoption.setUserId(Integer.parseInt(request.getParameter("userId")));
        adoption.setPetId(Integer.parseInt(request.getParameter("petId")));
        adoption.setStatus("Pending");

        adoptionDAO.insert(adoption);
        response.sendRedirect("AdoptionServlet");
    }
}


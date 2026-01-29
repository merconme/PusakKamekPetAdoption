/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.controller;

import com.pusakkamek.dao.VolunteerDAO;
import com.pusakkamek.model.Volunteer;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/volunteer-apply")
public class VolunteerApplicationServlet extends HttpServlet {
    private VolunteerDAO dao;

    public void init() {
        dao = new VolunteerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("volunteer-application.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));
        String role = request.getParameter("role");
        String availability = request.getParameter("availability");

        Volunteer v = new Volunteer();
        v.setName(name);
        v.setEmail(email);
        v.setAge(age);
        v.setRole(role);
        v.setAvailability(availability);

        try {
            dao.addVolunteer(v);
            request.setAttribute("message", "Application submitted successfully!");
            request.getRequestDispatcher("volunteer-application.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error submitting application!");
            request.getRequestDispatcher("volunteer-application.jsp").forward(request, response);
        }
    }
}


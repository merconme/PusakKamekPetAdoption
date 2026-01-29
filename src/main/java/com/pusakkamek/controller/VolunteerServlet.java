/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.pusakkamek.controller;

import com.pusakkamek.dao.VolunteerDAO;
import com.pusakkamek.model.Volunteer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/volunteers")
public class VolunteerServlet extends HttpServlet {
    private VolunteerDAO volunteerDAO;

    public void init() {
        volunteerDAO = new VolunteerDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        listVolunteers(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check action parameter to decide
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            try {
                addVolunteer(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void listVolunteers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Volunteer> listVolunteers = volunteerDAO.getAllVolunteers();
            request.setAttribute("listVolunteers", listVolunteers);
            request.getRequestDispatcher("volunteer-list.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void addVolunteer(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int age = Integer.parseInt(request.getParameter("age"));
        String role = request.getParameter("role");
        String availability = request.getParameter("availability");

        Volunteer newVolunteer = new Volunteer();
        newVolunteer.setName(name);
        newVolunteer.setEmail(email);
        newVolunteer.setAge(age);
        newVolunteer.setRole(role);
        newVolunteer.setAvailability(availability);

        volunteerDAO.addVolunteer(newVolunteer);
        response.sendRedirect("volunteers"); // refresh the list after adding
    }
}


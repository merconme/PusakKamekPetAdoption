package com.pusakkamek.controller;

import com.pusakkamek.dao.DonationDAO;
import com.pusakkamek.model.Admin;
import com.pusakkamek.model.Donation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/donations")
public class AdminDonationsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        Admin admin = (Admin) session.getAttribute("adminUser");
        if (admin == null) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            DonationDAO dao = new DonationDAO();
            List<Donation> donations = dao.getAllDonations();
            request.setAttribute("donations", donations);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("donations", java.util.Collections.emptyList());
            request.setAttribute("donationErr", "Failed to load donations.");
        }

        request.getRequestDispatcher("/admin-donations.jsp").forward(request, response);
    }
}

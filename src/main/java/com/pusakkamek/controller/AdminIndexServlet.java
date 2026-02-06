package com.pusakkamek.controller;

import com.pusakkamek.dao.DonationDAO;
import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/index")
public class AdminIndexServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        // ✅ Admin guard
        Admin admin = (Admin) session.getAttribute("adminUser");
        if (admin == null) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            PetDAO petDAO = new PetDAO();
            DonationDAO donationDAO = new DonationDAO();

            int availablePets = petDAO.countAvailablePets();
            int adoptedPets   = petDAO.countAdoptedPets();

            // ✅ You already have this in PetDAO
            int pendingApps   = petDAO.countPendingApplications();

            // ✅ Change your DonationDAO method to PAID
            double donationTotal = donationDAO.getTotalPaidDonations();

            request.setAttribute("availablePets", availablePets);
            request.setAttribute("adoptedPets", adoptedPets);
            request.setAttribute("pendingApps", pendingApps);
            request.setAttribute("donationTotal", donationTotal);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("availablePets", 0);
            request.setAttribute("adoptedPets", 0);
            request.setAttribute("pendingApps", 0);
            request.setAttribute("donationTotal", 0.0);
        }

        request.getRequestDispatcher("/admin-index.jsp").forward(request, response);
    }
}

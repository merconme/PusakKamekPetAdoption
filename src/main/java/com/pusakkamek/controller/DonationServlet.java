package com.pusakkamek.controller;

import com.pusakkamek.dao.DonationDAO;
import com.pusakkamek.model.Donation;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DonationServlet", value = "/DonationServlet")
public class DonationServlet extends HttpServlet {

    private DonationDAO donationDAO;

    @Override
    public void init() {
        donationDAO = new DonationDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Donation donation = new Donation();
        donation.setDonorName(request.getParameter("donorName"));
        donation.setEmail(request.getParameter("email"));
        donation.setAmount(Double.parseDouble(request.getParameter("amount")));
        donation.setMessage(request.getParameter("message"));

        donationDAO.insert(donation);
        request.setAttribute("success", "Thank you for your donation!");
        request.getRequestDispatcher("donation.jsp").forward(request, response);
    }
}

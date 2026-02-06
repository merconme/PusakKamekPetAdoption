package com.pusakkamek.controller;

import com.pusakkamek.dao.DonationDAO;
import com.pusakkamek.model.Donation;
import com.pusakkamek.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/donate")
public class DonationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        // If you want donation to require login, keep this.
        // If you want allow public donation, remove this login check.
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(cp + "/login.jsp");
            return;
        }

        try {
            String donorName = request.getParameter("donor_name");
            String donorEmail = request.getParameter("donor_email");
            String donorPhone = request.getParameter("donor_phone");

            String method = request.getParameter("method"); // QR / FPX
            String bank = request.getParameter("bank");
            String note = request.getParameter("note");

            String amountStr = request.getParameter("amount");
            if (amountStr == null || amountStr.trim().isEmpty()) {
                amountStr = "0";
            }

            double amount = Double.parseDouble(amountStr);

            // ✅ validate
            if (donorName == null || donorName.trim().isEmpty()) {
                session.setAttribute("donationError", "❌ Please enter your name.");
                response.sendRedirect(cp + "/donation.jsp");
                return;
            }
            if (amount <= 0) {
                session.setAttribute("donationError", "❌ Donation amount must be more than RM0.");
                response.sendRedirect(cp + "/donation.jsp");
                return;
            }
            if (amount > 100000) {
                session.setAttribute("donationError", "❌ Amount too large.");
                response.sendRedirect(cp + "/donation.jsp");
                return;
            }

            if (method == null || (!method.equals("QR") && !method.equals("FPX"))) {
                method = "QR";
            }

            if (method.equals("FPX") && (bank == null || bank.trim().isEmpty())) {
                session.setAttribute("donationError", "❌ Please select a bank for FPX.");
                response.sendRedirect(cp + "/donation.jsp");
                return;
            }

            Donation d = new Donation();
            d.setUserId(currentUser.getId());
            d.setDonorName(donorName.trim());
            d.setDonorEmail(donorEmail != null ? donorEmail.trim() : null);
            d.setDonorPhone(donorPhone != null ? donorPhone.trim() : null);
            d.setAmount(amount);
            d.setMethod(method);
            d.setBank(method.equals("FPX") ? bank : null);
            d.setNote(note != null ? note.trim() : null);

            DonationDAO dao = new DonationDAO();
            boolean ok = dao.insertDonation(d);

            if (ok) {
                session.setAttribute("donationSuccess",
                        "✅ Thank you! Your donation request has been recorded. Please proceed with payment (" + method + ").");
            } else {
                session.setAttribute("donationError", "❌ Failed to record donation. Please try again.");
            }

        } catch (NumberFormatException nfe) {
            session.setAttribute("donationError", "❌ Invalid amount. Please enter a number like 5 or 10.");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("donationError", "❌ System error. Please try again later.");
        }

        response.sendRedirect(cp + "/donation.jsp");
    }
}

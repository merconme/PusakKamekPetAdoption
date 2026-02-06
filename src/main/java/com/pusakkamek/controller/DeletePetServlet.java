package com.pusakkamek.servlet;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/DeletePetServlet")
public class DeletePetServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();

        // ✅ Admin guard
        Admin admin = (Admin) request.getSession().getAttribute("adminUser");
        if (admin == null) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            PetDAO dao = new PetDAO();
            boolean ok = dao.deletePet(id);

            response.sendRedirect(cp + "/add-petbrowse.jsp?" + (ok ? "ok=deleted" : "err=delete"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(cp + "/add-petbrowse.jsp?err=delete");
        }
    }
}

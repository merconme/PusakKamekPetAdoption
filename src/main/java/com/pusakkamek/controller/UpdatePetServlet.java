package com.pusakkamek.servlet;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Admin;
import com.pusakkamek.model.Pet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/UpdatePetServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
public class UpdatePetServlet extends HttpServlet {

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

            // old image (hidden field)
            String oldImageUrl = request.getParameter("oldImageUrl");

            Pet pet = new Pet();
            pet.setId(id);
            pet.setSpecies(request.getParameter("species"));
            pet.setName(request.getParameter("name"));
            pet.setAge(Integer.parseInt(request.getParameter("age")));
            pet.setBreed(request.getParameter("breed"));
            pet.setVaccinationStatus(request.getParameter("vaccinationStatus"));
            pet.setCondition(request.getParameter("condition"));
            pet.setNeutered(request.getParameter("neutered"));
            pet.setColor(request.getParameter("color"));
            pet.setDescription(request.getParameter("description"));
            pet.setStatus(request.getParameter("status"));

            // ✅ optional new image upload
            Part imagePart = request.getPart("image");
            String finalImageUrl = oldImageUrl;

            if (imagePart != null && imagePart.getSize() > 0) {
                String submitted = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String newFileName = System.currentTimeMillis() + "_" + submitted;

                // save to webapp/images (same style you use now)
                String uploadPath = getServletContext().getRealPath("/images");
                File dir = new File(uploadPath);
                if (!dir.exists()) dir.mkdirs();

                imagePart.write(uploadPath + File.separator + newFileName);
                finalImageUrl = newFileName;
            }

            pet.setImageUrl(finalImageUrl);

            PetDAO dao = new PetDAO();
            boolean ok = dao.updatePet(pet);

            response.sendRedirect(cp + "/add-petbrowse.jsp?" + (ok ? "ok=updated" : "err=update"));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(cp + "/add-petbrowse.jsp?err=update");
        }
    }
}

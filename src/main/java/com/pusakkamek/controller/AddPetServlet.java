package com.pusakkamek.controller;

import com.pusakkamek.dao.PetDAO;
import com.pusakkamek.model.Admin;
import com.pusakkamek.model.Pet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet("/AddPetServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,      // 1MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 20     // 20MB
)
public class AddPetServlet extends HttpServlet {

    private PetDAO petDAO;

    // ✅ Permanent upload folder (outside GlassFish deploy)
    private static final String UPLOAD_DIR =
            System.getProperty("user.home") + File.separator + "PusakKamekUploads";

    @Override
    public void init() throws ServletException {
        try {
            petDAO = new PetDAO();
        } catch (SQLException e) {
            throw new ServletException("Failed to initialize PetDAO", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();

        // ✅ Admin session check
        HttpSession session = request.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("adminUser") : null;

        if (admin == null) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            // ===== Read form inputs =====
            String species = request.getParameter("species");
            String name = request.getParameter("name");
            String breed = request.getParameter("breed");
            String vaccinationStatus = request.getParameter("vaccinationStatus");
            String condition = request.getParameter("condition");
            String neutered = request.getParameter("neutered");
            String color = request.getParameter("color");

            if (species == null || species.isBlank() || name == null || name.isBlank()) {
                response.sendRedirect(cp + "/add-petbrowse.jsp?err=1");
                return;
            }

            int age = 0;
            String ageStr = request.getParameter("age");
            if (ageStr != null && !ageStr.isBlank()) {
                age = Integer.parseInt(ageStr.trim());
            }

            // ===== File upload =====
            Part imagePart = request.getPart("image");
            if (imagePart == null || imagePart.getSize() == 0) {
                response.sendRedirect(cp + "/add-petbrowse.jsp?err=1");
                return;
            }

            // ===== Ensure upload folder exists =====
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            // ===== Generate safe filename =====
            String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            String ext = "";
            int dot = originalFileName.lastIndexOf('.');
            if (dot > -1) ext = originalFileName.substring(dot);

            String savedFileName = UUID.randomUUID().toString().replace("-", "") + ext;
            File savedFile = new File(uploadDir, savedFileName);

            // ===== GlassFish-safe file write (IMPORTANT FIX) =====
            try (InputStream in = imagePart.getInputStream();
                 FileOutputStream out = new FileOutputStream(savedFile)) {

                byte[] buffer = new byte[8192];
                int len;
                while ((len = in.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }
            }

            // ===== Save to DB =====
            Pet pet = new Pet();
            pet.setSpecies(species.trim());
            pet.setName(name.trim());
            pet.setBreed(breed);
            pet.setAge(age);
            pet.setVaccinationStatus(vaccinationStatus);
            pet.setCondition(condition);
            pet.setNeutered(neutered);
            pet.setColor(color);
            pet.setImageUrl(savedFileName); // filename only
            pet.setStatus("AVAILABLE");

            boolean ok = petDAO.insertPet(pet);

            if (ok) {
                response.sendRedirect(cp + "/add-petbrowse.jsp?ok=1");
            } else {
                response.sendRedirect(cp + "/add-petbrowse.jsp?err=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().println("ERROR CLASS: " + e.getClass().getName());
            response.getWriter().println("MESSAGE: " + e.getMessage());
        }
    }
}

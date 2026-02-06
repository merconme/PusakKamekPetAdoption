package com.pusakkamek.controller;

import com.pusakkamek.dao.StoryDAO;
import com.pusakkamek.model.Admin;
import com.pusakkamek.model.Story;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/admin/stories")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class AdminStoryServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session) {
        return session.getAttribute("adminUser") != null;
    }

    private File getStoryUploadDir() {
        return new File(System.getProperty("user.home")
                + File.separator + "pusakkamek_uploads"
                + File.separator + "stories");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        if (!isAdmin(session)) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            StoryDAO dao = new StoryDAO();
            List<Story> stories = dao.getAll();
            request.setAttribute("stories", stories);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Failed to load stories.");
        }

        request.getRequestDispatcher("/admin-stories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cp = request.getContextPath();
        HttpSession session = request.getSession();

        if (!isAdmin(session)) {
            response.sendRedirect(cp + "/admin-login.jsp");
            return;
        }

        try {
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
                session.setAttribute("adminStoryMsg", "❌ Title and Content are required.");
                response.sendRedirect(cp + "/admin/stories");
                return;
            }

            // ✅ Optional image upload
            String imageFile = null;
            Part imagePart = request.getPart("image");

            if (imagePart != null && imagePart.getSize() > 0) {
                String original = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String safeName = System.currentTimeMillis() + "_" +
                        original.replaceAll("[^a-zA-Z0-9._-]", "_");

                File dir = getStoryUploadDir();
                if (!dir.exists()) dir.mkdirs();

                File outFile = new File(dir, safeName);

                try (InputStream in = imagePart.getInputStream();
                     OutputStream out = new FileOutputStream(outFile)) {
                    byte[] buf = new byte[8192];
                    int len;
                    while ((len = in.read(buf)) != -1) out.write(buf, 0, len);
                }

                imageFile = safeName; // store only filename
            }

            Story s = new Story();
            s.setTitle(title.trim());
            s.setContent(content.trim());
            s.setImageFile(imageFile);

            StoryDAO dao = new StoryDAO();
            boolean ok = dao.insert(s);

            session.setAttribute("adminStoryMsg", ok ? "✅ Story published!" : "❌ Failed to publish story.");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("adminStoryMsg", "❌ System error adding story: " + e.toString());
        }

        response.sendRedirect(cp + "/admin/stories");
    }
}

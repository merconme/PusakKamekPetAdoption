package com.pusakkamek.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/story-image")
public class StoryImageServlet extends HttpServlet {

    private File getStoryUploadDir() {
        return new File(System.getProperty("user.home")
                + File.separator + "pusakkamek_uploads"
                + File.separator + "stories");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String file = request.getParameter("file");
        if (file == null || file.trim().isEmpty() || file.contains("..") || file.contains("/") || file.contains("\\")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        File img = new File(getStoryUploadDir(), file);
        if (!img.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mime = getServletContext().getMimeType(img.getName());
        response.setContentType(mime != null ? mime : "application/octet-stream");
        response.setContentLengthLong(img.length());

        try (InputStream in = new FileInputStream(img);
             OutputStream out = response.getOutputStream()) {

            byte[] buf = new byte[8192];
            int len;
            while ((len = in.read(buf)) != -1) out.write(buf, 0, len);
        }
    }
}

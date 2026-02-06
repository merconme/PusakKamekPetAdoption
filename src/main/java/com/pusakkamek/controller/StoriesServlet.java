package com.pusakkamek.controller;

import com.pusakkamek.dao.StoryDAO;
import com.pusakkamek.model.Story;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/stories")
public class StoriesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            StoryDAO dao = new StoryDAO();
            List<Story> stories = dao.getAll();
            request.setAttribute("stories", stories);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load stories.");
            request.setAttribute("stories", java.util.Collections.emptyList());
        }

        request.getRequestDispatcher("/stories.jsp").forward(request, response);
    }
}

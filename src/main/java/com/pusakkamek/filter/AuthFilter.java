package com.pusakkamek.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {
    "/adopt.jsp",
    "/adopt-application.jsp",
    "/adoption-history.jsp",
    "/petbrowse.jsp",
    "/pet-checkin.jsp",
    "/pet-lost.jsp",
    "/volunteer.jsp",
    "/volunteer-application.jsp",
    "/volunteer-details.jsp",
    "/donation.jsp",
    "/profile.jsp",
    "/edit_profile.jsp",
    "/upload-stories.jsp"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            // User not logged in → redirect to login
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // User logged in → allow access
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {}
    @Override
    public void destroy() {}
}

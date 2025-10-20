package com.example.telemedicalexpertise.filter;

import com.example.telemedicalexpertise.utils.CSRFUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter(filterName = "CSRFFilter", urlPatterns = {"/*"})
public class CSRFFilter implements Filter {

    private static final List<String> EXCLUDED_PATHS = Arrays.asList(
        "/login", "/register", "/logout", "/assets/", "/css/", "/js/", "/images/"
    );

    private static final List<String> PROTECTED_METHODS = Arrays.asList(
        "POST", "PUT", "DELETE", "PATCH"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String method = httpRequest.getMethod();
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        boolean isExcluded = EXCLUDED_PATHS.stream().anyMatch(path::startsWith);
        boolean requiresProtection = PROTECTED_METHODS.contains(method.toUpperCase());

        if (requiresProtection && !isExcluded) {
            HttpSession session = httpRequest.getSession(false);

            if (session == null) {
                httpResponse.sendRedirect(contextPath + "/login");
                return;
            }

            if (!CSRFUtil.validateToken(httpRequest)) {
                httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                httpResponse.setContentType("text/html; charset=UTF-8");
                httpResponse.getWriter().write(
                    "<!DOCTYPE html><html><head><title>Security Error</title></head>" +
                    "<body style='font-family: Arial; padding: 50px; text-align: center;'>" +
                    "<h1 style='color: #d32f2f;'>Security Error</h1>" +
                    "<p>Invalid or missing CSRF token.</p>" +
                    "<p><a href='" + contextPath + "/'>Return to Home</a></p>" +
                    "</body></html>"
                );
                return;
            }
        }

        chain.doFilter(request, response);
    }
}

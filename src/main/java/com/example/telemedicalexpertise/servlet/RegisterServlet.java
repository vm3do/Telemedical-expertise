package com.example.telemedicalexpertise.servlet;

import com.example.telemedicalexpertise.dao.UserDAO;
import com.example.telemedicalexpertise.dao.impl.UserDAOImpl;
import com.example.telemedicalexpertise.model.GeneralPractitioner;
import com.example.telemedicalexpertise.model.Nurse;
import com.example.telemedicalexpertise.model.Specialist;
import com.example.telemedicalexpertise.model.User;
import com.example.telemedicalexpertise.model.enums.Specialty;
import com.example.telemedicalexpertise.service.AuthService;
import com.example.telemedicalexpertise.service.impl.AuthServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        UserDAO userDAO = new UserDAOImpl();
        authService = new AuthServiceImpl(userDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String role = request.getParameter("role");
        String specialtyParam = request.getParameter("specialty");

        try {
            User user = null;
            switch (role) {
                case "NURSE":
                    user = new Nurse(email, password, email, firstName, lastName);
                    break;
                case "GENERAL_PRACTITIONER":
                    user = new GeneralPractitioner(email, password, email, firstName, lastName);
                    break;
                case "SPECIALIST":
                    Specialist specialist = new Specialist(email, password, email, firstName, lastName);
                    if (specialtyParam != null && !specialtyParam.isEmpty()) {
                        specialist.setSpecialty(Specialty.valueOf(specialtyParam));
                    }
                    user = specialist;
                    break;
            }

            if (user != null && authService.register(user)) {
                response.sendRedirect("login?success=registered");
            } else {
                request.setAttribute("error", "Registration failed. Email might already exist.");
                request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
        }
    }
}
package com.example.telemedicalexpertise.servlet;

import com.example.telemedicalexpertise.dao.UserDAO;
import com.example.telemedicalexpertise.dao.impl.UserDAOImpl;
import com.example.telemedicalexpertise.model.User;
import com.example.telemedicalexpertise.service.AuthService;
import com.example.telemedicalexpertise.service.impl.AuthServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {
    private AuthService authService;

    @Override
    public void init() throws ServletException {
        UserDAO userDAO = new UserDAOImpl();
        authService = new AuthServiceImpl(userDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = authService.login(email, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            switch (user.getRole()) {
                case NURSE:
                    request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
                    break;
                case GENERAL_PRACTITIONER:
                    request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
                    break;
                case SPECIALIST:
                    request.getRequestDispatcher("/WEB-INF/jsp/specialist.jsp").forward(request, response);
                    break;
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        }
    }
}
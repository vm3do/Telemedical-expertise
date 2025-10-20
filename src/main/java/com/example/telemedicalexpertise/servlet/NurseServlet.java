package com.example.telemedicalexpertise.servlet;

import com.example.telemedicalexpertise.dao.PatientDAO;
import com.example.telemedicalexpertise.dao.impl.PatientDAOImpl;
import com.example.telemedicalexpertise.model.Patient;
import com.example.telemedicalexpertise.model.User;
import com.example.telemedicalexpertise.service.PatientService;
import com.example.telemedicalexpertise.service.impl.PatientServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class NurseServlet extends HttpServlet {
    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        PatientDAO patientDAO = new PatientDAOImpl();
        patientService = new PatientServiceImpl(patientDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        User user = (User) session.getAttribute("user");

        List<Patient> todayPatients = patientService.getTodayPatients();
        List<Patient> waitingQueue = patientService.getPatientsInWaitingQueue();

        request.setAttribute("todayPatients", todayPatients);
        request.setAttribute("waitingQueue", waitingQueue);
        request.setAttribute("todayCount", todayPatients.size());
        request.setAttribute("queueCount", waitingQueue.size());
        request.setAttribute("totalCount", patientService.getAllPatients().size());

        request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
    }
}


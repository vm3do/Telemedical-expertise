package com.example.telemedicalexpertise.servlet;

import com.example.telemedicalexpertise.model.Consultation;
import com.example.telemedicalexpertise.model.GeneralPractitioner;
import com.example.telemedicalexpertise.model.Patient;
import com.example.telemedicalexpertise.model.User;
import com.example.telemedicalexpertise.model.enums.ConsultationStatus;
import com.example.telemedicalexpertise.service.ConsultationService;
import com.example.telemedicalexpertise.service.PatientService;
import com.example.telemedicalexpertise.service.impl.ConsultationServiceImpl;
import com.example.telemedicalexpertise.service.impl.PatientServiceImpl;
import com.example.telemedicalexpertise.dao.impl.PatientDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@WebServlet("/general")
public class GeneralPractitionerServlet extends HttpServlet {

    private final ConsultationService consultationService;
    private final PatientService patientService;

    public GeneralPractitionerServlet() {
        this.consultationService = new ConsultationServiceImpl();
        this.patientService = new PatientServiceImpl(new PatientDAOImpl());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!(user instanceof GeneralPractitioner)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        GeneralPractitioner gp = (GeneralPractitioner) user;
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("dashboard")) {
                showDashboard(request, response, gp);
            } else if (action.equals("viewQueue")) {
                viewWaitingQueue(request, response);
            } else if (action.equals("newConsultation")) {
                showNewConsultationForm(request, response);
            } else if (action.equals("viewConsultation")) {
                viewConsultation(request, response, gp);
            } else if (action.equals("myConsultations")) {
                viewMyConsultations(request, response, gp);
            } else {
                showDashboard(request, response, gp);
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!(user instanceof GeneralPractitioner)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        GeneralPractitioner gp = (GeneralPractitioner) user;
        String action = request.getParameter("action");

        try {
            if (action != null && action.equals("createConsultation")) {
                createConsultation(request, response, gp);
            } else if (action != null && action.equals("updateConsultation")) {
                updateConsultation(request, response, gp);
            } else if (action != null && action.equals("closeConsultation")) {
                closeConsultation(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/general");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response,
                               GeneralPractitioner gp) throws ServletException, IOException {

        // Get waiting queue patients (using Stream API)
        List<Patient> waitingPatients = patientService.getPatientsInWaitingQueue()
                .stream()
                .sorted((p1, p2) -> {
                    if (p1.getRegisteredAt() == null) return 1;
                    if (p2.getRegisteredAt() == null) return -1;
                    return p1.getRegisteredAt().compareTo(p2.getRegisteredAt());
                })
                .collect(Collectors.toList());

        // Get GP's recent consultations
        List<Consultation> recentConsultations = consultationService
                .getConsultationsByGeneralPractitioner(gp.getId())
                .stream()
                .limit(10)
                .collect(Collectors.toList());

        request.setAttribute("waitingPatients", waitingPatients);
        request.setAttribute("recentConsultations", recentConsultations);
        request.setAttribute("gp", gp);

        request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
    }

    private void viewWaitingQueue(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Using Stream API to filter and sort patients by registration time
        List<Patient> waitingPatients = patientService.getPatientsInWaitingQueue()
                .stream()
                .filter(Patient::getInWaitingQueue)
                .sorted((p1, p2) -> {
                    if (p1.getRegisteredAt() == null) return 1;
                    if (p2.getRegisteredAt() == null) return -1;
                    return p1.getRegisteredAt().compareTo(p2.getRegisteredAt());
                })
                .collect(Collectors.toList());

        request.setAttribute("waitingPatients", waitingPatients);
        request.setAttribute("viewMode", "queue");
        request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
    }

    private void showNewConsultationForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String patientIdStr = request.getParameter("patientId");

        if (patientIdStr != null && !patientIdStr.isEmpty()) {
            Long patientId = Long.parseLong(patientIdStr);
            Optional<Patient> patient = patientService.findPatientById(patientId);

            if (patient.isPresent()) {
                request.setAttribute("patient", patient.get());
            } else {
                request.setAttribute("error", "Patient not found");
            }
        }

        request.setAttribute("viewMode", "newConsultation");
        request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
    }

    private void createConsultation(HttpServletRequest request, HttpServletResponse response,
                                   GeneralPractitioner gp) throws ServletException, IOException {

        String patientIdStr = request.getParameter("patientId");
        String motif = request.getParameter("motif");
        String observations = request.getParameter("observations");

        if (patientIdStr == null || motif == null || motif.trim().isEmpty()) {
            request.setAttribute("error", "Patient and motif are required");
            showNewConsultationForm(request, response);
            return;
        }

        Long patientId = Long.parseLong(patientIdStr);
        Optional<Patient> optPatient = patientService.findPatientById(patientId);

        if (optPatient.isEmpty()) {
            request.setAttribute("error", "Patient not found");
            showNewConsultationForm(request, response);
            return;
        }

        Patient patient = optPatient.get();

        // Create consultation
        Consultation consultation = consultationService.createConsultation(patient, gp, motif, observations);

        // Remove patient from waiting queue
        patient.setInWaitingQueue(false);
        patientService.updatePatient(patient);

        request.setAttribute("success", "Consultation created successfully");
        response.sendRedirect(request.getContextPath() + "/general?action=viewConsultation&id=" + consultation.getId());
    }

    private void updateConsultation(HttpServletRequest request, HttpServletResponse response,
                                   GeneralPractitioner gp) throws ServletException, IOException {

        String consultationIdStr = request.getParameter("consultationId");
        String observations = request.getParameter("observations");
        String diagnostic = request.getParameter("diagnostic");
        String prescription = request.getParameter("prescription");

        if (consultationIdStr == null) {
            request.setAttribute("error", "Consultation ID is required");
            showDashboard(request, response, gp);
            return;
        }

        Long consultationId = Long.parseLong(consultationIdStr);
        Optional<Consultation> optConsultation = consultationService.getConsultationById(consultationId);

        if (optConsultation.isEmpty()) {
            request.setAttribute("error", "Consultation not found");
            showDashboard(request, response, gp);
            return;
        }

        Consultation consultation = optConsultation.get();

        if (observations != null) {
            consultation.setObservations(observations);
        }
        if (diagnostic != null) {
            consultation.setDiagnostic(diagnostic);
        }
        if (prescription != null) {
            consultation.setPrescription(prescription);
        }

        consultationService.updateConsultation(consultation);

        request.setAttribute("success", "Consultation updated successfully");
        response.sendRedirect(request.getContextPath() + "/general?action=viewConsultation&id=" + consultationId);
    }

    private void closeConsultation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String consultationIdStr = request.getParameter("consultationId");
        String diagnostic = request.getParameter("diagnostic");
        String prescription = request.getParameter("prescription");

        if (consultationIdStr == null || diagnostic == null || diagnostic.trim().isEmpty()) {
            request.setAttribute("error", "Consultation ID and diagnostic are required");
            response.sendRedirect(request.getContextPath() + "/general");
            return;
        }

        Long consultationId = Long.parseLong(consultationIdStr);
        consultationService.closeConsultation(consultationId, diagnostic, prescription);

        request.setAttribute("success", "Consultation closed successfully");
        response.sendRedirect(request.getContextPath() + "/general");
    }

    private void viewConsultation(HttpServletRequest request, HttpServletResponse response,
                                 GeneralPractitioner gp) throws ServletException, IOException {

        String consultationIdStr = request.getParameter("id");

        if (consultationIdStr == null) {
            request.setAttribute("error", "Consultation ID is required");
            showDashboard(request, response, gp);
            return;
        }

        Long consultationId = Long.parseLong(consultationIdStr);
        Optional<Consultation> optConsultation = consultationService.getConsultationById(consultationId);

        if (optConsultation.isEmpty()) {
            request.setAttribute("error", "Consultation not found");
            showDashboard(request, response, gp);
            return;
        }

        Consultation consultation = optConsultation.get();
        request.setAttribute("consultation", consultation);
        request.setAttribute("viewMode", "viewConsultation");
        request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
    }

    private void viewMyConsultations(HttpServletRequest request, HttpServletResponse response,
                                    GeneralPractitioner gp) throws ServletException, IOException {

        String statusFilter = request.getParameter("status");

        List<Consultation> consultations = consultationService
                .getConsultationsByGeneralPractitioner(gp.getId());

        // Using Stream API to filter by status if provided
        if (statusFilter != null && !statusFilter.isEmpty() && !statusFilter.equals("ALL")) {
            ConsultationStatus status = ConsultationStatus.valueOf(statusFilter);
            consultations = consultations.stream()
                    .filter(c -> c.getStatus() == status)
                    .collect(Collectors.toList());
        }

        request.setAttribute("consultations", consultations);
        request.setAttribute("viewMode", "myConsultations");
        request.getRequestDispatcher("/WEB-INF/jsp/general.jsp").forward(request, response);
    }
}

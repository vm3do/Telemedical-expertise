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
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class PatientServlet extends HttpServlet {
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

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "search":
                searchPatient(request, response);
                break;
            case "list":
            default:
                listPatients(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "register";
        }

        switch (action) {
            case "register":
                registerPatient(request, response);
                break;
            case "update":
                updatePatient(request, response);
                break;
            default:
                response.sendRedirect("nurse");
                break;
        }
    }

    private void registerPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Patient patient = new Patient();

            patient.setFirstName(request.getParameter("firstName"));
            patient.setLastName(request.getParameter("lastName"));

            String dobStr = request.getParameter("dateOfBirth");
            if (dobStr != null && !dobStr.isEmpty()) {
                patient.setDateOfBirth(LocalDate.parse(dobStr));
            }

            patient.setSocialSecurityNumber(request.getParameter("socialSecurityNumber"));
            patient.setPhone(request.getParameter("phone"));
            patient.setAddress(request.getParameter("address"));
            patient.setInsurance(request.getParameter("insurance"));

            patient.setAllergies(request.getParameter("allergies"));
            patient.setCurrentTreatments(request.getParameter("currentTreatments"));
            patient.setMedicalHistory(request.getParameter("medicalHistory"));

            patient.setBloodPressure(request.getParameter("bloodPressure"));

            String heartRateStr = request.getParameter("heartRate");
            if (heartRateStr != null && !heartRateStr.isEmpty()) {
                patient.setHeartRate(Integer.parseInt(heartRateStr));
            }

            String temperatureStr = request.getParameter("temperature");
            if (temperatureStr != null && !temperatureStr.isEmpty()) {
                patient.setTemperature(Double.parseDouble(temperatureStr));
            }

            String respiratoryRateStr = request.getParameter("respiratoryRate");
            if (respiratoryRateStr != null && !respiratoryRateStr.isEmpty()) {
                patient.setRespiratoryRate(Integer.parseInt(respiratoryRateStr));
            }

            String weightStr = request.getParameter("weight");
            if (weightStr != null && !weightStr.isEmpty()) {
                patient.setWeight(Double.parseDouble(weightStr));
            }

            String heightStr = request.getParameter("height");
            if (heightStr != null && !heightStr.isEmpty()) {
                patient.setHeight(Double.parseDouble(heightStr));
            }

            patientService.registerPatient(patient);

            response.sendRedirect("nurse?success=Patient registered successfully");
        } catch (DateTimeParseException e) {
            request.setAttribute("error", "Invalid date format");
            request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid number format in vital signs");
            request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
        }
    }

    private void updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long patientId = Long.parseLong(request.getParameter("patientId"));
            Patient patient = patientService.findPatientById(patientId)
                    .orElseThrow(() -> new RuntimeException("Patient not found"));

            patient.setBloodPressure(request.getParameter("bloodPressure"));

            String heartRateStr = request.getParameter("heartRate");
            if (heartRateStr != null && !heartRateStr.isEmpty()) {
                patient.setHeartRate(Integer.parseInt(heartRateStr));
            }

            String temperatureStr = request.getParameter("temperature");
            if (temperatureStr != null && !temperatureStr.isEmpty()) {
                patient.setTemperature(Double.parseDouble(temperatureStr));
            }

            String respiratoryRateStr = request.getParameter("respiratoryRate");
            if (respiratoryRateStr != null && !respiratoryRateStr.isEmpty()) {
                patient.setRespiratoryRate(Integer.parseInt(respiratoryRateStr));
            }

            String weightStr = request.getParameter("weight");
            if (weightStr != null && !weightStr.isEmpty()) {
                patient.setWeight(Double.parseDouble(weightStr));
            }

            patientService.updatePatient(patient);
            patientService.addToWaitingQueue(patientId);

            response.sendRedirect("nurse?success=Patient updated and added to queue");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid patient ID or vital signs format");
            request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
        } catch (RuntimeException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
        }
    }

    private void searchPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ssn = request.getParameter("ssn");

        if (ssn != null && !ssn.isEmpty()) {
            patientService.findPatientBySocialSecurityNumber(ssn)
                    .ifPresentOrElse(
                            patient -> request.setAttribute("foundPatient", patient),
                            () -> request.setAttribute("searchError", "Patient not found")
                    );
        }

        request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
    }

    private void listPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/nurse.jsp").forward(request, response);
    }
}


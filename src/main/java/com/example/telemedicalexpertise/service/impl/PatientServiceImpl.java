package com.example.telemedicalexpertise.service.impl;

import com.example.telemedicalexpertise.dao.PatientDAO;
import com.example.telemedicalexpertise.model.Patient;
import com.example.telemedicalexpertise.service.PatientService;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class PatientServiceImpl implements PatientService {
    private final PatientDAO patientDAO;

    public PatientServiceImpl(PatientDAO patientDAO) {
        this.patientDAO = patientDAO;
    }

    @Override
    public Patient registerPatient(Patient patient) {
        if (patient.getSocialSecurityNumber() != null && !patient.getSocialSecurityNumber().isEmpty()) {
            Optional<Patient> existing = patientDAO.findBySocialSecurityNumber(patient.getSocialSecurityNumber());
            if (existing.isPresent()) {
                throw new RuntimeException("Patient with this social security number already exists");
            }
        }

        patient.setRegisteredAt(LocalDateTime.now());
        patient.setVitalSignsDate(LocalDateTime.now());
        patient.setInWaitingQueue(true);

        return patientDAO.save(patient);
    }

    @Override
    public Optional<Patient> findPatientById(Long id) {
        return patientDAO.findById(id);
    }

    @Override
    public Optional<Patient> findPatientBySocialSecurityNumber(String ssn) {
        return patientDAO.findBySocialSecurityNumber(ssn);
    }

    @Override
    public List<Patient> getAllPatients() {
        return patientDAO.findAll();
    }

    @Override
    public List<Patient> getTodayPatients() {
        return patientDAO.findByRegisteredAtDate(LocalDate.now());
    }

    @Override
    public List<Patient> getPatientsInWaitingQueue() {
        return patientDAO.findInWaitingQueue();
    }

    @Override
    public void updatePatient(Patient patient) {
        patient.setVitalSignsDate(LocalDateTime.now());
        patientDAO.update(patient);
    }

    @Override
    public void addToWaitingQueue(Long patientId) {
        Optional<Patient> patientOpt = patientDAO.findById(patientId);
        if (patientOpt.isPresent()) {
            Patient patient = patientOpt.get();
            patient.setInWaitingQueue(true);
            patient.setRegisteredAt(LocalDateTime.now());
            patientDAO.update(patient);
        }
    }

    @Override
    public void removeFromWaitingQueue(Long patientId) {
        Optional<Patient> patientOpt = patientDAO.findById(patientId);
        if (patientOpt.isPresent()) {
            Patient patient = patientOpt.get();
            patient.setInWaitingQueue(false);
            patientDAO.update(patient);
        }
    }
}


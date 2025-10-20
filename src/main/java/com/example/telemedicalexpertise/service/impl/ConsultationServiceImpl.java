package com.example.telemedicalexpertise.service.impl;

import com.example.telemedicalexpertise.dao.ConsultationDAO;
import com.example.telemedicalexpertise.dao.impl.ConsultationDAOImpl;
import com.example.telemedicalexpertise.model.Consultation;
import com.example.telemedicalexpertise.model.GeneralPractitioner;
import com.example.telemedicalexpertise.model.Patient;
import com.example.telemedicalexpertise.model.enums.ConsultationStatus;
import com.example.telemedicalexpertise.service.ConsultationService;

import java.util.List;
import java.util.Optional;

public class ConsultationServiceImpl implements ConsultationService {

    private final ConsultationDAO consultationDAO;

    public ConsultationServiceImpl() {
        this.consultationDAO = new ConsultationDAOImpl();
    }

    @Override
    public Consultation createConsultation(Patient patient, GeneralPractitioner gp, String motif, String observations) {
        if (patient == null || gp == null || motif == null || motif.trim().isEmpty()) {
            throw new IllegalArgumentException("Patient, GP, and motif are required to create a consultation");
        }

        Consultation consultation = new Consultation(patient, gp, motif);
        consultation.setObservations(observations);
        consultationDAO.save(consultation);
        return consultation;
    }

    @Override
    public void updateConsultation(Consultation consultation) {
        if (consultation == null || consultation.getId() == null) {
            throw new IllegalArgumentException("Consultation must exist to be updated");
        }
        consultationDAO.update(consultation);
    }

    @Override
    public Optional<Consultation> getConsultationById(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("Consultation ID cannot be null");
        }
        return consultationDAO.findById(id);
    }

    @Override
    public List<Consultation> getAllConsultations() {
        return consultationDAO.findAll();
    }

    @Override
    public List<Consultation> getConsultationsByPatient(Long patientId) {
        if (patientId == null) {
            throw new IllegalArgumentException("Patient ID cannot be null");
        }
        return consultationDAO.findByPatientId(patientId);
    }

    @Override
    public List<Consultation> getConsultationsByGeneralPractitioner(Long gpId) {
        if (gpId == null) {
            throw new IllegalArgumentException("GP ID cannot be null");
        }
        return consultationDAO.findByGeneralPractitionerId(gpId);
    }

    @Override
    public List<Consultation> getConsultationsByStatus(ConsultationStatus status) {
        if (status == null) {
            throw new IllegalArgumentException("Status cannot be null");
        }
        return consultationDAO.findByStatus(status);
    }

    @Override
    public void closeConsultation(Long consultationId, String diagnostic, String prescription) {
        Optional<Consultation> optConsultation = consultationDAO.findById(consultationId);

        if (optConsultation.isEmpty()) {
            throw new IllegalArgumentException("Consultation not found with ID: " + consultationId);
        }

        Consultation consultation = optConsultation.get();

        if (!consultation.isOpen()) {
            throw new IllegalStateException("Cannot close a consultation that is already closed");
        }

        consultation.setDiagnostic(diagnostic);
        consultation.setPrescription(prescription);
        consultation.closeConsultation();

        consultationDAO.update(consultation);
    }

    @Override
    public void requestSpecialistOpinion(Long consultationId) {
        Optional<Consultation> optConsultation = consultationDAO.findById(consultationId);

        if (optConsultation.isEmpty()) {
            throw new IllegalArgumentException("Consultation not found with ID: " + consultationId);
        }

        Consultation consultation = optConsultation.get();

        if (!consultation.isOpen()) {
            throw new IllegalStateException("Cannot request specialist opinion for a closed consultation");
        }

        consultation.requestSpecialistOpinion();
        consultationDAO.update(consultation);
    }

    @Override
    public List<Consultation> getOpenConsultations() {
        return consultationDAO.findOpenConsultations();
    }
}


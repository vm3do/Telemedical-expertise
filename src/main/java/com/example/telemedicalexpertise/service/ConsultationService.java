package com.example.telemedicalexpertise.service;

import com.example.telemedicalexpertise.model.Consultation;
import com.example.telemedicalexpertise.model.GeneralPractitioner;
import com.example.telemedicalexpertise.model.Patient;
import com.example.telemedicalexpertise.model.enums.ConsultationStatus;
import java.util.List;
import java.util.Optional;

public interface ConsultationService {
    Consultation createConsultation(Patient patient, GeneralPractitioner gp, String motif, String observations);
    void updateConsultation(Consultation consultation);
    Optional<Consultation> getConsultationById(Long id);
    List<Consultation> getAllConsultations();
    List<Consultation> getConsultationsByPatient(Long patientId);
    List<Consultation> getConsultationsByGeneralPractitioner(Long gpId);
    List<Consultation> getConsultationsByStatus(ConsultationStatus status);
    void closeConsultation(Long consultationId, String diagnostic, String prescription);
    void requestSpecialistOpinion(Long consultationId);
    List<Consultation> getOpenConsultations();
}


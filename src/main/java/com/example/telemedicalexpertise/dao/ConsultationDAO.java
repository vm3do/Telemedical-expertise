package com.example.telemedicalexpertise.dao;

import com.example.telemedicalexpertise.model.Consultation;
import com.example.telemedicalexpertise.model.enums.ConsultationStatus;
import java.util.List;
import java.util.Optional;

public interface ConsultationDAO {
    void save(Consultation consultation);
    void update(Consultation consultation);
    Optional<Consultation> findById(Long id);
    List<Consultation> findAll();
    List<Consultation> findByPatientId(Long patientId);
    List<Consultation> findByGeneralPractitionerId(Long gpId);
    List<Consultation> findByStatus(ConsultationStatus status);
    List<Consultation> findOpenConsultations();
    void delete(Long id);
}


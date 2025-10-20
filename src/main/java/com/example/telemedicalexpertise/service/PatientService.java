package com.example.telemedicalexpertise.service;

import com.example.telemedicalexpertise.model.Patient;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface PatientService {
    Patient registerPatient(Patient patient);
    Optional<Patient> findPatientById(Long id);
    Optional<Patient> findPatientBySocialSecurityNumber(String ssn);
    List<Patient> getAllPatients();
    List<Patient> getTodayPatients();
    List<Patient> getPatientsInWaitingQueue();
    void updatePatient(Patient patient);
    void addToWaitingQueue(Long patientId);
    void removeFromWaitingQueue(Long patientId);
}


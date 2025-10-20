package com.example.telemedicalexpertise.dao;

import com.example.telemedicalexpertise.model.Patient;
import java.util.List;
import java.util.Optional;

public interface PatientDAO {
    Patient save(Patient patient);
    Optional<Patient> findById(Long id);
    Optional<Patient> findBySocialSecurityNumber(String ssn);
    List<Patient> findAll();
    List<Patient> findByRegisteredAtDate(java.time.LocalDate date);
    List<Patient> findInWaitingQueue();
    void update(Patient patient);
    void delete(Long id);
}


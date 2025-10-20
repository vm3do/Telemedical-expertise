package com.example.telemedicalexpertise.dao;

import com.example.telemedicalexpertise.model.Specialist;
import com.example.telemedicalexpertise.model.enums.Specialty;
import java.util.List;
import java.util.Optional;

public interface SpecialistDAO {
    Optional<Specialist> findById(Long id);
    List<Specialist> findAll();
    List<Specialist> findBySpecialty(Specialty specialty);
    void update(Specialist specialist);
}


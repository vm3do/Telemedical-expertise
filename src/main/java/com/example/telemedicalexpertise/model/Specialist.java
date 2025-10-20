package com.example.telemedicalexpertise.model;

import com.example.telemedicalexpertise.model.enums.Role;
import com.example.telemedicalexpertise.model.enums.Specialty;
import jakarta.persistence.*;

@Entity
@DiscriminatorValue("SPECIALIST")
public class Specialist extends User {
    
    @Enumerated(EnumType.STRING)
    @Column(name = "specialty")
    private Specialty specialty;

    @Column(name = "consultation_tariff")
    private Double consultationTariff;

    @Column(name = "consultation_duration")
    private Integer consultationDuration = 30; // default 30 minutes

    public Specialist() {
        super();
        setRole(Role.SPECIALIST);
    }
    
    public Specialist(String username, String password, String email, String firstName, String lastName) {
        super(username, password, email, firstName, lastName, Role.SPECIALIST);
    }

    // Getters and Setters
    public Specialty getSpecialty() { return specialty; }
    public void setSpecialty(Specialty specialty) { this.specialty = specialty; }

    public Double getConsultationTariff() { return consultationTariff; }
    public void setConsultationTariff(Double consultationTariff) { this.consultationTariff = consultationTariff; }

    public Integer getConsultationDuration() { return consultationDuration; }
    public void setConsultationDuration(Integer consultationDuration) { this.consultationDuration = consultationDuration; }
}
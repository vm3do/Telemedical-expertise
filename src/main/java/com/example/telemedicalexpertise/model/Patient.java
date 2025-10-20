package com.example.telemedicalexpertise.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "patients")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "first_name", nullable = false)
    private String firstName;

    @Column(name = "last_name", nullable = false)
    private String lastName;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Column(name = "social_security_number", unique = true)
    private String socialSecurityNumber;

    @Column(name = "phone")
    private String phone;

    @Column(name = "address")
    private String address;

    @Column(name = "insurance")
    private String insurance;

    // Medical History
    @Column(name = "medical_history", columnDefinition = "TEXT")
    private String medicalHistory;

    @Column(name = "allergies", columnDefinition = "TEXT")
    private String allergies;

    @Column(name = "current_treatments", columnDefinition = "TEXT")
    private String currentTreatments;

    // Vital Signs (most recent)
    @Column(name = "blood_pressure")
    private String bloodPressure; // e.g., "120/80"

    @Column(name = "heart_rate")
    private Integer heartRate; // beats per minute

    @Column(name = "temperature")
    private Double temperature; // in Celsius

    @Column(name = "respiratory_rate")
    private Integer respiratoryRate; // breaths per minute

    @Column(name = "weight")
    private Double weight; // in kg

    @Column(name = "height")
    private Double height; // in cm

    @Column(name = "vital_signs_date")
    private LocalDateTime vitalSignsDate;

    @Column(name = "registered_at")
    private LocalDateTime registeredAt;

    @Column(name = "in_waiting_queue")
    private Boolean inWaitingQueue = false;

    public Patient() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getSocialSecurityNumber() { return socialSecurityNumber; }
    public void setSocialSecurityNumber(String socialSecurityNumber) { this.socialSecurityNumber = socialSecurityNumber; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getInsurance() { return insurance; }
    public void setInsurance(String insurance) { this.insurance = insurance; }

    public String getMedicalHistory() { return medicalHistory; }
    public void setMedicalHistory(String medicalHistory) { this.medicalHistory = medicalHistory; }

    public String getAllergies() { return allergies; }
    public void setAllergies(String allergies) { this.allergies = allergies; }

    public String getCurrentTreatments() { return currentTreatments; }
    public void setCurrentTreatments(String currentTreatments) { this.currentTreatments = currentTreatments; }

    public String getBloodPressure() { return bloodPressure; }
    public void setBloodPressure(String bloodPressure) { this.bloodPressure = bloodPressure; }

    public Integer getHeartRate() { return heartRate; }
    public void setHeartRate(Integer heartRate) { this.heartRate = heartRate; }

    public Double getTemperature() { return temperature; }
    public void setTemperature(Double temperature) { this.temperature = temperature; }

    public Integer getRespiratoryRate() { return respiratoryRate; }
    public void setRespiratoryRate(Integer respiratoryRate) { this.respiratoryRate = respiratoryRate; }

    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }

    public Double getHeight() { return height; }
    public void setHeight(Double height) { this.height = height; }

    public LocalDateTime getVitalSignsDate() { return vitalSignsDate; }
    public void setVitalSignsDate(LocalDateTime vitalSignsDate) { this.vitalSignsDate = vitalSignsDate; }

    public LocalDateTime getRegisteredAt() { return registeredAt; }
    public void setRegisteredAt(LocalDateTime registeredAt) { this.registeredAt = registeredAt; }

    public Boolean getInWaitingQueue() { return inWaitingQueue; }
    public void setInWaitingQueue(Boolean inWaitingQueue) { this.inWaitingQueue = inWaitingQueue; }

    public String getFullName() {
        return firstName + " " + lastName;
    }
}


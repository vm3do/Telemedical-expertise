package com.example.telemedicalexpertise.model;

import com.example.telemedicalexpertise.model.enums.ConsultationStatus;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "consultations")
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "general_practitioner_id", nullable = false)
    private GeneralPractitioner generalPractitioner;

    @Column(name = "motif", nullable = false)
    private String motif;

    @Column(name = "observations", columnDefinition = "TEXT")
    private String observations;

    @Column(name = "diagnostic", columnDefinition = "TEXT")
    private String diagnostic;

    @Column(name = "prescription", columnDefinition = "TEXT")
    private String prescription;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private ConsultationStatus status;

    @Column(name = "consultation_cost")
    private Double consultationCost = 150.0; // Fixed cost: 150 DH

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Column(name = "closed_at")
    private LocalDateTime closedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) {
            status = ConsultationStatus.EN_COURS;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Constructors
    public Consultation() {}

    public Consultation(Patient patient, GeneralPractitioner generalPractitioner, String motif) {
        this.patient = patient;
        this.generalPractitioner = generalPractitioner;
        this.motif = motif;
        this.status = ConsultationStatus.EN_COURS;
        this.consultationCost = 150.0;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public GeneralPractitioner getGeneralPractitioner() { return generalPractitioner; }
    public void setGeneralPractitioner(GeneralPractitioner generalPractitioner) {
        this.generalPractitioner = generalPractitioner;
    }

    public String getMotif() { return motif; }
    public void setMotif(String motif) { this.motif = motif; }

    public String getObservations() { return observations; }
    public void setObservations(String observations) { this.observations = observations; }

    public String getDiagnostic() { return diagnostic; }
    public void setDiagnostic(String diagnostic) { this.diagnostic = diagnostic; }

    public String getPrescription() { return prescription; }
    public void setPrescription(String prescription) { this.prescription = prescription; }

    public ConsultationStatus getStatus() { return status; }
    public void setStatus(ConsultationStatus status) { this.status = status; }

    public Double getConsultationCost() { return consultationCost; }
    public void setConsultationCost(Double consultationCost) { this.consultationCost = consultationCost; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public LocalDateTime getClosedAt() { return closedAt; }
    public void setClosedAt(LocalDateTime closedAt) { this.closedAt = closedAt; }

    // Business methods
    public void closeConsultation() {
        this.status = ConsultationStatus.TERMINEE;
        this.closedAt = LocalDateTime.now();
    }

    public void requestSpecialistOpinion() {
        this.status = ConsultationStatus.EN_ATTENTE_AVIS_SPECIALISTE;
    }

    public boolean isOpen() {
        return this.status != ConsultationStatus.TERMINEE;
    }

    public boolean isWaitingForSpecialist() {
        return this.status == ConsultationStatus.EN_ATTENTE_AVIS_SPECIALISTE;
    }
}


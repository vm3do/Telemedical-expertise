package com.example.telemedicalexpertise.model.enums;

public enum ConsultationStatus {
    EN_COURS("En Cours"),
    EN_ATTENTE_AVIS_SPECIALISTE("En Attente Avis Spécialiste"),
    TERMINEE("Terminée");

    private final String displayName;

    ConsultationStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}


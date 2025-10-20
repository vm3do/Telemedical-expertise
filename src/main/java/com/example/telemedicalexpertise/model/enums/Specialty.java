package com.example.telemedicalexpertise.model.enums;

public enum Specialty {
    CARDIOLOGY("Cardiology", "Heart and blood vessel diseases"),
    PNEUMOLOGY("Pneumology", "Respiratory and pulmonary diseases"),
    NEUROLOGY("Neurology", "Nervous system disorders"),
    GASTROENTEROLOGY("Gastroenterology", "Digestive system diseases"),
    ENDOCRINOLOGY("Endocrinology", "Hormonal and metabolic disorders"),
    DERMATOLOGY("Dermatology", "Skin diseases"),
    RHEUMATOLOGY("Rheumatology", "Joint, bone and muscle diseases"),
    PSYCHIATRY("Psychiatry", "Mental and psychological disorders"),
    NEPHROLOGY("Nephrology", "Kidney diseases"),
    ORTHOPEDICS("Orthopedics", "Bone, joint and muscle trauma");

    private final String displayName;
    private final String description;

    Specialty(String displayName, String description) {
        this.displayName = displayName;
        this.description = description;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getDescription() {
        return description;
    }
}


package com.example.telemedicalexpertise.model;

import com.example.telemedicalexpertise.model.enums.Role;
import jakarta.persistence.*;

@Entity
@DiscriminatorValue("GENERAL_PRACTITIONER")
public class GeneralPractitioner extends User {
    
    public GeneralPractitioner() {
        super();
        setRole(Role.GENERAL_PRACTITIONER);
    }
    
    public GeneralPractitioner(String username, String password, String email, String firstName, String lastName) {
        super(username, password, email, firstName, lastName, Role.GENERAL_PRACTITIONER);
    }
}
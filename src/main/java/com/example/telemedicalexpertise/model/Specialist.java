package com.example.telemedicalexpertise.model;

import com.example.telemedicalexpertise.model.enums.Role;
import jakarta.persistence.*;

@Entity
@DiscriminatorValue("SPECIALIST")
public class Specialist extends User {
    
    public Specialist() {
        super();
        setRole(Role.SPECIALIST);
    }
    
    public Specialist(String username, String password, String email, String firstName, String lastName) {
        super(username, password, email, firstName, lastName, Role.SPECIALIST);
    }
}
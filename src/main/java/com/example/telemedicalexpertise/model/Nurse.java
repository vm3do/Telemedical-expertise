package com.example.telemedicalexpertise.model;

import com.example.telemedicalexpertise.model.enums.Role;
import jakarta.persistence.*;

@Entity
@DiscriminatorValue("NURSE")
public class Nurse extends User {
    
    public Nurse() {
        super();
        setRole(Role.NURSE);
    }
    
    public Nurse(String username, String password, String email, String firstName, String lastName) {
        super(username, password, email, firstName, lastName, Role.NURSE);
    }
}
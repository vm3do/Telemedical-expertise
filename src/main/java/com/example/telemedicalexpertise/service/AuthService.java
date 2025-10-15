package com.example.telemedicalexpertise.service;

import com.example.telemedicalexpertise.model.User;

public interface AuthService {
    User login(String email, String password);
    boolean register(User user);
}
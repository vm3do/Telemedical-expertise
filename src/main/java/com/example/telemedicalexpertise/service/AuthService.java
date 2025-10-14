package com.example.telemedicalexpertise.service;

import com.example.telemedicalexpertise.dao.UserDAO;
import com.example.telemedicalexpertise.model.User;

public class AuthService {
    private UserDAO userDAO;
    
    public AuthService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }
    
    public User login(String username, String password) {
        if (userDAO.authenticate(username, password)) {
            return userDAO.findByUsername(username);
        }
        return null;
    }
    
    public boolean register(User user) {
        try {
            userDAO.save(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
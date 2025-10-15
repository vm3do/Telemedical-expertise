package com.example.telemedicalexpertise.service.impl;

import com.example.telemedicalexpertise.dao.UserDAO;
import com.example.telemedicalexpertise.model.User;
import com.example.telemedicalexpertise.service.AuthService;

public class AuthServiceImpl implements AuthService {
    private UserDAO userDAO;
    
    public AuthServiceImpl(UserDAO userDAO) {
        this.userDAO = userDAO;
    }
    
    @Override
    public User login(String email, String password) {
        if (userDAO.authenticate(email, password)) {
            return userDAO.findByEmail(email);
        }
        return null;
    }
    
    @Override
    public boolean register(User user) {
        try {
            userDAO.save(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
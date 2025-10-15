package com.example.telemedicalexpertise.dao;

import com.example.telemedicalexpertise.model.User;

public interface UserDAO {
    void save(User user);
    User findById(Long id);
    User findByEmail(String email);
    void update(User user);
    void delete(Long id);
    boolean authenticate(String email, String password);
}
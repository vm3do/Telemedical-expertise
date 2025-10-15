package com.example.telemedicalexpertise.dao.impl;

import com.example.telemedicalexpertise.dao.UserDAO;
import com.example.telemedicalexpertise.model.User;
import com.example.telemedicalexpertise.utils.BCryptUtil;
import com.example.telemedicalexpertise.utils.HibernateUtil;
import org.hibernate.Session;

public class UserDAOImpl implements UserDAO {

    @Override
    public void save(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            user.setPassword(BCryptUtil.hashPassword(user.getPassword()));
            session.persist(user);
            session.getTransaction().commit();
        }
    }

    @Override
    public User findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.find(User.class, id);
        }
    }

    @Override
    public User findByEmail(String email) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM User WHERE email = :email", User.class)
                    .setParameter("email", email)
                    .uniqueResult();
        }
    }

    @Override
    public void update(User user) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            session.merge(user);
            session.getTransaction().commit();
        }
    }

    @Override
    public void delete(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();
            User user = session.find(User.class, id);
            if (user != null) {
                session.remove(user);
            }
            session.getTransaction().commit();
        }
    }

    @Override
    public boolean authenticate(String email, String password) {
        User user = findByEmail(email);
        return user != null && BCryptUtil.checkPassword(password, user.getPassword());
    }
}
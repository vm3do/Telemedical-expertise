package com.example.telemedicalexpertise.dao.impl;

import com.example.telemedicalexpertise.dao.SpecialistDAO;
import com.example.telemedicalexpertise.model.Specialist;
import com.example.telemedicalexpertise.model.enums.Specialty;
import com.example.telemedicalexpertise.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class SpecialistDAOImpl implements SpecialistDAO {

    @Override
    public Optional<Specialist> findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Specialist specialist = session.find(Specialist.class, id);
            return Optional.ofNullable(specialist);
        } catch (Exception e) {
            throw new RuntimeException("Error finding specialist by id: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Specialist> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Specialist", Specialist.class).list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding all specialists: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Specialist> findBySpecialty(Specialty specialty) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Specialist> query = session.createQuery(
                "FROM Specialist WHERE specialty = :specialty ORDER BY consultationTariff ASC",
                Specialist.class);
            query.setParameter("specialty", specialty);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding specialists by specialty: " + e.getMessage(), e);
        }
    }

    @Override
    public void update(Specialist specialist) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(specialist);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Error updating specialist: " + e.getMessage(), e);
        }
    }
}

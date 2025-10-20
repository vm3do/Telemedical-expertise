package com.example.telemedicalexpertise.dao.impl;

import com.example.telemedicalexpertise.dao.PatientDAO;
import com.example.telemedicalexpertise.model.Patient;
import com.example.telemedicalexpertise.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class PatientDAOImpl implements PatientDAO {

    @Override
    public Patient save(Patient patient) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(patient);
            transaction.commit();
            return patient;
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Error saving patient: " + e.getMessage(), e);
        }
    }

    @Override
    public Optional<Patient> findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Patient patient = session.find(Patient.class, id);
            return Optional.ofNullable(patient);
        } catch (Exception e) {
            throw new RuntimeException("Error finding patient by id: " + e.getMessage(), e);
        }
    }

    @Override
    public Optional<Patient> findBySocialSecurityNumber(String ssn) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Patient> query = session.createQuery(
                "FROM Patient WHERE socialSecurityNumber = :ssn", Patient.class);
            query.setParameter("ssn", ssn);
            return query.uniqueResultOptional();
        } catch (Exception e) {
            throw new RuntimeException("Error finding patient by SSN: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Patient> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Patient", Patient.class).list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding all patients: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Patient> findByRegisteredAtDate(LocalDate date) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            LocalDateTime startOfDay = date.atStartOfDay();
            LocalDateTime endOfDay = date.plusDays(1).atStartOfDay();

            Query<Patient> query = session.createQuery(
                "FROM Patient WHERE registeredAt >= :start AND registeredAt < :end ORDER BY registeredAt ASC",
                Patient.class);
            query.setParameter("start", startOfDay);
            query.setParameter("end", endOfDay);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding patients by date: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Patient> findInWaitingQueue() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Patient> query = session.createQuery(
                "FROM Patient WHERE inWaitingQueue = true ORDER BY registeredAt ASC",
                Patient.class);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding patients in queue: " + e.getMessage(), e);
        }
    }

    @Override
    public void update(Patient patient) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(patient);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Error updating patient: " + e.getMessage(), e);
        }
    }

    @Override
    public void delete(Long id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Patient patient = session.find(Patient.class, id);
            if (patient != null) {
                session.remove(patient);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Error deleting patient: " + e.getMessage(), e);
        }
    }
}

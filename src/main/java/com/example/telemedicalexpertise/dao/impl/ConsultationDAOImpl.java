package com.example.telemedicalexpertise.dao.impl;

import com.example.telemedicalexpertise.dao.ConsultationDAO;
import com.example.telemedicalexpertise.model.Consultation;
import com.example.telemedicalexpertise.model.enums.ConsultationStatus;
import com.example.telemedicalexpertise.utils.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class ConsultationDAOImpl implements ConsultationDAO {

    @Override
    public void save(Consultation consultation) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(consultation);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Error saving consultation: " + e.getMessage(), e);
        }
    }

    @Override
    public void update(Consultation consultation) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(consultation);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Error updating consultation: " + e.getMessage(), e);
        }
    }

    @Override
    public Optional<Consultation> findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Consultation consultation = session.find(Consultation.class, id);
            return Optional.ofNullable(consultation);
        } catch (Exception e) {
            throw new RuntimeException("Error finding consultation by id: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Consultation> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Consultation ORDER BY createdAt DESC", Consultation.class).list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding all consultations: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Consultation> findByPatientId(Long patientId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Consultation> query = session.createQuery(
                "FROM Consultation WHERE patient.id = :patientId ORDER BY createdAt DESC",
                Consultation.class);
            query.setParameter("patientId", patientId);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding consultations by patient: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Consultation> findByGeneralPractitionerId(Long gpId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Consultation> query = session.createQuery(
                "FROM Consultation WHERE generalPractitioner.id = :gpId ORDER BY createdAt DESC",
                Consultation.class);
            query.setParameter("gpId", gpId);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding consultations by GP: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Consultation> findByStatus(ConsultationStatus status) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Consultation> query = session.createQuery(
                "FROM Consultation WHERE status = :status ORDER BY createdAt DESC",
                Consultation.class);
            query.setParameter("status", status);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding consultations by status: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Consultation> findOpenConsultations() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Consultation> query = session.createQuery(
                "FROM Consultation WHERE status != :closedStatus ORDER BY createdAt DESC",
                Consultation.class);
            query.setParameter("closedStatus", ConsultationStatus.TERMINEE);
            return query.list();
        } catch (Exception e) {
            throw new RuntimeException("Error finding open consultations: " + e.getMessage(), e);
        }
    }

    @Override
    public void delete(Long id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Consultation consultation = session.find(Consultation.class, id);
            if (consultation != null) {
                session.remove(consultation);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw new RuntimeException("Error deleting consultation: " + e.getMessage(), e);
        }
    }
}


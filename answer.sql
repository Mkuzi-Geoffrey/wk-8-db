
---
-- Clinic Booking System
-- This SQL script creates a database schema for a clinic booking system.
-- It includes tables for patients, doctors, specializations, appointments, and prescriptions.
-- The schema is designed to manage patient information, doctor details, appointment scheduling,                                            

-- Clinic Booking System Schema
-- -----------------------------

-- Drop tables to avoid duplicates (safe re-run)
DROP TABLE IF EXISTS prescriptions;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS doctor_specializations;
DROP TABLE IF EXISTS specializations;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS patients;

-- ------------------------
-- Table: Patients
-- ------------------------
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- ------------------------
-- Table: Rooms
-- ------------------------
CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    floor INT NOT NULL
);

-- ------------------------
-- Table: Doctors
-- ------------------------
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    room_id INT,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- ------------------------
-- Table: Specializations
-- ------------------------
CREATE TABLE specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ------------------------
-- Table: Doctor_Specializations
-- Many-to-Many relationship between doctors and their specialties
-- ------------------------
CREATE TABLE doctor_specializations (
    doctor_id INT,
    specialization_id INT,
    PRIMARY KEY (doctor_id, specialization_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id)
);

-- ------------------------
-- Table: Appointments
-- Each appointment is linked to one patient and one doctor
-- ------------------------
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- ------------------------
-- Table: Prescriptions
-- One-to-One: Each appointment can have one prescription
-- ------------------------
CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    prescribed_on DATE NOT NULL,
    medication TEXT NOT NULL,
    dosage TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

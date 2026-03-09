-- ======================================
-- Database: ClinicDB
-- Author: Johnny Motsemme
-- Date: 2023-06-05
-- ======================================



CREATE DATABASE ClinicDB;
USE ClinicDB;
-- -----------------------------
-- Table: Patient
-- Description: Stores patient details
-- -----------------------------
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255)
);
-- -----------------------------
-- Table: Doctor
-- Description: Stores doctor details
-- -----------------------------

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);
-- -----------------------------
-- Table: Appointment
-- Description: Stores appointments linking patients and doctors
-- -----------------------------

CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason_for_visit VARCHAR(255),
    status VARCHAR(50),

    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- -----------------------------
-- Table: Treatment
-- Description: Stores treatment details linked to appointments
-- -----------------------------
CREATE TABLE Treatment (
    treatment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    diagnosis VARCHAR(255),
    treatment_description TEXT,

    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- -----------------------------
-- Table: Medication
-- Description: Stores medication details
-- -----------------------------
CREATE TABLE Medication (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(100),
    side_effects TEXT
);

-- -----------------------------
-- Table: Prescription
-- Description: Links medications to appointments
-- -----------------------------
CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT NOT NULL,
    medication_id INT NOT NULL,
    quantity INT NOT NULL,
    instructions TEXT,

    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id),
    FOREIGN KEY (medication_id) REFERENCES Medication(medication_id)
);

-- Sample data for Patient table
INSERT INTO Patient (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES ('Ryan', 'Williams', '2008-11-12', 'Male', '0721234567', 'thabo@email.com', 'Midrand');

INSERT INTO Patient (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES ('Nusrat', 'Suri', '2020-09-05', 'Female', '0719876543', 'lerato@email.com', 'Sandton');

INSERT INTO Patient (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES ('Samania', 'Adams', '2023-12-20', 'Male', '0734567890', 'sipho@email.com', 'Roodepoort');

INSERT INTO Patient (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES ('Mustofa', 'Jacobs', '2021-03-15', 'Female', '0742345678', 'naledi@email.com', 'Johannesburg');

INSERT INTO Patient (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES ('Kgosi', 'Matsimela', '1998-07-25', 'Male', '0728765432', 'kgosi@email.com', 'Pretoria');

-- Sample data for Doctor table
INSERT INTO Doctor (first_name, last_name, specialization, phone, email)
VALUES ('Sarah', 'Naidoo', 'General Practitioner', '0739876543', 'sarah@clinic.com');

INSERT INTO Doctor (first_name, last_name, specialization, phone, email)
VALUES ('James', 'Mthethwa', 'Pediatrics', '0723456789', 'james@clinic.com');

INSERT INTO Doctor (first_name, last_name, specialization, phone, email)
VALUES ('Lindiwe', 'Zulu', 'Dermatology', '0745678901', 'lindiwe@clinic.com');

INSERT INTO Doctor (first_name, last_name, specialization, phone, email)
VALUES ('Tshiamo', 'Mokoena', 'Cardiology', '0712345678', 'tshiamo@clinic.com');

INSERT INTO Doctor (first_name, last_name, specialization, phone, email)
VALUES ('David', 'Nkosi', 'Orthopedics', '0756789012', 'david@clinic.com');

-- Sample data for Appointment table
INSERT INTO Appointment (patient_id, doctor_id, appointment_date, reason_for_visit, status)
VALUES (1, 1, '2026-03-05 09:00:00', 'Routine checkup', 'Scheduled');

INSERT INTO Appointment (patient_id, doctor_id, appointment_date, reason_for_visit, status)
VALUES (2, 2, '2026-03-06 10:30:00', 'Child fever', 'Completed');

INSERT INTO Appointment (patient_id, doctor_id, appointment_date, reason_for_visit, status)
VALUES (3, 3, '2026-03-07 14:00:00', 'Skin rash', 'Scheduled');

INSERT INTO Appointment (patient_id, doctor_id, appointment_date, reason_for_visit, status)
VALUES (4, 4, '2026-03-08 11:00:00', 'Heart checkup', 'Cancelled');

INSERT INTO Appointment (patient_id, doctor_id, appointment_date, reason_for_visit, status)
VALUES (5, 5, '2026-03-09 15:30:00', 'Joint pain', 'Scheduled');

-- Sample data for Medication table
INSERT INTO Treatment (appointment_id, diagnosis, treatment_description)
VALUES (1, 'Healthy', 'No treatment needed, advised routine exercise');

INSERT INTO Treatment (appointment_id, diagnosis, treatment_description)
VALUES (2, 'Flu', 'Prescribed rest and fluids');

INSERT INTO Treatment (appointment_id, diagnosis, treatment_description)
VALUES (3, 'Dermatitis', 'Applied topical cream for skin irritation');

INSERT INTO Treatment (appointment_id, diagnosis, treatment_description)
VALUES (4, 'Arrhythmia', 'Referred to cardiology specialist');

INSERT INTO Treatment (appointment_id, diagnosis, treatment_description)
VALUES (5, 'Arthritis', 'Recommended anti-inflammatory medication and physiotherapy');

INSERT INTO Medication (medication_name, dosage, side_effects)
VALUES ('Paracetamol', '500mg twice a day', 'May cause nausea');

INSERT INTO Medication (medication_name, dosage, side_effects)
VALUES ('Ibuprofen', '200mg three times a day', 'May cause stomach upset');

INSERT INTO Medication (medication_name, dosage, side_effects)
VALUES ('Hydrocortisone cream', 'Apply twice daily', 'May cause skin thinning');

INSERT INTO Medication (medication_name, dosage, side_effects)
VALUES ('Amoxicillin', '500mg every 8 hours', 'May cause diarrhea');

INSERT INTO Medication (medication_name, dosage, side_effects)
VALUES ('Aspirin', '100mg once daily', 'May cause stomach irritation');

-- Sample data for Prescription table
INSERT INTO Prescription (appointment_id, medication_id, quantity, instructions)
VALUES (2, 1, 10, 'Take 1 tablet every 6 hours for 5 days');

INSERT INTO Prescription (appointment_id, medication_id, quantity, instructions)
VALUES (3, 3, 1, 'Apply thin layer to affected area twice daily for 7 days');

INSERT INTO Prescription (appointment_id, medication_id, quantity, instructions)
VALUES (5, 2, 15, 'Take 1 tablet every 8 hours after meals');

INSERT INTO Prescription (appointment_id, medication_id, quantity, instructions)
VALUES (5, 5, 30, 'Take 1 tablet daily in the morning');

INSERT INTO Prescription (appointment_id, medication_id, quantity, instructions)
VALUES (4, 4, 20, 'Take 1 capsule every 8 hours for 7 days');

- ==========================================
-- Query: Retrieve appointment details
-- Description: 
-- This query selects appointment information including:
--   - appointment ID
--   - patient first name (as patient_name)
--   - doctor first name (as doctor_name)
--   - appointment date
--   - appointment status
-- It joins the Appointment table with Patient and Doctor tables
-- to display the names of the patient and doctor for each appointment.
-- ==========================================
SELECT 
    a.appointment_id,
    p.first_name AS patient_name,
    d.first_name AS doctor_name,
    a.appointment_date,
    a.status
FROM Appointment a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id;
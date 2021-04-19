-------------------- DROPPING EXISTING TABLES --------------------
drop table patient cascade constraints;
drop table profile cascade constraints;
drop table profile_phone_number cascade constraints;
drop table login cascade constraints;
drop table blood_stock cascade constraints;
drop table donor cascade constraints;
drop table blood_given cascade constraints;
drop table donated cascade constraints;

-------------------- CREATING TABLES --------------------
CREATE TABLE patient (
    patient_id VARCHAR2(6) PRIMARY KEY,
    blood_type VARCHAR2(2) NOT NULL
);

CREATE TABLE donor (
    donor_id VARCHAR2(6) PRIMARY KEY,
    blood_type VARCHAR2(2) NOT NULL
);

CREATE TABLE profile (
    user_id VARCHAR2(10) PRIMARY KEY,
    fname VARCHAR2(20) NOT NULL,
    lname VARCHAR2(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    donor_id VARCHAR2(6) REFERENCES donor(donor_id),
    patient_id VARCHAR2(6) REFERENCES patient(patient_id)
);

CREATE TABLE profile_phone_number (
    phone_number NUMBER(10) PRIMARY KEY,
    user_id VARCHAR2(10) REFERENCES profile(user_id)
);

CREATE TABLE login (
    username VARCHAR2(30) PRIMARY KEY,
    user_password VARCHAR2(15) NOT NULL,
    user_id VARCHAR2(10) REFERENCES profile(user_id)
);

CREATE TABLE blood_stock (
    blood_id VARCHAR2(6) PRIMARY KEY,
    quantity NUMBER(3) NOT NULL,
    expiration_date DATE NOT NULL
);

CREATE TABLE blood_given (
    patient_id VARCHAR2(6) REFERENCES patient(patient_id),
    blood_id VARCHAR2(6) REFERENCES blood_stock(blood_id)
);

CREATE TABLE donated (
    blood_id VARCHAR2(6) REFERENCES blood_stock(blood_id),
    donor_id VARCHAR2(6) REFERENCES donor(donor_id)
);

-------------------- INSERTING --------------------
INSERT INTO donor VALUES('10001', 'A+');
INSERT INTO profile (user_id, fname, lname, date_of_birth, donor_id) VALUES ('001', 'Dwight', 'Shrute', TO_DATE('3-OCT-2020','DD/MON/YYYY'), '10001');

--INSERT INTO profile VALUES ('002', 'Dwight', 'Shrute', TO_DATE('3-OCT-2020','DD/MON/YYYY'), '10001', '20001');

-------------------- SOME OPERATIONS --------------------
--1 Set operation
SELECT donor_id
FROM donor
WHERE blood_type = 'A'
UNION
SELECT donor_id
FROM donor
WHERE blood_type = 'O';

--2 Join(with condition)
SELECT fname, lname, blood_type 
FROM profile, donor;

--3 Aggregate operation
SELECT SUM(quantity)
FROM blood_stock;

--4 Nested Queries
SELECT blood_type, donor_id
FROM donor
WHERE donor_id = 
(SELECT donor_id 
FROM donor
WHERE blood_type = 'O');

       


-- CREATE DATABASE

CREATE DATABASE HOSPITALWAITLIST;
GO

-- TELL SYSTEM TO USE THIS DATABASE

USE HOSPITALWAITLIST;
GO

-- DROP DATABASE HOSPITALWAITLIST   --  DROP DATABASE IF YOU NEED TO
-- DROP TABLE   -- DROP TABLE IF YOU NEED TO



-- CREATE ALL THE TABLES WITH PRIMARY KEYS ONLY FIRST - THE ORDER IS NOT IMPORTANT

-- PATIENT TABLE
CREATE TABLE Patient(
patientId INT IDENTITY(1,1) PRIMARY KEY,
nhiNumber CHAR(7),
patientFirstName VARCHAR(20),
patientLastName VARCHAR(20),
dateOfBirth DATE,
patientGender VARCHAR(10)
);

-- HOSPITAL DEPARTMENT TABLE
CREATE TABLE Department(
departmentId INT IDENTITY(1,1) PRIMARY KEY,
hospitalDepartment VARCHAR(30),
surgeonName VARCHAR(30)
);

-- APPOINTMENT TABLE
CREATE TABLE Appointment(
appointmentId INT IDENTITY(1,1) PRIMARY KEY,
fsaDate DATE,
waitDate DATE,
patientId INT FOREIGN KEY REFERENCES Patient(patientId),
departmentId INT FOREIGN KEY REFERENCES Department(departmentId)
);

-- REFERRAL TABLE
CREATE TABLE Referral(
refId INT IDENTITY(1,1) PRIMARY KEY,
refDate DATE,
yrMonthSend CHAR(7),
refFrom VARCHAR(30),
refBy VARCHAR(30),
healthTargetElig VARCHAR(3),
patientId INT FOREIGN KEY REFERENCES Patient(patientId),
appointmentId INT FOREIGN KEY REFERENCES Appointment(appointmentId)
);



--BULK INSERTS FROM CLEANED DATA FILES(Patient)
BULK
INSERT Patient
FROM 'C:\Users\Tony\Desktop\BULK_INSERT_FILES\Patient.csv' -- file location
WITH 
(FORMAT = 'CSV',
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO


 -- Check that the data has been loaded correctly
SELECT patientId as 'Patient Id',
nhiNumber as 'NHI Number' ,
patientFirstName as 'Patient First Name',
patientLastName as 'Patient Last Name',
dateOfBirth as 'Date of Birth',
patientGender as 'Patient Gender'
FROM Patient;




--BULK INSERTS FROM CLEANED DATA FILES(Department)
BULK
INSERT Department
FROM 'C:\Users\Tony\Desktop\BULK_INSERT_FILES\department.csv' -- file location
WITH 
(FORMAT = 'CSV',
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

 -- Check that the data has been loaded correctly
SELECT departmentId as 'Department Id',
hospitalDepartment as 'Hospital Department',
surgeonName as 'Surgeon Name'
FROM Department;




--BULK INSERTS FROM CLEANED DATA FILES(Referral)
BULK
INSERT Referral
FROM 'C:\Users\Tony\Desktop\BULK_INSERT_FILES\referral.csv' -- file location
WITH 
(FORMAT = 'CSV',
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO


 -- Check that the data has been loaded correctly
SELECT refId as 'Referral Id',
refDate as 'Referral Date',
yrMonthSend as 'Year Month Send',
refFrom as ' Referred From',
refBy as 'Referred By',
healthTargetElig as 'Health Target Eligible'
FROM Referral;




--BULK INSERTS FROM CLEANED DATA FILES(Appointment)
BULK
INSERT Appointment
FROM 'C:\Users\Tony\Desktop\BULK_INSERT_FILES\appointment.csv' -- file location
WITH 
(FORMAT = 'CSV',
FIRSTROW = 2,
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)
GO

-- Check that the data has been loaded correctly
SELECT appointmentId as ' Appointment Id',
fsaDate as 'FSA Date',
waitDate as 'Waitlist Date'
FROM Appointment;


SELECT nhiNumber -- Data for checking
FROM Patient;



SELECT DATEDIFF(year, dateOfBirth, refDate) AS [Patient Age at Referral] -- Patient Age at Referral = additional fields required by the medical staff
FROM Referral, Patient;

SELECT DATEDIFF(day, refDate, waitDate) AS [Days Waiting from Referral Date] -- Days Waiting from Referral Date = additional fields required by the medical staff
FROM Referral, Appointment;


SELECT dateOfBirth, refDate  -- Data for checking
FROM Referral, Patient; 

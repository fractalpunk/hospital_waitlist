
-- CREATE A DATABASE
CREATE DATABASE HOSPITALWAITLIST;
GO

DROP DATABASE TEST2020;
GO
DROP 

-- TELL SYSTEM TO USE THIS DATABASE
USE HOSPITALWAITLIST;
GO



-- CREATE ALL THE TABLES WITH PRIMARY KEYS ONLY FIRST - THE ORDER IS NOT IMPORTANT
CREATE TABLE [Patient] (
  [patientId] INT NOT NULL,
  [nhiNo] VARCHAR(7),
  [patientName] VARCHAR(30),
  [dateOfBirth] DATE,
  [patientGender] VARCHAR(10),
  PRIMARY KEY ([patientId])
);

CREATE TABLE [Hospital Department] (
  [departmentId] INT,
  [surgeonName] VARCHAR(30),
  PRIMARY KEY ([departmentId])
);

CREATE TABLE [Appointment] (
  [appointmentNo] INT,
  [fsaDate] DATE,
  [waitDate] DATE,
  [patientAgeRef] INT,
  [daysWaitRef] INT,
  [patientId] INT,
  [departmentId] INT,
  PRIMARY KEY ([appointmentNo]),
  CONSTRAINT [FK_Appointment.patientId]
    FOREIGN KEY ([patientId])
      REFERENCES [Patient]([patientId])
);

CREATE TABLE [Referral] (
  [refID] INT,
  [refDate] DATE,
  [yrMonthSend] DATE,
  [refFrom] VARCHAR(30),
  [refBy] VARCHAR(30),
  [healthTargetElig] VARCHAR(3),
  [patientId] INT,
  PRIMARY KEY ([refID])
);


BULK INSERT Patient
FROM 'C:\Users\Tony\Desktop\BULK_INSERT_FILES\Patient.csv'
WITH
	(
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
	)
GO

SELECT * FROM Patient
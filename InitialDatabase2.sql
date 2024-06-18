USE [master]
GO

ALTER DATABASE Laboratory
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE Laboratory
GO

-- Create Database
CREATE DATABASE Laboratory;
GO

-- Select Database
USE Laboratory;
GO


-----------------------------
-- Start Create Table Section
-----------------------------

CREATE TABLE InsuranceType (
    InsuranceTypeID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(150) NOT NULL,
);
GO

CREATE TABLE Patient (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    NationalCode CHAR(10) UNIQUE NOT NULL,
    FirstName NVARCHAR(64) NOT NULL,
    LastName NVARCHAR(64) NOT NULL,
    BirthDate DATE NOT NULL,
    FatherName NVARCHAR(100),
    Gender BIT DEFAULT 0,
    InsuranceTypeID INT FOREIGN KEY (InsuranceTypeID) REFERENCES InsuranceType(InsuranceTypeID) DEFAULT NULL,
    InsuranceCode NVARCHAR(50) DEFAULT NULL
);
GO



CREATE TABLE TestType  (
    TestTypeID INT PRIMARY KEY IDENTITY(1,1),
    TestTitle NVARCHAR(250) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
);
GO

CREATE TABLE TestDetail (
    DetailID INT PRIMARY KEY IDENTITY(1,1),
    TestResult NVARCHAR(300) NOT NULL
);
GO

CREATE TABLE Test (
    TestID INT PRIMARY KEY IDENTITY(1,1),
    TestTypeID int FOREIGN KEY (TestTypeID) REFERENCES TestType(TestTypeID) NOT NULL,
    PatientID int FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) NOT NULL,
    DetailID int FOREIGN KEY (DetailID) REFERENCES TestDetail(DetailID) NOT NULL,
    TestDate DATE NOT NULL,
    ResponseDate DATE,
    DeliveryStatus NVARCHAR(50) NOT NULL
);
GO




------------------------------
-- End Of Create Table Section
------------------------------
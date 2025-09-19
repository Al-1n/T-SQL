-- CREATE DATABASE practice_db;

-- USE practice_db;

/* CREATE TABLE employees (
    Id INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATETIME2, 
    position VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE
);  */

/* CREATE TABLE employees1 (
    Id INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    DateOfBirth DATETIME2, 
    position VARCHAR(100),
    salary DECIMAL(10, 2),
    hire_date DATE
); */

/* SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
 */
-- DROP TABLE employees1;

/* CREATE TABLE Position (
    Id INT PRIMARY KEY IDENTITY,
    position VARCHAR(100) UNIQUE NOT NULL
); */

/* ALTER TABLE employees
ADD JobtitleId INT NOT NULL; */

/* ALTER TABLE employees
ADD FOREIGN KEY (JobtitleId) REFERENCES Position(Id); */

/* ALTER TABLE employees
ADD EmployeeId VARCHAR(10) UNIQUE; */

/* ALTER TABLE employees
ADD EmploymentDate DATETIME2 DEFAULT GETDATE(); */

/* ALTER TABLE employees
DROP COLUMN DateOfBirth
 */

/*  ALTER TABLE employees
 ALTER COLUMN DateOfBirth DATE; */

/* 
 ALTER TABLE employees
 DROP CONSTRAINT DF__employees__Emplo__534D60F1; */
/* 
 ALTER TABLE employees
 ADD CONSTRAINT UQ_EmployeeId UNIQUE(EmployeeId); */

 /* DROP TABLE  employees1*/

 /* To drop a database, first close all connections */
 /* DROP DATABASE practice_db; */
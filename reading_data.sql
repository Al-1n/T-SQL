-- USE AdventureWorks2022;

--Select all data from a table
-- SELECT * FROM HumanResources.Department;
/* 
SELECT * FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer';  */

-- Select top 10 records ordered by HireDate descending
/* SELECT TOP (10) * FROM HumanResources.Employee
ORDER BY HireDate DESC; */

-- Select specific columns from the table
-- SELECT LoginId, JobTitle, HireDate FROM HumanResources.Employee; 

-- Slect only Marketing Assistants
/* SELECT * FROM HumanResources.Employee
WHERE JobTitle = 'Marketing Assistant'; */

-- Select using multiple conditions
/* SELECT * FROM HumanResources.Employee
WHERE JobTitle = 'Marketing Assistant' AND Gender = 'M'; */

-- Sort the data by hire date amd job title 
SELECT * FROM HumanResources.Employee
ORDER BY HireDate DESC, JobTitle ASC;

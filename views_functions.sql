-- Title: Creating Views and Functions in AdventureWorks2022
-- Date: 2025-10-10
-- Author: Alin Airinei
-- Purpose: Create a reference list of useful queries and statements 
--
-- Tags: views, functions, query, statement, adventureworks, creating views, creating functions
-- Usage: Run on local SQL Server with appropriate SA credentials
-- Note: Uncomment the statements to execute them as needed.


-- Example of creating a view to list employees with their department names
/* CREATE OR ALTER VIEW vw_EmployeeDepartments AS
SELECT 
    e.BusinessEntityID,
    p.FirstName,
    p.LastName,
    d.Name AS DepartmentName
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN 
    HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN 
    HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
WHERE 
    edh.EndDate IS NULL; */

-- Select statement to verify the created view
/* SELECT * FROM vw_EmployeeDepartments; */     

-- Example of creating a scalar function to calculate annual salary
/* CREATE OR ALTER FUNCTION dbo.ufn_CalculateAnnualSalary
( @MonthlySalary DECIMAL(10, 2) )
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @MonthlySalary * 12;
END; */     

-- Example of using the scalar function to calculate annual salary for employees
/* SELECT 
    e.BusinessEntityID,
    p.FirstName,
    p.LastName,
    e.Salary,
    dbo.ufn_CalculateAnnualSalary(e.Salary) AS AnnualSalary
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID; */      

-- Note: Uncomment the CREATE VIEW, CREATE FUNCTION, and SELECT statements to execute them as needed.
-- Ensure that the necessary tables exist before running the CREATE VIEW and CREATE FUNCTION statements.
-- The SELECT statements can be used to verify that the view and function have been created correctly.

-- CREATE VIEW statement format: CREATE OR ALTER VIEW Schema.ViewName AS SELECT ...;
-- CREATE FUNCTION statement format: CREATE OR ALTER FUNCTION Schema.FunctionName (Parameters) RETURNS ReturnType AS BEGIN ... END;


-- Example of creating a view to summarize sales data by salesperson
/* CREATE VIEW [Sales].[vw_SalesSummary] AS
SELECT  
    p.FirstName,
    p.LastName,
    COUNT(soh.SalesOrderID) AS NumberOfSales,
    SUM(soh.TotalDue) AS TotalSales,
    AVG(soh.TotalDue) AS AverageSale,
    MIN(soh.TotalDue) AS LowestSale,
    MAX(soh.TotalDue) AS HighestSale 
FROM [Sales].[SalesPerson] AS s
INNER JOIN [Person].[Person] AS p
    ON s.[BusinessEntityID] = p.[BusinessEntityID]
INNER JOIN [Sales].[SalesOrderHeader] soh 
    ON s.[BusinessEntityID] = soh.[SalesPersonID]
GROUP BY p.FirstName, p.LastName
; */

-- Select statement to verify the created sales summary view
/* SELECT * FROM [Sales].[vw_SalesSummary]; */

-- Example of creating a table-valued function to get sales orders by customer
/* GO
CREATE OR ALTER FUNCTION [Sales].[ufn_GetSalesOrdersByCustomer]
(
    @CustomerID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        SalesOrderID,
        OrderDate,
        TotalDue
    FROM 
        [Sales].[SalesOrderHeader]
    WHERE 
        CustomerID = @CustomerID
);
GO */

-- Example of using the table-valued function to get sales orders for a specific customer
/* SELECT * FROM [Sales].[ufn_GetSalesOrdersByCustomer](29845); */  -- Replace 29845 with a valid CustomerID


-- Managing views and functions

-- Drop view if exists
/* DROP VIEW IF EXISTS [Sales].[vw_SalesSummary]; */    

-- Drop function if exists
/* DROP FUNCTION IF EXISTS [Sales].[ufn_GetSalesOrdersByCustomer]; */

-- Insert new sales teritory
-- Insert new sales teritory without rowguid and modifieddate (these will be auto-generated)
/* INSERT INTO [Sales].[SalesTerritory] 
(
    [Name], 
    [CountryRegionCode], 
    [Group]    
)
VALUES
('Jamaica', 'JM', 'LATAM' ); */ 

-- Select statement to verify the inserted SalesTerritory data
/* SELECT * FROM [Sales].[SalesTerritory] WHERE CountryRegionCode = 'JM'; */

-- Insert new sales teritory with generated rowguid and current date for modifieddate
/* INSERT INTO [Sales].[SalesTerritory] 
(
    [Name], 
    [CountryRegionCode], 
    [Group],
    [rowguid],
    [ModifiedDate]
)
VALUES
('Bahamas', 'BS', 'LATAM', NEWID(), GETDATE() ); */     

-- CREATE or ALTER VIEW statement format: CREATE OR ALTER VIEW Schema.ViewName AS SELECT ...;
-- CREATE or ALTER FUNCTION statement format: CREATE OR ALTER FUNCTION Schema.FunctionName (Parameters) RETURNS ReturnType AS BEGIN ... END;

-- Example
/* GO
CREATE OR ALTER VIEW vw_EmployeeDepartments AS
SELECT 
    e.BusinessEntityID,
    p.FirstName,
    p.LastName,
    d.Name AS DepartmentName
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
JOIN 
    HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
JOIN 
    HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
WHERE 
    edh.EndDate IS NULL;    
GO */


-- Select statement to verify the created view
/* SELECT * FROM vw_EmployeeDepartments; */


-- Variables
-- Declare and set a variable
/* DECLARE @CurrencyCode NVARCHAR(3);
SET @CurrencyCode = 'LTC';  */

-- Use the variable in a SELECT statement
/* SELECT * FROM [Sales].[Currency] WHERE CurrencyCode = @CurrencyCode; */      

-- Compare this snippet from inserting_data.sql:
/* SELECT * FROM [Sales].[Currency] WHERE CurrencyCode = 'LTC'; */  

-- Temporary object to store data for the session

/* DECLARE @TempMessage NVARCHAR(100);
SET @TempMessage = 'This is a temporary message stored in a variable.';
  */
-- Use the variable in a SELECT statement
/* SELECT @TempMessage AS Message; 
 */

-- Another option is to use a SELECT statement to store a value in a variable
/* DECLARE @CurrentDate DATETIME;
SELECT @CurrentDate = GETDATE(); */
-- Use the variable in a SELECT statement
/* SELECT @CurrentDate AS CurrentDateTime; 
 */     

-- Once the variable is declared it can be modified with a select statement
/* DECLARE @TempMessage NVARCHAR(100);
SET @TempMessage = 'Initial message.';

 SELECT @TempMessage = 'This is a temporary message stored in a variable.'
 PRINT @TempMessage; */ -- Print the message to the Messages tab

-- Use the variable in a SELECT statement
 /* SELECT @TempMessage AS Message; */



/* DECLARE @HighestSaleFigure DECIMAL(10, 2);
SELECT @HighestSaleFigure = MAX(TotalDue)
FROM [Sales].[SalesOrderHeader]; */

-- Use the variable in a SELECT statement
/* SELECT @HighestSaleFigure AS HighestSale; */ 

-- Another example of using a variable to filter data
/* DECLARE @HighestSaleFigure DECIMAL(10, 2);

SELECT TOP (1)
    @HighestSaleFigure = MAX(TotalDue)
FROM [Sales].[SalesPerson] AS s
INNER JOIN [Person].[Person] AS p
    ON s.[BusinessEntityID] = p.[BusinessEntityID]
INNER JOIN [Sales].[SalesOrderHeader] soh 
    ON s.[BusinessEntityID] = soh.[SalesPersonID]
GROUP BY p.FirstName, p.LastName
ORDER BY MAX(TotalDue) DESC; 

PRINT @HighestSaleFigure*/

-- Use the variable in a SELECT statement
/* SELECT @HighestSaleFigure AS HighestSale; */


-- Example of using a variable in a more complex query
-- Declare a variable to hold a multiplier value
/* DECLARE @multiplier AS INT = 2
SELECT  
    p.FirstName,
    p.LastName,
    COUNT(soh.SalesOrderID) * @multiplier AS DoubleNumberOfSales,
    SUM(soh.TotalDue) * @multiplier AS DoubleTotalSales,
    AVG(soh.TotalDue) * @multiplier AS DoubleAverageSale,
    MIN(soh.TotalDue) * @multiplier AS DoubleLowestSale,
    MAX(soh.TotalDue) * @multiplier AS DoubleHighestSale 
FROM [Sales].[SalesPerson] AS s
INNER JOIN [Person].[Person] AS p
    ON s.[BusinessEntityID] = p.[BusinessEntityID]
INNER JOIN [Sales].[SalesOrderHeader] soh 
    ON s.[BusinessEntityID] = soh.[SalesPersonID]
GROUP BY p.FirstName, p.LastName
; */


-- Functions

-- Example of creating a scalar function to calculate annual salary
/* CREATE OR ALTER FUNCTION dbo.ufn_CalculateAnnualSalary
( @MonthlySalary DECIMAL(10, 2) )
RETURNS DECIMAL(10, 2)
AS
BEGIN
    RETURN @MonthlySalary * 12;
END; */ 

-- Example of using the scalar function to calculate annual salary for employees
/* SELECT 
    e.BusinessEntityID,
    p.FirstName,
    p.LastName,
    e.Salary,
    dbo.ufn_CalculateAnnualSalary(e.Salary) AS AnnualSalary
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID; */
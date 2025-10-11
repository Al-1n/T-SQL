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

    -- Scalar Functions


-- Using built-in scalar functions 
   /*  DECLARE @dateValue AS DATETIME2 = GETDATE()

    SELECT YEAR(@dateValue) AS YearValue,
           MONTH(@dateValue) AS MonthValue,
           DAY(@dateValue) AS DayValue,
           DATENAME(WEEKDAY, @dateValue) AS WeekdayName,
           DATEPART(QUARTER, @dateValue) AS QuarterValue; */ -- Extracting parts of a date


-- Example of creating a scalar function to get full name of an employee
-- This function concatenates first and last names from the Person.Person table based on BusinessEntityID
/* GO
CREATE OR ALTER FUNCTION dbo.ufn_GetEmployeeFullName
( @BusinessEntityID INT )
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @FullName NVARCHAR(100);

    SELECT @FullName = CONCAT(FirstName, ' ', LastName)
    FROM Person.Person
    WHERE BusinessEntityID = @BusinessEntityID;

    RETURN @FullName;
END;
GO */

-- Example of using the scalar function to get full names of employees
/* SELECT 
    e.BusinessEntityID,
    dbo.ufn_GetEmployeeFullName(e.BusinessEntityID) AS FullName,
    e.JobTitle
FROM 
    HumanResources.Employee e
ORDER BY e.BusinessEntityID; */
/* GO
CREATE OR ALTER FUNCTION ufnGetAverageSalesForYear
(
    @Year INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @AverageSales DECIMAL(18, 2)
    
    SELECT @AverageSales = AVG(TotalDue)
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) = @Year
    RETURN @AverageSales
END
GO */

-- Example of using the scalar function to get average sales for a specific year
/* SELECT 
    dbo.ufnGetAverageSalesForYear(2012) AS AverageSales2012,
    TotalDue
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2012 
ORDER BY TotalDue DESC
GO */
 

 -- Table-Valued Functions
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
GO    */

-- Example of using the table-valued function to get sales orders for a specific customer
/* SELECT * FROM [Sales].[ufn_GetSalesOrdersByCustomer](29845); */  -- Replace 29845 with a valid CustomerID

-- Example of creating a table-valued function to get employees by department
/* GO
CREATE OR ALTER FUNCTION dbo.ufn_GetEmployeesByDepartment
( @DepartmentID INT )
RETURNS TABLE
AS
RETURN
(
    SELECT 
        e.BusinessEntityID,
        p.FirstName,
        p.LastName,
        e.JobTitle
    FROM 
        HumanResources.Employee e
    JOIN 
        Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN 
        HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    WHERE 
        edh.DepartmentID = @DepartmentID
        AND edh.EndDate IS NULL
);
GO    */

-- Example of using the table-valued function to get employees for a specific department
/* SELECT * FROM dbo.ufn_GetEmployeesByDepartment(1); */  -- Replace 1 with a valid DepartmentID

-- Another example
/* GO
CREATE OR ALTER FUNCTION dbo.ufn_GetProductsByCategory 
( @CategoryID INT )
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductID,
        p.Name,
        p.ListPrice,
        p.Color
    FROM 
        Production.Product p
    JOIN 
        Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN    
        Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE 
        pc.ProductCategoryID = @CategoryID
);
GO   */

-- Example of using the table-valued function to get products for a specific category
/* SELECT * FROM dbo.ufn_GetProductsByCategory(1); */   -- Replace 1 with a valid ProductCategoryID


-- Another example
/* GO
CREATE OR ALTER FUNCTION dbo.ufn_GetProductsWithInventoryGreaterThan(@count int)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductID,
        p.Name,
        p.ListPrice,
        SUM(pi.Quantity) AS TotalInventory
    FROM 
        Production.Product p
    JOIN 
        Production.ProductInventory pi ON p.ProductID = pi.ProductID
    GROUP BY 
        p.ProductID, p.Name, p.ListPrice
    HAVING 
        SUM(pi.Quantity) > @count
);
GO       */

-- Example of using the table-valued function to get products with inventory greater than a specified count
/* SELECT * FROM dbo.ufn_GetProductsWithInventoryGreaterThan(50); */  -- Replace 50 with the desired inventory count threshold

GO
CREATE OR ALTER FUNCTION dbo.ufn_GetProductsWithInventoryGreaterThan(@count int)
RETURNS TABLE
AS
RETURN

    SELECT 
        p.Name,
        p.ProductNumber,
        pi.Quantity,
        loc.Name [Location],
        SUM(pi.Quantity) AS TotalInventory
    FROM 
        Production.Product p
    JOIN 
        Production.ProductInventory pi ON p.ProductID = pi.ProductID
    JOIN [Production].[Location] loc ON pi.LocationID = loc.LocationID
    GROUP BY  p.Name, p.ProductNumber, pi.Quantity, loc.Name
    HAVING 
        SUM(pi.Quantity) > @count;
GO     

SELECT * FROM [dbo].[ufn_GetProductsWithInventoryGreaterThan](800);

-- End 
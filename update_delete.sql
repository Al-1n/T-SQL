-- Title: IUpdating and deleting data in AdventureWorks2022
-- Date: 2025-10-09
-- Author: Alin Airinei
-- Purpose: Create a reference list of useful queriesstatements for updating data in a database
--
-- Tags: update, delete, statement, adventureworks, updating data
-- Usage: Run on local SQL Server with appropriate SA credentials
-- Note: Uncomment the statements to execute them as needed.

-- The UPDATE statement format: UPDATE Schema.Table SET Column1 = Value1, Column2 = Value2, ... WHERE Condition;

-- Example:
-- Update the email and salary of an employee in the 'employees' table
/* UPDATE employees
SET email = 'jlewis33@advworks.com', salary = 62000
WHERE id = 1; */       
-- Select statement to verify the updated employee data
/* SELECT * FROM employees WHERE id = 1; */ 


-- Example 2:
-- Update sales person's territory in the 'Sales.SalesPerson' table

/* UPDATE [Sales].[SalesPerson]
SET TerritoryID = 4, SalesQuota = 600000
WHERE BusinessEntityID = 274; */
-- Select statement to verify the updated sales person data
/* SELECT * FROM [Sales].[SalesPerson] WHERE BusinessEntityID = 274; */ 

-- Example 3:
/* UPDATE [Person].[Person]
SET EmailPromotion = 1
WHERE BusinessEntityID = 1; */
-- Select statement to verify the updated person data
/* SELECT * FROM [Person].[Person] WHERE BusinessEntityID = 1; */

-- Example 4:
/* UPDATE [Person].[Person]
SET Title = 'Dr.'
WHERE BusinessEntityID = 2; */
-- Select statement to verify the updated person data
/* SELECT * FROM [Person].[Person] WHERE BusinessEntityID = 2; */

-- Example 5:
/* UPDATE [Sales].[Customer]
SET AccountNumber = 'AW00012345'
WHERE CustomerID = 1; */
-- Select statement to verify the updated customer data
/* SELECT * FROM [Sales].[Customer] WHERE CustomerID = 1; */    

-- Example 6:
/* UPDATE [Production].[Product]
SET ListPrice = 25.99
WHERE ProductID = 1; */
-- Select statement to verify the updated product data
/* SELECT * FROM [Production].[Product] WHERE ProductID = 1; */

-- Example 7:
/* UPDATE [Person].[Person]
SET Title = 'Mr.', MiddleName = 'A.'
WHERE BusinessEntityID = 3; */
-- Select statement to verify the updated person data
/* SELECT * FROM [Person].[Person] WHERE BusinessEntityID = 3; */  

-- Example 8: Update a person's address using a JOIN
/* UPDATE [Person].[Person] SET EmailPromotion = 2
FROM [Person].[Person] P
INNER JOIN [Person].[BusinessEntityAddress] BE ON P.BusinessEntityID = BE.BusinessEntityID
INNER JOIN [Person].[Address] A ON BE.AddressID = A.AddressID
WHERE A.City = 'Redmond'; */
-- Select statement to verify the updated person data
/* SELECT * FROM [Person].[Person] WHERE BusinessEntityID IN 
(SELECT P.BusinessEntityID
FROM [Person].[Person] P
INNER JOIN [Person].[BusinessEntityAddress] BE ON P.BusinessEntityID = BE.BusinessEntityID
INNER JOIN [Person].[Address] A ON BE.AddressID = A.AddressID
WHERE A.City = 'Redmond');  */  

-- Example 9: Update sales person's commision percentage using a JOIN
/* UPDATE SP SET CommissionPct = 0.15
FROM [Sales].[SalesPerson] SP
INNER JOIN [Sales].[SalesTerritory] ST ON SP.TerritoryID = ST.TerritoryID
WHERE ST.Name = 'Northwest'; */
-- Select statement to verify the updated sales person data
/* SELECT * FROM [Sales].[SalesPerson] WHERE BusinessEntityID IN 
(SELECT SP.BusinessEntityID
FROM [Sales].[SalesPerson] SP
INNER JOIN [Sales].[SalesTerritory] ST ON SP.TerritoryID = ST.TerritoryID
WHERE ST.Name = 'Northwest');  */   

-- Example 10: Update bonus for a specific region
/* UPDATE [Sales].[SalesPerson]
SET Bonus = Bonus + (Bonus * 0.10)  -- Increase bonus by 10%
FROM [Sales].[SalesPerson] SP
INNER JOIN [Sales].[SalesTerritory] ST ON SP.TerritoryID = ST.TerritoryID
WHERE SP.TerritoryID = (SELECT TerritoryID FROM [Sales].[SalesTerritory] WHERE Name = 'Southwest'); */
-- Select statement to verify the updated sales person data
/* SELECT * FROM [Sales].[SalesPerson] WHERE TerritoryID = (SELECT TerritoryID FROM [Sales].[SalesTerritory] WHERE Name = 'Southwest');  */

-- Example 11: Update using a CTE

/* WITH RecentOrders AS (
    SELECT SalesOrderID, TotalDue,
           ROW_NUMBER() OVER (ORDER BY OrderDate DESC) AS rn
    FROM [Sales].[SalesOrderHeader]
)
UPDATE RecentOrders
SET TotalDue = TotalDue * 1.05  -- Increase TotalDue by 5%
WHERE rn <= 5;  -- Update the 5 most recent orders */
-- Select statement to verify the updated orders
/* SELECT * FROM [Sales].[SalesOrderHeader] WHERE SalesOrderID IN 
(SELECT SalesOrderID FROM (
    SELECT SalesOrderID, TotalDue,
           ROW_NUMBER() OVER (ORDER BY OrderDate DESC) AS rn
    FROM [Sales].[SalesOrderHeader]
) AS RecentOrders WHERE rn <= 5);  */   

-- Example 12: Update with a subquery
/* UPDATE [Production].[Product]
SET ListPrice = ListPrice * 0.90  -- Decrease ListPrice by 10%
WHERE ProductID IN (SELECT ProductID FROM [Production].[Product] WHERE Color = 'Red'); */
-- Select statement to verify the updated products
/* SELECT * FROM [Production].[Product] WHERE Color = 'Red';  */    

-- Example 13: Another CTE example
/* WITH TopCustomers AS (
    SELECT CustomerID, SUM(TotalDue) AS TotalSpent,
           ROW_NUMBER() OVER (ORDER BY SUM(TotalDue) DESC) AS rn
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID
) */
/* UPDATE TopCustomers
SET TotalSpent = TotalSpent * 1.10  -- Increase TotalSpent by 10%
WHERE rn <= 3;  -- Update the top 3 customers */
-- Select statement to verify the updated customers
/* SELECT * FROM [Sales].[SalesOrderHeader] WHERE CustomerID IN 
(SELECT CustomerID FROM (
    SELECT CustomerID, SUM(TotalDue) AS TotalSpent,
           ROW_NUMBER() OVER (ORDER BY SUM(TotalDue) DESC) AS rn
    FROM [Sales].[SalesOrderHeader]
    GROUP BY CustomerID
) AS TopCustomers WHERE rn <= 3);  */

-- Example 14: Update with a correlated subquery
/* UPDATE [Person].[Person]
SET EmailPromotion = EmailPromotion + 1
WHERE BusinessEntityID IN (
    SELECT DISTINCT P.BusinessEntityID
    FROM [Person].[Person] P
    INNER JOIN [Person].[BusinessEntityAddress] BE ON P.BusinessEntityID = BE.BusinessEntityID
    INNER JOIN [Person].[Address] A ON BE.AddressID = A.AddressID
    WHERE A.StateProvinceID = 79  -- Assuming 79 is the ID for a specific state
); */
-- Select statement to verify the updated person data
/* SELECT * FROM [Person].[Person] WHERE BusinessEntityID IN 
(SELECT DISTINCT P.BusinessEntityID
FROM [Person].[Person] P
INNER JOIN [Person].[BusinessEntityAddress] BE ON P.BusinessEntityID = BE.BusinessEntityID
INNER JOIN [Person].[Address] A ON BE.AddressID = A.AddressID
WHERE A.StateProvinceID = 79);  */  

-- Example 15: Another CTE example
/* WITH CTE 
AS
(
    SELECT [BusinessEntityID], [Bonus], [CommissionPCT]
    FROM [Sales].[SalesPerson] SP
    INNER JOIN [Sales].[SalesTerritory] ST ON SP.TerritoryID = ST.TerritoryID
    WHERE ST.Name = 'Northwest' 
)
UPDATE CTE SET Bonus = Bonus * 1.15  -- Increase Bonus by 15%
WHERE CommissionPCT < 0.10;  */ -- Only for those with CommissionPCT less than 10%
-- Select statement to verify the updated sales person data
/* SELECT * FROM [Sales].[SalesPerson] WHERE BusinessEntityID IN 
(SELECT [BusinessEntityID] FROM [Sales].[SalesPerson] SPACE
INNER JOIN [Sales].[SalesTerritory] ST ON SPACE.TerritoryID = ST.TerritoryID
WHERE ST.Name = 'Northwest' AND CommissionPCT < 0.10);  */  


-- The DELETE statement format: DELETE FROM Schema.Table WHERE Condition;

-- Create a table to demonstrate DELETE operations
/* CREATE TABLE TestDeleteTable (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
); */

-- Insert sample data into TestDeleteTable
/* INSERT INTO TestDeleteTable (ID, Name) VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie'); */       

-- Example 1: Delete a specific record
/* DELETE FROM TestDeleteTable WHERE ID = 2; */
-- Select statement to verify the deletion
/* SELECT * FROM TestDeleteTable; */        


-- CREATE A TABLE USING SELECT INTO and insert data into SalesTerritory

/* DROP TABLE [Person].[PersonDEMO]; */
/* SELECT * INTO [Person].[PersonDEMO]
FROM [Person].[Person]
WHERE BusinessEntityID <= 10; */

-- Verify the inserted data
/* SELECT * FROM [Person].[PersonDEMO]; */

-- Example 2: Delete multiple records based on a condition
/* DELETE FROM Person.PersonDEMO WHERE BusinessEntityID > 5; */
-- Select statement to verify the deletion
/* SELECT * FROM Person.PersonDEMO; */

-- To delete all rows from a table (use with caution)
/* DELETE FROM TestDeleteTable; */
-- Select statement to verify the table is empty
/* SELECT * FROM TestDeleteTable; */

-- Drop the TestDeleteTable after demonstration
/* DROP TABLE TestDeleteTable; */   

-- TRUNCATE statement to remove all rows from a table
-- Note: TRUNCATE is faster and uses fewer system and transaction log resources than DELETE.
-- It also resets any identity columns.
-- Example:
/* TRUNCATE TABLE Person.PersonDEMO; */
-- Select statement to verify the table is empty
/* SELECT * FROM Person.PersonDEMO; */      

-- Drop the PersonDEMO table after demonstration
/* DROP TABLE Person.PersonDEMO; */ 

-- The delete and inner join statements do not work together in SQL Server.
-- Instead, use a subquery or CTE to achieve similar results.
-- Example of deleting with a subquery
/* DELETE FROM [Sales].[SalesPerson]
WHERE BusinessEntityID IN (
    SELECT SP.BusinessEntityID
    FROM [Sales].[SalesPerson] SP
    INNER JOIN [Sales].[SalesTerritory] ST ON SP.TerritoryID = ST.TerritoryID
    WHERE ST.Name = 'Northwest'
); */
-- Select statement to verify the deletion
/* SELECT * FROM [Sales].[SalesPerson] WHERE BusinessEntityID IN 
(SELECT SP.BusinessEntityID
FROM [Sales].[SalesPerson] SP
INNER JOIN [Sales].[SalesTerritory] ST ON SP.TerritoryID = ST.TerritoryID
WHERE ST.Name = 'Northwest');  */   


-- CASCADE DELETE example
-- Note: Ensure that foreign key relationships are set to ON DELETE CASCADE for this to work
-- Example: Deleting a sales territory will also delete related sales persons
/* DELETE FROM [Sales].[SalesTerritory] WHERE TerritoryID = 4; */
-- Select statement to verify the deletion
/* SELECT * FROM [Sales].[SalesTerritory] WHERE TerritoryID = 4; */
/* SELECT * FROM [Sales].[SalesPerson] WHERE TerritoryID = 4; */    


-- Example 2: CASCADE DELETE with a CTE
/* WITH CTE AS (
    SELECT ST.TerritoryID
    FROM [Sales].[SalesTerritory] ST
    WHERE ST.Name = 'Southwest'
)
DELETE FROM [Sales].[SalesTerritory]
WHERE TerritoryID IN (SELECT TerritoryID FROM CTE); */
-- Select statement to verify the deletion
/* SELECT * FROM [Sales].[SalesTerritory] WHERE Name = 'Southwest'; */
/* SELECT * FROM [Sales].[SalesPerson] WHERE TerritoryID NOT IN (SELECT TerritoryID FROM [Sales].[SalesTerritory]); */      

-- Example 3: Delete with a subquery
/* DELETE FROM [Person].[Person]
WHERE BusinessEntityID IN (
    SELECT P.BusinessEntityID
    FROM [Person].[Person] P
    INNER JOIN [Person].[BusinessEntityAddress] BE ON P.BusinessEntityID = BE.BusinessEntityID
    INNER JOIN [Person].[Address] A ON BE.AddressID = A.AddressID
    WHERE A.City = 'Redmond'
); */
-- Select statement to verify the deletion
/* SELECT * FROM [Person].[Person] WHERE BusinessEntityID IN 
(SELECT P.BusinessEntityID
FROM [Person].[Person] P
INNER JOIN [Person].[BusinessEntityAddress] BE ON P.BusinessEntityID = BE.BusinessEntityID
INNER JOIN [Person].[Address] A ON BE.AddressID = A.AddressID
WHERE A.City = 'Redmond');  */


--Exaample 4: Casacade delete

-- Create related tables to demonstrate CASCADE DELETE

/* CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY,
    DepartmentName NVARCHAR(100)
);
GO  */

/* CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY IDENTITY,
    EmployeeName NVARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
);
GO */
-- Insert sample data into Departments and Employees
/* INSERT INTO Departments (DepartmentName) VALUES ('HR'), ('IT'), ('Finance');
GO
INSERT INTO Employees (EmployeeName, DepartmentID) VALUES
('Alice', 1),
('Bob', 1),
('Charlie', 2),
('David', 2),
('Eve', 3);
GO */

-- Select to verify inserted data
/* SELECT * FROM Departments;
SELECT * FROM Employees; */

-- Delete a department and observe CASCADE DELETE effect on Employees
DELETE FROM Departments WHERE DepartmentID = 2; -- Deleting 'IT' department
-- Select to verify deletion
SELECT * FROM Departments;
SELECT * FROM Employees; -- Employees in 'IT' department should be deleted

-- Drop the tables after demonstration
/* DROP TABLE Employees;
DROP TABLE Departments; */

-- Without the CASCADE DELETE, the delete operation would fail if there are related records in the Employees table.

-- End of examples
-- Title: T-SQL Stored Procedures, Triggers and Cursors Reference
-- Date: 2025-10-15
-- Author: Alin Airinei
-- Purpose: Create a reference list of useful queries and statements 
--
-- Tags: T-SQL, stored procedures, triggers, cursors, reference
-- Usage: Run on local SQL Server with appropriate SA credentials
-- Note: Uncomment the statements to execute them as needed.


-- Stored Procedures are precompiled collections of T-SQL statements that can be executed as a single unit.
-- They can accept parameters, return results, and improve performance by reducing network traffic.
-- They are created using the CREATE PROCEDURE statement and executed with the EXEC or EXECUTE command

-- Format:
-- CREATE PROCEDURE procedure_name
-- AS
-- BEGIN
--     -- SQL statements
-- END;
-- GO


-- Example: Create a stored procedure to get employee count from AdventureWorks2022 database

-- Example: Create a simple stored procedure
/* 
CREATE PROCEDURE GetEmployeeCount
AS
BEGIN
    SELECT COUNT(*) AS EmployeeCount FROM AdventureWorks2022.HumanResources.Employee;
END;
GO

-- Example: Execute the stored procedure
EXEC GetEmployeeCount; */   
  

 -- Example: Create a stored procedure with parameters

/* CREATE PROCEDURE GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT p.FirstName, p.LastName 
    FROM AdventureWorks2022.HumanResources.Employee AS e
    INNER JOIN AdventureWorks2022.HumanResources.EmployeeDepartmentHistory AS edh
        ON e.BusinessEntityID = edh.BusinessEntityID
    INNER JOIN AdventureWorks2022.Person.Person AS p
        ON e.BusinessEntityID = p.BusinessEntityID
    WHERE edh.DepartmentID = @DepartmentID
      AND edh.EndDate IS NULL; -- Only current department assignments
END;
GO  

-- Example: Execute the stored procedure with a parameter
EXEC GetEmployeesByDepartment @DepartmentID = 1;
-- Note: Replace 1 with the desired DepartmentID   */

-- Altering a stored procedure
-- Use ALTER PROCEDURE instead of CREATE PROCEDURE to modify an existing stored procedure
-- Example: Alter the GetEmployeeCount procedure to include department filter
/*
ALTER PROCEDURE GetEmployeeCount
    @DepartmentID INT = NULL
AS
BEGIN
    IF @DepartmentID IS NULL
    BEGIN
        SELECT COUNT(*) AS EmployeeCount FROM AdventureWorks2022.HumanResources.Employee;
    END
    ELSE
    BEGIN
        SELECT COUNT(*) AS EmployeeCount 
        FROM AdventureWorks2022.HumanResources.Employee AS e
        INNER JOIN AdventureWorks2022.HumanResources.EmployeeDepartmentHistory AS edh
            ON e.BusinessEntityID = edh.BusinessEntityID
        WHERE edh.DepartmentID = @DepartmentID
          AND edh.EndDate IS NULL; -- Only current department assignments
    END
END;
GO      

-- Dropping a stored procedure
-- Use DROP PROCEDURE to remove an existing stored procedure
-- Example: Drop the GetEmployeeCount procedure
-- DROP PROCEDURE GetEmployeeCount; */


-- Another example
-- Example: Create a stored procedure to get product details by category

CREATE OR ALTER PROCEDURE GetProductsByCategory
    @CategoryID INT
AS
BEGIN
    SELECT p.Name, p.ProductNumber, p.ListPrice
    FROM AdventureWorks2022.Production.Product AS p
    INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN AdventureWorks2022.Production.ProductCategory AS pc
        ON ps.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.ProductCategoryID = @CategoryID;
END;
GO      

-- Example: Execute the stored procedure with a parameter
EXEC GetProductsByCategory @CategoryID = 1;
-- Note: Replace 1 with the desired CategoryID  


-- Another example
/* CREATE OR ALTER PROC sp_person @ID INT, @PT VARCHAR(5)
AS
BEGIN
    SELECT * FROM [Person].[Person] WHERE BusinessEntityID > @ID -- 0 = All, > 0 = Specific ID 
     AND PersonType = @PT -- 'EM' = Employee, 'SC' = Store Contact, 'EME' = Employee (External)

    IF @@ROWCOUNT = 0 -- @@ROWCOUNT holds the number of rows affected by the last statement
        PRINT 'No rows found'
    ELSE
        PRINT CAST(@@ROWCOUNT AS VARCHAR(10)) + ' rows found'   -- CAST is used to convert @@ROWCOUNT (an integer) to VARCHAR for concatenation
END
GO */

-- EXEC sp_person 100, 'EM'
-- EXEC sp_person 0, 'EM'
-- EXEC sp_person 0, 'SC'
-- EXEC sp_person 0, 'EME'  -- No rows found
-- EXEC sp_person 0, 'EME'; EXEC sp_person 0, 'SC'  -- Two separate calls
-- EXEC sp_person 0, 'EM'; EXEC sp_person 0, 'SC'  -- Two separate calls
-- EXEC sp_person 0, 'EM'; SELECT 'After first call'; EXEC sp_person 0, 'SC'  -- Two separate calls with message in between
-- EXEC sp_person 0, 'EM'; PRINT 'After first call'; EXEC sp_person 0, 'SC'  -- Two separate calls with message in between
-- EXEC sp_person 0, 'EM'; PRINT 'After first call'; EXEC sp_person 0, 'EME'  -- Second call returns no rows
-- EXEC sp_person 0, 'EM'; PRINT 'After first call'; EXEC sp_person 0, 'EME'; PRINT 'After second call'  -- Both calls with messages in between
-- EXEC sp_person 0, 'EM'; PRINT 'After first call'; EXEC sp_person 0, 'EME'; PRINT 'After second call'; EXEC sp_person 0, 'SC'  -- All three calls with messages in between
-- EXEC sp_person 0, 'EM'; PRINT 'After first call'; EXEC sp_person 0, 'EME'; PRINT 'After second call'; EXEC sp_person 0, 'SC'; PRINT 'After third call'  -- All three calls with messages in between
-- EXEC sp_person 0, 'EM'; PRINT 'After first call'; EXEC sp_person 0, 'EME'; PRINT 'After second call'; EXEC sp_person 0, 'EME'; PRINT 'After third call'  -- Last two calls return no rows
-- EXEC sp_person 0, 'EM'; PRINT 'After first call'; EXEC sp_person


-- DROP PROC sp_person
-- GO

-- Example: Stored procedure with OUTPUT parameter
-- This procedure retrieves the maximum BusinessEntityID from the Person.Person table and returns it via an OUTPUT parameter.
-- The OUTPUT parameter allows the procedure to return a value back to the caller.
-- Example usage is shown below the procedure definition.
/* CREATE OR ALTER PROC sp_FindMaxPerson (@max INT OUTPUT) 
AS
BEGIN
    SELECT @max = MAX(BusinessEntityID) FROM [Person].[Person]
END
GO

DECLARE @max INT -- Declare variable to hold output
EXEC sp_FindMaxPerson @max OUTPUT -- Execute procedure with OUTPUT parameter
SELECT @max AS MaxBusinessEntityID -- Display the result */

-- DROP PROC sp_FindMaxPerson
-- GO   

-- Note: Stored procedures can also include error handling using TRY...CATCH blocks, transaction management, and complex logic as needed.

-- Another example: Retrieve all the employee information as well as the count of employees in that department stored in an output variable
/* CREATE OR ALTER PROC sp_GetEmployeesByDept
    @EmployeeID INT = NULL,  -- Optional parameter to filter by specific employee
    @DepartmentID INT,
    @EmployeeCount INT OUTPUT
AS
BEGIN
    SELECT p.FirstName, p.LastName, e.JobTitle
    FROM AdventureWorks2022.HumanResources.Employee AS e
    INNER JOIN AdventureWorks2022.HumanResources.EmployeeDepartmentHistory AS edh
        ON e.BusinessEntityID = edh.BusinessEntityID
    INNER JOIN AdventureWorks2022.Person.Person AS p
        ON e.BusinessEntityID = p.BusinessEntityID
    WHERE edh.DepartmentID = @DepartmentID
       AND (@EmployeeID IS NULL OR e.BusinessEntityID = @EmployeeID) -- Filter by EmployeeID if provided 
      AND edh.EndDate IS NULL; -- Only current department assignments   

    SELECT @EmployeeCount = COUNT(*)
    FROM AdventureWorks2022.HumanResources.Employee AS e
    INNER JOIN AdventureWorks2022.HumanResources.EmployeeDepartmentHistory AS edh
        ON e.BusinessEntityID = edh.BusinessEntityID
    WHERE edh.DepartmentID = @DepartmentID
      AND edh.EndDate IS NULL; -- Only current department assignments
END
GO  

-- Example: Execute the stored procedure with a parameter and capture the output
DECLARE @EmpCount INT
EXEC sp_GetEmployeesByDept @EmployeeID = 5, @DepartmentID = 1, @EmployeeCount = @EmpCount OUTPUT
SELECT @EmpCount AS EmployeeCountInDepartment */
-- Note: Replace 1 with the desired DepartmentID     

-- Triggers
-- Triggers are special types of stored procedures that automatically execute in response to certain events on a table or view, such as INSERT, UPDATE, or DELETE operations.
-- They are used to enforce business rules, maintain audit trails, and ensure data integrity.
-- They are created using the CREATE TRIGGER statement.
-- Example: Create a trigger that logs changes to the Employee table
/*
CREATE TRIGGER trg_AuditEmployeeChanges
ON AdventureWorks2022.HumanResources.Employee
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Action NVARCHAR(10);   
    IF EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
        SET @Action = 'UPDATE';
    ELSE IF EXISTS(SELECT * FROM inserted)
        SET @Action = 'INSERT';
    ELSE
        SET @Action = 'DELETE'; 
    INSERT INTO AuditEmployeeChanges (Action, ChangeDate)
    VALUES (@Action, GETDATE());
END;
GO */
-- Note: Replace AuditEmployeeChanges with your actual audit table name and structure.
-- DROP TRIGGER trg_AuditEmployeeChanges
-- GO

-- Types of triggers:
-- AFTER Triggers: Execute after the triggering SQL statement completes. They can be used for enforcing business rules and maintaining audit trails.
-- INSTEAD OF Triggers: Execute in place of the triggering SQL statement. They are often used on views to allow updates that would otherwise be disallowed.
-- DDL Triggers: Execute in response to Data Definition Language (DDL) events such as CREATE, ALTER, or DROP statements. They are used for auditing and controlling changes to database schema.
-- Logon Triggers: Execute in response to LOGON events. They can be used to control login behavior, such as restricting access based on time of day or logging login attempts.
-- Note: Triggers should be used judiciously as they can add complexity and impact performance.



-- Cursors
-- Cursors are database objects used to retrieve, manipulate, and navigate through a result set row by row.
-- They are useful when you need to perform operations on each row individually, such as complex calculations or conditional logic that cannot be easily achieved with set-based operations.
-- Cursors are created using the DECLARE CURSOR statement and are controlled with OPEN, FETCH, and CLOSE statements.
-- Example: Create and use a cursor to iterate through employees and print their names
/*
DECLARE employee_cursor CURSOR FOR
SELECT FirstName, LastName FROM AdventureWorks2022.Person.Person
WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM AdventureWorks2022.HumanResources.Employee);    
OPEN employee_cursor;
DECLARE @FirstName NVARCHAR(50), @LastName NVARCHAR(50);
FETCH NEXT FROM employee_cursor INTO @FirstName, @LastName;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @FirstName + ' ' + @LastName;
    FETCH NEXT FROM employee_cursor INTO @FirstName, @LastName;
END;
CLOSE employee_cursor;
DEALLOCATE employee_cursor; */
-- Note: Cursors can be resource-intensive and should be used sparingly. Set-based operations are generally preferred for performance reasons.
-- Types of cursors:
-- STATIC: Provides a snapshot of the result set. Changes made to the underlying data after the cursor is opened are not reflected in the cursor.
-- DYNAMIC: Reflects all changes made to the rows in the result set as you scroll around the cursor. This includes inserts, updates, and deletes.
-- KEYSET: The set of keys that uniquely identify rows in the result set is fixed when the cursor is opened. Changes to non-key values are reflected, but new rows added to the result set are not visible.
-- FAST_FORWARD: A read-only, forward-only cursor that is optimized for performance. It is similar to a STATIC cursor but with fewer features.
-- Note: Always close and deallocate cursors to free up resources.  


-- Another example
-- Example: Cursor to update employee titles based on a condition
/*
DECLARE emp_cursor CURSOR FOR
SELECT BusinessEntityID, JobTitle FROM AdventureWorks2022.HumanResources.Employee
WHERE JobTitle IS NOT NULL;
OPEN emp_cursor;
DECLARE @BusinessEntityID INT, @JobTitle NVARCHAR(50);
FETCH NEXT FROM emp_cursor INTO @BusinessEntityID, @JobTitle;
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @JobTitle = 'Sales Representative'
    BEGIN
        UPDATE AdventureWorks2022.HumanResources.Employee
        SET JobTitle = 'Senior Sales Representative'
        WHERE BusinessEntityID = @BusinessEntityID;
    END
    FETCH NEXT FROM emp_cursor INTO @BusinessEntityID, @JobTitle;
END;
CLOSE emp_cursor;
DEALLOCATE emp_cursor; */
-- Note: This example updates job titles for employees who are currently 'Sales Representative' to 'Senior Sales Representative'.
-- Always ensure that cursors are properly closed and deallocated to avoid memory leaks and performance issues.

-- Another example
-- Example: Cursor to calculate and print the total sales for each salesperson
/*
DECLARE sales_cursor CURSOR FOR
SELECT SalesPersonID, SUM(TotalDue) AS TotalSales
FROM AdventureWorks2022.Sales.SalesOrderHeader
GROUP BY SalesPersonID;
OPEN sales_cursor;
DECLARE @SalesPersonID INT, @TotalSales MONEY;
FETCH NEXT FROM sales_cursor INTO @SalesPersonID, @TotalSales;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'SalesPersonID: ' + CAST(@SalesPersonID AS NVARCHAR(10)) + ', Total Sales: ' + CAST(@TotalSales AS NVARCHAR(20));
    FETCH NEXT FROM sales_cursor INTO @SalesPersonID, @TotalSales;
END;
CLOSE sales_cursor;
DEALLOCATE sales_cursor; */
-- Note: This example calculates the total sales for each salesperson and prints the results.
-- Always ensure that cursors are properly closed and deallocated to avoid memory leaks and performance issues.

-- Another example
-- Example: Cursor to delete employees who have not been active since a specific date
/*
DECLARE delete_cursor CURSOR FOR
SELECT BusinessEntityID FROM AdventureWorks2022.HumanResources.Employee
WHERE HireDate < '2000-01-01'; -- Example condition
OPEN delete_cursor;
DECLARE @BusinessEntityID INT;
FETCH NEXT FROM delete_cursor INTO @BusinessEntityID;
WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM AdventureWorks2022.HumanResources.Employee
    WHERE BusinessEntityID = @BusinessEntityID;
    FETCH NEXT FROM delete_cursor INTO @BusinessEntityID;
END;
CLOSE delete_cursor;
DEALLOCATE delete_cursor; */
-- Note: This example deletes employees who were hired before January 1, 2000.
-- Always ensure that cursors are properly closed and deallocated to avoid memory leaks and performance issues.

-- Another example
DECLARE productsCR CURSOR STATIC
FOR
SELECT TOP(10)
    [ProductID],
    [Name],
    [ProductNumber],
    [Color],
    [SafetyStockLevel],
    [ReorderPoint],
    [StandardCost],
    [ListPrice]
FROM [AdventureWorks2022].[Production].[Product]
WHERE [Color] IS NOT NULL
ORDER BY [ListPrice] DESC   

OPEN productsCR
DECLARE @ProductID INT,
        @Name NVARCHAR(50),
        @ProductNumber NVARCHAR(25),
        @Color NVARCHAR(15),
        @SafetyStockLevel SMALLINT,
        @ReorderPoint SMALLINT,
        @StandardCost MONEY,
        @ListPrice MONEY 
FETCH NEXT FROM productsCR INTO
    @ProductID,
    @Name,
    @ProductNumber,
    @Color,
    @SafetyStockLevel,
    @ReorderPoint,
    @StandardCost,
    @ListPrice
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'ProductID: ' + CAST(@ProductID AS NVARCHAR(10)) +
          ', Name: ' + @Name +
          ', ProductNumber: ' + @ProductNumber +
          ', Color: ' + @Color +
          ', SafetyStockLevel: ' + CAST(@SafetyStockLevel AS NVARCHAR(10)) +
          ', ReorderPoint: ' + CAST(@ReorderPoint AS NVARCHAR(10)) +
          ', StandardCost: ' + CAST(@StandardCost AS NVARCHAR(20)) +
          ', ListPrice: ' + CAST(@ListPrice AS NVARCHAR(20))
    FETCH NEXT FROM productsCR INTO
        @ProductID,
        @Name,
        @ProductNumber,
        @Color,
        @SafetyStockLevel,
        @ReorderPoint,
        @StandardCost,
        @ListPrice
END
CLOSE productsCR
DEALLOCATE productsCR   



-- End of stored procedures, triggers, and cursors reference




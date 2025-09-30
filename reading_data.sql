-- Title: Reading Data from AdventureWorks2022
-- Date: 2025-09-30
-- Author: Alin Airinei
-- Purpose: Create a reference list of useful queries for reading data from AdventureWorks2022
--
-- Tags: select, query, adventureworks, reading data
-- Usage: Run on local SQL Server with appropriate SA credentials
-- 
-- 2025-09-30: Added more queries and comments for clarity
-- Previous queries kept commented for reference
-- Ensure you are using the correct database


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
/* SELECT * FROM HumanResources.Employee
ORDER BY HireDate DESC, JobTitle ASC; */

-- Select using wildcards
-- Select records with the word "Engineer" in the JobTitle
/* SELECT * FROM HumanResources.Employee
WHERE JobTitle LIKE '%Engineer%'; -- Job titles that include "Engineer" */

/* SELECT * FROM HumanResources.Employee
WHERE JobTitle LIKE 'Design%'; -- Job titles that start with "Design" */

/* SELECT * FROM HumanResources.Employee
WHERE JobTitle LIKE '%Engineer'; -- Job titles that end with "Engineer" */

-- Select records with a specific pattern in the LoginId
/* SELECT * FROM HumanResources.Employee
WHERE LoginId LIKE '_a%'; -- LoginIds with 'a' as the second character

SELECT * FROM HumanResources.Employee
WHERE LoginId LIKE 'a__%'; -- LoginIds starting with 'a' and at least 3 characters long */  

-- Select records with a specific pattern in the JobTitle
/* SELECT * FROM HumanResources.Employee
WHERE JobTitle LIKE '[DM]%' -- Job titles starting with 'D' or 'M'     

SELECT * FROM HumanResources.Employee
WHERE JobTitle LIKE '[^DM]%' -- Job titles NOT starting with 'D' or 'M' 
*/

-- Select records with a specific pattern in the JobTitle
/* SELECT * FROM HumanResources.Employee    
WHERE JobTitle LIKE 'M[a-z]%' -- Job titles starting with 'M' followed by any lowercase letters

SELECT * FROM HumanResources.Employee
WHERE JobTitle LIKE 'M[A-Z]%' -- Job titles starting with 'M' followed by any uppercase letters
*/

-- Aliasing Columns
/* SELECT LoginId AS EmployeeLogin,
       JobTitle AS EmployeeJobTitle,
       HireDate AS EmployeeHireDate
FROM HumanResources.Employee; */

-- Using DISTINCT to get unique job titles
/* SELECT DISTINCT JobTitle
FROM HumanResources.Employee
ORDER BY JobTitle; */   

-- Using COUNT to count the number of employees
/* SELECT COUNT(*) AS TotalEmployees
FROM HumanResources.Employee; */

-- Using COUNT to count distinct job titles
/* SELECT COUNT(DISTINCT JobTitle) AS UniqueJobTitles
FROM HumanResources.Employee; */

-- Combining Multiple Tables with Joins
/* SELECT e.LoginId, e.JobTitle, d.Name AS DepartmentName
FROM HumanResources.Employee AS e
JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department AS d
    ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL; */ -- Current department assignments

-- Joining with LEFT JOIN to include all employees

--One way to identify foreign key relationships in a database is to look for columns with similar names across tables.

-- To quickly preview the data in the related tables, you can use the following queries (also available by right click on the table in SSMS and selecting "Select Top 1000 Rows"):

/* SELECT TOP (1000) [DepartmentID]
      ,[Name]
      ,[GroupName]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[HumanResources].[Department] */

  /* SELECT TOP (1000) [BusinessEntityID]
      ,[DepartmentID]
      ,[ShiftID]
      ,[StartDate]
      ,[EndDate]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[HumanResources].[EmployeeDepartmentHistory] */

  /* SELECT TOP (1000) [BusinessEntityID]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[BusinessEntity] */

  /* SELECT TOP (1000) [BusinessEntityID]
      ,[NationalIDNumber]
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      ,[VacationHours]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[HumanResources].[Employee] */

-- Select all records from Employee and EmployeeDepartmentHistory tables where there is a match in BusinessEntityID
/* SELECT * FROM [HumanResources].[Employee] AS emp
INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh
    ON emp.[BusinessEntityID] = edh.[BusinessEntityID]; */

-- Final Query: Join Employee, EmployeeDepartmentHistory, and Department tables to get current department assignments
/* SELECT * FROM [HumanResources].[Employee] AS emp
INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh
    ON emp.[BusinessEntityID] = edh.[BusinessEntityID]
INNER JOIN [HumanResources].[Department] AS dept
    ON edh.[DepartmentID] = dept.[DepartmentID]; -- All department assignments */

/* SELECT * FROM [HumanResources].[Employee] AS emp
INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh
    ON emp.[BusinessEntityID] = edh.[BusinessEntityID]
INNER JOIN [HumanResources].[Department] AS dept
    ON edh.[DepartmentID] = dept.[DepartmentID]
WHERE edh.EndDate IS NULL; -- Current department assignments     */

-- A more focused query 
/* SELECT 
    JobTitle [JobTitle],
    HireDate [HireDate],
    SalariedFlag [Paid Employee?],
    dept.Name [Department Name]
 FROM [HumanResources].[Employee] AS emp
INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh
    ON emp.[BusinessEntityID] = edh.[BusinessEntityID]
INNER JOIN [HumanResources].[Department] AS dept
    ON edh.[DepartmentID] = dept.[DepartmentID];  */

-- LEFT Joins
-- Select work orders, the product and their scrap reason (if any)
/* SELECT 
    p.[Name] AS ProductName,
    p.ProductNumber AS ProductNumber,
    wo.WorkOrderID AS WorkOrderID,
    wo.OrderQty AS OrderQuantity,
    wo.StockedQty AS StockedQuantity,
    wo.ScrappedQty AS ScrappedQuantity,
    sr.Name AS ScrapReason
FROM [Production].[Product] AS p
LEFT JOIN [Production].[WorkOrder] AS wo
    ON p.[ProductID] = wo.[ProductID]
LEFT JOIN [Production].[ScrapReason] AS sr
    ON wo.[ScrapReasonID] = sr.[ScrapReasonID]
ORDER BY ScrappedQuantity DESC; -- Show products with the most scrapped items at the top */

-- UNION & UNION ALL 
-- Select all customers and employees into one table

/* SELECT per.FirstNAme FROM [HumanResources].[Employee] AS emp
INNER JOIN [Person].[Person] AS per
    ON emp.[BusinessEntityID] = per.[BusinessEntityID]
UNION
SELECT per.FirstNAme FROM [Sales].[Customer] AS cust
INNER JOIN [Person].[Person] AS per
    ON cust.[PersonID] = per.[BusinessEntityID]
ORDER BY FirstNAme; */


-- Include duplicate first names using UNION ALL
/* SELECT per.FirstNAme FROM [HumanResources].[Employee] AS emp
INNER JOIN [Person].[Person] AS per
    ON emp.[BusinessEntityID] = per.[BusinessEntityID]
UNION ALL 
SELECT per.FirstNAme FROM [Sales].[Customer] AS cust
INNER JOIN [Person].[Person] AS per
    ON cust.[PersonID] = per.[BusinessEntityID]
ORDER BY FirstNAme; */

-- Using DISTINCT to remove duplicates
/* SELECT DISTINCT per.FirstName, per.LastName FROM [HumanResources].[Employee] AS emp
INNER JOIN [Person].[Person] AS per
    ON emp.[BusinessEntityID] = per.[BusinessEntityID]
; */


-- Uing GROUP BY to group by first and last names
/* SELECT per.FirstName FROM [HumanResources].[Employee] AS emp
INNER JOIN [Person].[Person] AS per
    ON emp.[BusinessEntityID] = per.[BusinessEntityID]
GROUP BY per.FirstName
ORDER BY per.FirstName
; */

-- Using GROUP BY to group by first and last names
/* SELECT per.FirstName, per.LastName FROM [HumanResources].[Employee] AS emp
INNER JOIN [Person].[Person] AS per
    ON emp.[BusinessEntityID] = per.[BusinessEntityID]
GROUP BY per.FirstName, per.LastName
ORDER BY per.FirstName
; */

--Aggregate Functions
-- Find the number of customers
/* SELECT COUNT(per.FirstName) FROM [Sales].[Customer] cust
INNER JOIN [Person].[Person] AS per
    ON cust.[PersonID] = per.[BusinessEntityID]
; */

-- Find the number of customers wwithh the same first name
/* SELECT per.FirstName, COUNT(per.FirstName) AS [Number] FROM [Sales].[Customer] cust
INNER JOIN [Person].[Person] AS per
    ON per.[BusinessEntityID] = cust.[PersonID]
GROUP BY per.FirstName
ORDER BY [Number] DESC; */

-- Find the number of customers with the same first name, having more than one occurrence
/* SELECT per.FirstName, COUNT(per.FirstName) AS [Number] FROM [Sales].[Customer] cust
INNER JOIN [Person].[Person] AS per
    ON per.[BusinessEntityID] = cust.[PersonID]
GROUP BY per.FirstName
HAVING COUNT(per.FirstName) > 1
ORDER BY [Number] DESC;  */

-- Find total, average, lowest and highest amounts for sales
/* SELECT 
    SUM(soh.TotalDue) AS TotalSales,
    AVG(soh.TotalDue) AS AverageSale,
    MIN(soh.TotalDue) AS LowestSale,
    MAX(soh.TotalDue) AS HighestSale
FROM [Sales].[SalesOrderHeader] AS soh;  */

-- Find total, average, lowest and highest amounts for sales by each salesperson
-- List salespeople by total sales in descending order
/* SELECT  
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
ORDER BY TotalSales DESC
; */


-- String Functions
/* SELECT  
    p.FirstName + ' ' + p.LastName AS FullName,
    UPPER(p.FirstName) AS FirstNameUpper,
    LOWER(p.LastName) AS LastNameLower,
    LEN(p.FirstName) AS FirstNameLength,
    SUBSTRING(p.LastName, 1, 3) AS LastNameFirst3Chars,
    -- CONCAT(p.FirstName, ' ', p.LastName) AS FullNameConcat,
    /* p.FirstName,
    p.LastName, */
    COUNT(soh.SalesOrderID) AS NumberOfSales,
    FORMAT(SUM(soh.TotalDue), 'C') AS TotalSales, -- 'C' for currency format
    FORMAT(AVG(soh.TotalDue), 'C') AS AverageSale, -- 'C' for currency format
    FORMAT(MIN(soh.TotalDue), 'C') AS LowestSale,  -- 'C' for currency format
    FORMAT(MAX(soh.TotalDue), 'C') AS HighestSale  -- 'C' for currency format 
FROM [Sales].[SalesPerson] AS s
INNER JOIN [Person].[Person] AS p
    ON s.[BusinessEntityID] = p.[BusinessEntityID]
INNER JOIN [Sales].[SalesOrderHeader] soh 
    ON s.[BusinessEntityID] = soh.[SalesPersonID]
GROUP BY p.FirstName, p.LastName
ORDER BY TotalSales DESC
; */

-- Using CAST to convert data types
/* SELECT  
    p.FirstName + ' ' + p.LastName AS FullName,
    COUNT(soh.SalesOrderID) AS NumberOfSales,
    CAST(SUM(soh.TotalDue) AS DECIMAL(10,2)) AS TotalSales, 
    CAST(AVG(soh.TotalDue) AS DECIMAL(10,2)) AS AverageSale, 
    CAST(MIN(soh.TotalDue) AS DECIMAL(10,2)) AS LowestSale,  
    CAST(MAX(soh.TotalDue) AS DECIMAL(10,2)) AS HighestSale  
FROM [Sales].[SalesPerson] AS s
INNER JOIN [Person].[Person] AS p
    ON s.[BusinessEntityID] = p.[BusinessEntityID]
INNER JOIN [Sales].[SalesOrderHeader] soh 
    ON s.[BusinessEntityID] = soh.[SalesPersonID]
GROUP BY p.FirstName, p.LastName
ORDER BY TotalSales DESC
; */

-- Using CONVERT to convert data types
/* SELECT  
    p.FirstName + ' ' + p.LastName AS FullName,
    COUNT(soh.SalesOrderID) AS NumberOfSales,
    CONVERT(DECIMAL(10,2), SUM(soh.TotalDue)) AS TotalSales, 
    CONVERT(DECIMAL(10,2), AVG(soh.TotalDue)) AS AverageSale, 
    CONVERT(DECIMAL(10,2), MIN(soh.TotalDue)) AS LowestSale,  
    CONVERT(DECIMAL(10,2), MAX(soh.TotalDue)) AS HighestSale  
FROM [Sales].[SalesPerson] AS s
INNER JOIN [Person].[Person] AS p
    ON s.[BusinessEntityID] = p.[BusinessEntityID]
INNER JOIN [Sales].[SalesOrderHeader] soh 
    ON s.[BusinessEntityID] = soh.[SalesPersonID]
GROUP BY p.FirstName, p.LastName
ORDER BY TotalSales DESC
; */      

-- Subqueries
/* SELECT 
    BusinessEntityID,
    JobTitle,
    LoginID,
    VacationHours,
    SickLeaveHours
FROM HumanResources.Employee
WHERE VacationHours > (SELECT AVG(VacationHours) FROM HumanResources.Employee)
ORDER BY VacationHours DESC; */

-- Find employees with above average vacation hours compared to their job title average
-- Using a subquery in the JOIN clause
-- Uncomment the AND clause in the HAVING statement to filter by a specific job title
/* SELECT
    emp.BusinessEntityID,
    emp.JobTitle,
    AVG(VacationHours) AS AverageVacationHours,
    AVG(SickLeaveHours) AS AverageSickLeaveHours,
    Sub.AverageVacation -- References subquery below
FROM HumanResources.Employee AS emp
JOIN (
    SELECT
        JobTitle,
        AVG(VacationHours) AS AverageVacation
    FROM HumanResources.Employee emp2
    GROUP BY JobTitle
) AS Sub
    ON emp.JobTitle = Sub.JobTitle
GROUP BY emp.BusinessEntityID, emp.JobTitle, Sub.AverageVacation
HAVING AVG(VacationHours) > Sub.AverageVacation --AND emp.JobTitle = 'Design Engineer'
ORDER BY AverageVacationHours DESC; */

-- CTE Common Table Expressions
-- Find employees with above average vacation hours compared to their job title average
-- Using a CTE to calculate average vacation hours by job title     
/* WITH JobTitleAverages AS (
    SELECT
        JobTitle,
        AVG(VacationHours) AS AverageVacation
    FROM HumanResources.Employee
    GROUP BY JobTitle
)
SELECT
    emp.BusinessEntityID,
    emp.JobTitle,
    AVG(emp.VacationHours) AS AverageVacationHours,
    AVG(emp.SickLeaveHours) AS AverageSickLeaveHours,
    jta.AverageVacation -- References CTE above
FROM HumanResources.Employee AS emp
JOIN JobTitleAverages AS jta
    ON emp.JobTitle = jta.JobTitle
GROUP BY emp.BusinessEntityID, emp.JobTitle, jta.AverageVacation
HAVING AVG(emp.VacationHours) > jta.AverageVacation --AND emp.JobTitle = 'Design Engineer'
ORDER BY AverageVacationHours DESC; */

-- Find the total sales amount by each salesperson using a CTE
/* WITH SalesTotals AS (
    SELECT
        SalesPersonID,
        SUM(TotalDue) AS TotalSales,
        COUNT(SalesOrderID) AS NumberOfSales,
        YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    GROUP BY SalesPersonID, YEAR(OrderDate)
)
SELECT
    st.SalesPersonID,
    p.FirstName,
    p.LastName,
    st.NumberOfSales,
    st.TotalSales,
    st.SalesYear    
FROM SalesTotals AS st
JOIN Sales.SalesPerson AS sp
    ON st.SalesPersonID = sp.BusinessEntityID
JOIN Person.Person AS p
    ON sp.BusinessEntityID = p.BusinessEntityID
ORDER BY st.TotalSales, st.SalesYear DESC; */

-- Window Functions
-- Type of Window Functions: ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE(), SUM() OVER(), AVG() OVER(), COUNT() OVER()
-- The structure of a window function is: function() OVER (PARTITION BY column(s) ORDER BY column(s))
-- Find the top 3 sales amounts by each salesperson using the RANK() window function
/* SELECT
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    soh.SalesOrderID,
    soh.TotalDue,
    RANK() OVER (PARTITION BY sp.BusinessEntityID ORDER BY soh.TotalDue DESC) AS SalesRank
FROM Sales.SalesPerson AS sp
JOIN Person.Person AS p
    ON sp.BusinessEntityID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader AS soh
    ON sp.BusinessEntityID = soh.SalesPersonID
WHERE soh.TotalDue IS NOT NULL
ORDER BY sp.BusinessEntityID, SalesRank
; */-- To get the top 3 sales amounts by each salesperson, you can wrap the above query in a CTE or subquery and filter by SalesRank <= 3
-- Example using a CTE
/* WITH RankedSales AS (
    SELECT
        sp.BusinessEntityID AS SalesPersonID,
        p.FirstName,
        p.LastName,
        soh.SalesOrderID,
        soh.TotalDue,
        RANK() OVER (PARTITION BY sp.BusinessEntityID ORDER BY soh.TotalDue DESC) AS SalesRank
    FROM Sales.SalesPerson AS sp
    JOIN Person.Person AS p
        ON sp.BusinessEntityID = p.BusinessEntityID
    JOIN Sales.SalesOrderHeader AS soh
        ON sp.BusinessEntityID = soh.SalesPersonID
    WHERE soh.TotalDue IS NOT NULL
)
SELECT * FROM RankedSales
WHERE SalesRank <= 3
ORDER BY SalesPersonID, SalesRank
;  */

-- Find the cumulative sales amount by each salesperson using the SUM() OVER() window function
/* SELECT 
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    soh.SalesOrderID,
    soh.TotalDue,
    SUM(soh.TotalDue) OVER (PARTITION BY sp.BusinessEntityID ORDER BY soh.OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeSales        
   FROM Sales.SalesPerson AS sp
   JOIN Person.Person AS p
       ON sp.BusinessEntityID = p.BusinessEntityID
   JOIN Sales.SalesOrderHeader AS soh
       ON sp.BusinessEntityID = soh.SalesPersonID
   WHERE soh.TotalDue IS NOT NULL
   ORDER BY sp.BusinessEntityID, soh.OrderDate
;  */

-- Find the average sales amount by each salesperson using the AVG() OVER() window function
/* SELECT 
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    soh.SalesOrderID,
    soh.TotalDue,
    AVG(soh.TotalDue) OVER (PARTITION BY sp.BusinessEntityID ORDER BY soh.OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAverage        
   FROM Sales.SalesPerson AS sp 
    JOIN Person.Person AS p
         ON sp.BusinessEntityID = p.BusinessEntityID
    JOIN Sales.SalesOrderHeader AS soh
         ON sp.BusinessEntityID = soh.SalesPersonID
   WHERE soh.TotalDue IS NOT NULL
   ORDER BY sp.BusinessEntityID, soh.OrderDate
;   */

-- Find the count of sales by each salesperson using the COUNT() OVER() window function
/* SELECT 
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    soh.SalesOrderID,
    soh.TotalDue,
    COUNT(soh.SalesOrderID) OVER (PARTITION BY sp.BusinessEntityID ORDER BY soh.OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningCount        
   FROM Sales.SalesPerson AS sp
       JOIN Person.Person AS p
            ON sp.BusinessEntityID = p.BusinessEntityID
        JOIN Sales.SalesOrderHeader AS soh
            ON sp.BusinessEntityID = soh.SalesPersonID
    WHERE soh.TotalDue IS NOT NULL
    ORDER BY sp.BusinessEntityID, soh.OrderDate
;   */        

-- Find the quartile of sales amounts by each salesperson using the NTILE() window function
/* SELECT 
    sp.BusinessEntityID AS SalesPersonID,
    p.FirstName,
    p.LastName,
    soh.SalesOrderID,
    soh.TotalDue,
    NTILE(4) OVER (PARTITION BY sp.BusinessEntityID ORDER BY soh.TotalDue DESC) AS SalesQuartile        
   FROM Sales.SalesPerson AS sp
       JOIN Person.Person AS p
            ON sp.BusinessEntityID = p.BusinessEntityID
        JOIN Sales.SalesOrderHeader AS soh
            ON sp.BusinessEntityID = soh.SalesPersonID
    WHERE soh.TotalDue IS NOT NULL
    ORDER BY sp.BusinessEntityID, SalesQuartile, soh.TotalDue DESC
;    */


-- Find the max, min, avg and sum of unit prices from sales order details using window functions
/* SELECT sod.SalesOrderID, CarrierTrackingNumber, OrderQty, OrderDate, DueDate, ShipDate, UnitPrice,
    MAX(UnitPrice) OVER() AS MaxUnitPrice,
    MIN(UnitPrice) OVER() AS MinUnitPrice,
    AVG(UnitPrice) OVER() AS AvgUnitPrice,
    SUM(UnitPrice) OVER() AS TotalUnitPrice
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
WHERE UnitPrice IS NOT NULL
ORDER BY OrderDate DESC
; */

-- Find the max, min, avg and sum of unit prices from sales order details using window functions, partitioned by SalesOrderID
/* SELECT sod.SalesOrderID, CarrierTrackingNumber, OrderQty, OrderDate, DueDate, ShipDate, UnitPrice,
    MAX(UnitPrice) OVER(PARTITION BY sod.SalesOrderID) AS MaxUnitPrice,
    MIN(UnitPrice) OVER(PARTITION BY sod.SalesOrderID) AS MinUnitPrice,
    AVG(UnitPrice) OVER(PARTITION BY sod.SalesOrderID) AS AvgUnitPrice,
    SUM(UnitPrice) OVER(PARTITION BY sod.SalesOrderID) AS TotalUnitPrice
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
WHERE UnitPrice IS NOT NULL
ORDER BY OrderDate DESC
; */

-- Asign row numbers to sales order details using the ROW_NUMBER() window function, partitioned by SalesOrderID
-- ORDER BY needs to be specified!!!
/* SELECT sod.SalesOrderID, CarrierTrackingNumber, OrderQty, OrderDate, DueDate, ShipDate, UnitPrice,
    ROW_NUMBER() OVER(PARTITION BY sod.SalesOrderID ORDER BY UnitPrice DESC) AS RowNumber
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
WHERE UnitPrice IS NOT NULL
ORDER BY sod.SalesOrderID, RowNumber
;   */

--Rank employee by vacation hours in the department using the RANK() window function, partitioned by DepartmentID
/* SELECT
    emp.BusinessEntityID,
    emp.JobTitle,
    emp.VacationHours,
    edh.DepartmentID,
    RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY emp.VacationHours DESC) AS VacationRank
FROM HumanResources.Employee AS emp
JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON emp.BusinessEntityID = edh.BusinessEntityID
WHERE edh.EndDate IS NULL
ORDER BY edh.DepartmentID, VacationRank
;   */

--Using DENSE_RANK() to rank employees by vacation hours in the department, partitioned by DepartmentID
/* SELECT
    emp.BusinessEntityID,
    emp.JobTitle,
    emp.VacationHours,
    edh.DepartmentID,
    DENSE_RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY emp.VacationHours DESC) AS VacationRank
FROM HumanResources.Employee AS emp
JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON emp.BusinessEntityID = edh.BusinessEntityID
WHERE edh.EndDate IS NULL
ORDER BY edh.DepartmentID, VacationRank
;     */

-- Using PERCENT_RANK() to rank employees by vacation hours in the department, partitioned by DepartmentID
/* SELECT
    emp.BusinessEntityID,
    emp.JobTitle,
    emp.VacationHours,
    edh.DepartmentID,
    PERCENT_RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY emp.VacationHours DESC) AS VacationPercentRank
FROM HumanResources.Employee AS emp
JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON emp.BusinessEntityID = edh.BusinessEntityID
WHERE edh.EndDate IS NULL
ORDER BY edh.DepartmentID, VacationPercentRank
;    */      

-- Find the top 3 employees with the most vacation hours in each department using RANK() and a CTE
-- Handling Ties with RANK()
/* WITH Ties AS (
    SELECT
        emp.BusinessEntityID,
        emp.JobTitle,
        emp.VacationHours,
        edh.DepartmentID,
        RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY emp.VacationHours DESC) AS VacationRank
    FROM HumanResources.Employee AS emp
    JOIN HumanResources.EmployeeDepartmentHistory AS edh
        ON emp.BusinessEntityID = edh.BusinessEntityID
    WHERE edh.EndDate IS NULL
)
SELECT * FROM Ties
WHERE VacationRank <= 3
ORDER BY DepartmentID, VacationRank
; */

-- Find the top 3 employees with the most vacation hours in each department using DENSE_RANK() and a CTE
-- No gaps in ranking with DENSE_RANK()
/* WITH DenseTies AS (
    SELECT 
        emp.BusinessEntityID,
        emp.JobTitle,
        emp.VacationHours,
        edh.DepartmentID,
        DENSE_RANK() OVER (PARTITION BY edh.DepartmentID ORDER BY emp.VacationHours DESC) AS VacationRank
    FROM HumanResources.Employee AS emp 
    JOIN HumanResources.EmployeeDepartmentHistory AS edh
        ON emp.BusinessEntityID = edh.BusinessEntityID
    WHERE edh.EndDate IS NULL
)
SELECT * FROM DenseTies
WHERE VacationRank <= 3 
ORDER BY DepartmentID, VacationRank
;    */


-- Using LEAD and LAG to compare vacation hours with the next and previous employee in the department
/* SELECT
    emp.BusinessEntityID,
    emp.JobTitle,
    emp.VacationHours,
    edh.DepartmentID,
    LAG(emp.VacationHours) OVER (PARTITION BY edh.DepartmentID ORDER BY emp.VacationHours DESC) AS PreviousVacationHours,
    LEAD(emp.VacationHours) OVER (PARTITION BY edh.DepartmentID ORDER BY emp.VacationHours DESC) AS NextVacationHours
FROM HumanResources.Employee AS emp
JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON emp.BusinessEntityID = edh.BusinessEntityID
WHERE edh.EndDate IS NULL
ORDER BY edh.DepartmentID, emp.VacationHours DESC
;  */  

/* SELECT 
    ProductID,
    Name,
    ProductNumber,
    SafetyStockLevel,
    ReorderPoint,
    StandardCost,
    ListPrice,
    LEAD(ListPrice) OVER (ORDER BY ListPrice DESC) AS NextHigherPrice,
    LAG(ListPrice) OVER (ORDER BY ListPrice DESC) AS NextLowerPrice
FROM Production.Product
WHERE ListPrice IS NOT NULL
ORDER BY ListPrice DESC
; */

/* SELECT 
    ProductID,
    Name,
    ProductNumber,
    SafetyStockLevel,
    ReorderPoint,
    StandardCost,
    ListPrice,
    LEAD(SafetyStockLevel, 5, 0) OVER (ORDER BY ProductID) AS NextStockLevel,
    LAG(SafetyStockLevel, 5, 0) OVER (ORDER BY ProductID) AS PrevStockLevel
FROM Production.Product; */

-- ISNULL vs COALESCE
-- Using ISNULL to replace NULL values in the ShipDate column with a default date
/* SELECT
    SalesOrderID,
    OrderDate,
    DueDate,
    ShipDate,
    ISNULL(ShipDate, '1900-01-01') AS ShipDateWithDefault
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC
;  */

/* SELECT TOP (20)
    SalesOrderID,
    OrderDate,
    DueDate,
    ShipDate,
    COALESCE(ShipDate, '1900-01-01') AS ShipDateWithDefault
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC
; */


-- Using ISNULL and COALESCE to handle NULL values in the Person.Person table
-- ISNULL can only handle two arguments, while COALESCE can handle multiple arguments
-- ISNULL is specific to SQL Server, while COALESCE is part of the SQL standard
-- ISNULL is generally faster than COALESCE when dealing with two arguments, but the performance difference is usually negligible
-- COALESCE is more flexible and can be used in more complex scenarios
-- COALESCE can be used in standard SQL queries, making it more portable across different database systems
-- COALESCE evaluates all arguments and returns the first non-null value, while ISNULL only evaluates the first two arguments
-- In terms of data type precedence, ISNULL returns the data type of the first argument, while COALESCE returns the data type with the highest precedence among all arguments
-- When using ISNULL, be cautious about data type conversions, as it may lead to unexpected results if the data types of the two arguments are different
-- COALESCE is more suitable for scenarios where you need to check multiple columns for NULL values and return the first non-null value     
SELECT TOP (20)
    ISNULL([Title], 'N/A') AS Title,
    [FirstName],
    COALESCE([MiddleName], 'N/A') AS MiddleName,
    [LastName],
    COALESCE([Suffix], '') AS Suffix,
    [EmailPromotion],    
    [AdditionalContactInfo]
FROM [Person].[Person]
ORDER BY [LastName], [FirstName]
;
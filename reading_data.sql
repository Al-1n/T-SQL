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

SELECT per.FirstName, per.LastName FROM [HumanResources].[Employee] AS emp
INNER JOIN [Person].[Person] AS per
    ON emp.[BusinessEntityID] = per.[BusinessEntityID]
GROUP BY per.FirstName, per.LastName
ORDER BY per.FirstName
;
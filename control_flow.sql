-- Title: Control Flow in SQL Server
-- Date: 2025-10-14
-- Author: Alin Airinei
-- Purpose: Create a reference list of useful queries and statements 
--
-- Tags: SQL Server, Control Flow, T-SQL, IF, WHILE, GOTO, BREAK, CONTINUE
-- Usage: Run on local SQL Server with appropriate SA credentials
-- Note: Uncomment the statements to execute them as needed.

-- BEGIN and END are used to group multiple SQL statements into a single block.
-- They are often used in control-of-flow statements such as IF...ELSE and WHILE
-- to define the scope of the statements that should be executed together. -- They help improve readability and maintainability of the code.

-- Example of Control Flow Statements in SQL Server
-- This script demonstrates the use of IF...ELSE, WHILE, BREAK, CONTINUE, and GOTO statements.
/* BEGIN
    PRINT 'Starting Control Flow Examples';

    -- Example of IF...ELSE statement
    DECLARE @Value INT = 10;

    IF @Value > 5
    BEGIN
        PRINT 'Value is greater than 5';
    END
    ELSE
    BEGIN
        PRINT 'Value is 5 or less';
    END

    -- Example of WHILE loop
    DECLARE @Counter INT = 1;

    WHILE @Counter <= 5
    BEGIN
        PRINT 'Counter value: ' + CAST(@Counter AS VARCHAR);
        SET @Counter = @Counter + 1;
    END

    -- Example of BREAK and CONTINUE in a loop
    SET @Counter = 1;

    WHILE @Counter <= 10
    BEGIN
        IF @Counter = 6
        BEGIN
            PRINT 'Skipping number 6';
            SET @Counter = @Counter + 1;
            CONTINUE; -- Skip the rest of the loop when Counter is 6
        END

        IF @Counter = 9
        BEGIN
            PRINT 'Breaking the loop at number 9';
            BREAK; -- Exit the loop when Counter is 9
        END

        PRINT 'Current number: ' + CAST(@Counter AS VARCHAR);
        SET @Counter = @Counter + 1;
    END

    -- Example of GOTO statement (use with caution)
    DECLARE @GotoCounter INT = 1;       
    GotoStart:
        IF @GotoCounter <= 3
        BEGIN
            PRINT 'Goto Counter: ' + CAST(@GotoCounter AS VARCHAR);
            SET @GotoCounter = @GotoCounter + 1;
            GOTO GotoStart; -- Jump back to the label
        END 
    PRINT 'Exited GOTO loop';
END
GO */

-- End of Control Flow Examples
/* PRINT 'Control Flow Examples Completed';
GO */
-- Cleanup (if any temporary objects were created, none in this case)
-- DROP TABLE IF EXISTS #TempTable; -- Uncomment if a temp table was created
GO  
-- End of Script

-- Note: The above script is commented out to prevent accidental execution. Uncomment sections as needed to run specific examples.
-- Always test scripts in a safe environment before executing in production.

-- Exampl using AdventyreWorks database

/* BEGIN
    PRINT 'Starting Control Flow Examples with AdventureWorks';

    -- Example of IF...ELSE statement
    DECLARE @EmployeeCount INT;

    SELECT @EmployeeCount = COUNT(*) FROM [HumanResources].[Employee];

    IF @EmployeeCount > 100
    BEGIN
        PRINT 'There are more than 100 employees.';
    END
    ELSE
    BEGIN
        PRINT 'There are 100 or fewer employees.';
    END

    -- Example of WHILE loop to list first 5 employees
    DECLARE @EmpCounter INT = 1;
    DECLARE @EmpID INT;

    WHILE @EmpCounter <= 5
    BEGIN
        SELECT TOP 1 @EmpID = BusinessEntityID 
        FROM [HumanResources].[Employee] 
        WHERE BusinessEntityID NOT IN (SELECT TOP (@EmpCounter - 1) BusinessEntityID FROM [HumanResources].[Employee] ORDER BY BusinessEntityID)
        ORDER BY BusinessEntityID;

        PRINT 'Employee ID: ' + CAST(@EmpID AS VARCHAR);
        SET @EmpCounter = @EmpCounter + 1;
    END

END
GO */
-- End of Control Flow Examples with AdventureWorks
/* PRINT 'Control Flow Examples with AdventureWorks Completed';
GO */
-- Cleanup (if any temporary objects were created, none in this case)
-- DROP TABLE IF EXISTS #TempTable; -- Uncomment if a temp table was created
GO  
-- End of Script


-- Another example using AdventureWorks database
/* BEGIN
    DECLARE @ID INT;
    SELECT @ID = MAX(BusinessEntityID) FROM [Person].[Person];
    PRINT 'Max BusinessEntityID is ' + CAST(@ID AS VARCHAR);

    BEGIN
        SELECT @ID = MIN(BusinessEntityID) FROM [Person].[Person];
        PRINT 'Min BusinessEntityID is ' + CAST(@ID AS VARCHAR);
    END
    PRINT 'Control Flow Example Completed';
END
GO */
-- End of Script

-- IF/Else Statements
-- Format for IF/ELSE statements is as follows:
-- IF Boolean_expression
--     { sql_statement | statement_block }
-- [ ELSE
--     { sql_statement | statement_block } ]    
-- Example of IF/ELSE statement

-- Note: Only one ELSE is allowed per IF
-- Nested IF statements are allowed
-- ELSE IF is not a valid construct, use nested IF instead
-- Example:
-- Uncomment to run
/* BEGIN
    DECLARE @Value INT = 15;

    IF @Value < 10
        PRINT 'Value is less than 10';
    ELSE IF @Value BETWEEN 10 AND 20
        PRINT 'Value is between 10 and 20';
    ELSE
        PRINT 'Value is greater than 20';
END
GO */
-- End of Script


-- Another example of IF/ELSE statement
/* BEGIN
    DECLARE @Score INT = 85;
    DECLARE @Grade CHAR(1);

    IF @Score >= 90
        SET @Grade = 'A';
    ELSE IF @Score >= 80
        SET @Grade = 'B';
    ELSE IF @Score >= 70
        SET @Grade = 'C';
    ELSE IF @Score >= 60
        SET @Grade = 'D';
    ELSE
        SET @Grade = 'F';

    PRINT 'The grade is: ' + @Grade;
END
GO */
-- End of Script


-- Another example
/* BEGIN
    DECLARE @num INT = 7;

    IF @num % 2 = 0
        PRINT CAST(@num AS VARCHAR) + ' is even';
    ELSE
        PRINT CAST(@num AS VARCHAR) + ' is odd';
END
GO */
-- End of Script


-- Example using AdventureWorks database
/* BEGIN
    DECLARE @EmployeeCount INT; 
    SELECT @EmployeeCount = COUNT(*) FROM [HumanResources].[Employee];
    IF @EmployeeCount > 200
        PRINT 'There are more than 200 employees.';
    ELSE
        PRINT 'There are 200 or fewer employees.';
END
GO */
-- End of Script    


-- Another example using AdventureWorks database/* 
/* BEGIN 
    DECLARE @BID INT;
    SET @BID = 11;

    SELECT * FROM [Person].[Person] WHERE BusinessEntityID = @BID;

    IF @@ROWCOUNT = 0 -- Check if no rows were returned
        PRINT 'No person found with BusinessEntityID = ' + CAST(@BID AS VARCHAR); -- If no rows, print message 
    ELSE
        PRINT 'Person found with BusinessEntityID = ' + CAST(@BID AS VARCHAR); -- If rows found, print message
END
GO  */
-- End of Script


-- Another example:
/* BEGIN 
    DECLARE @BID INT;
    SET @BID = 11;

    SELECT * FROM [Person].[Person] WHERE BusinessEntityID = @BID;

    IF @BID >= 10 -- Check if BID is greater than or equal to 10
        PRINT 'BusinessEntityID is 10 or greater'; 
    ELSE
        PRINT 'BusinessEntityID is less than 10';
END
GO  */

-- WHILE Loop
-- Format for WHILE loop is as follows:
-- WHILE Boolean_expression
--     { sql_statement | statement_block }
-- Example of WHILE loop
-- Uncomment to run

/* BEGIN
    DECLARE @Counter INT = 1;

    WHILE @Counter <= 5
    BEGIN
        PRINT 'Counter value: ' + CAST(@Counter AS VARCHAR);
        SET @Counter = @Counter + 1;
    END
END
GO */
-- End of Script

-- Another example of WHILE loop
-- Declaring Number and Total variables
/* BEGIN
    DECLARE @Number INT = 1;
    DECLARE @Total INT = 0;

    -- Looping from 1 to 10
    WHILE @Number <= 10
    BEGIN
        SET @Total = @Total + @Number; -- Adding current number to total
        SET @Number = @Number + 1;     -- Incrementing the number
    END

    PRINT 'The total sum from 1 to 10 is: ' + CAST(@Total AS VARCHAR); -- Displaying the total sum
END
GO */
-- End of Script

--BREAK and CONTINUE Statements
-- Format for BREAK and CONTINUE statements is as follows:
-- BREAK
-- CONTINUE
-- Example of BREAK and CONTINUE statements
-- Uncomment to run
/* BEGIN
    DECLARE @Counter INT = 1;

    WHILE @Counter <= 10
    BEGIN
        IF @Counter = 6
        BEGIN
            PRINT 'Skipping number 6';
            SET @Counter = @Counter + 1;
            CONTINUE; -- Skip the rest of the loop when Counter is 6
        END

        IF @Counter = 9
        BEGIN
            PRINT 'Breaking the loop at number 9';
            BREAK; -- Exit the loop when Counter is 9
        END

        PRINT 'Current number: ' + CAST(@Counter AS VARCHAR);
        SET @Counter = @Counter + 1;
    END
END
GO */
-- End of Script

-- Another example of BREAK and CONTINUE statements
/* BEGIN
    DECLARE @i INT = 1; 
    WHILE @i <= 10
    BEGIN
        IF @i = 4
        BEGIN
            PRINT 'Skipping number 4';
            SET @i = @i + 1;
            CONTINUE; -- Skip the rest of the loop when i is 4
        END 
        IF @i = 8
        BEGIN
            PRINT 'Breaking the loop at number 8';
            BREAK; -- Exit the loop when i is 8
        END
        PRINT 'Current number: ' + CAST(@i AS VARCHAR);
        SET @i = @i + 1;
    END
END
GO */
-- End of Script    



-- GOTO Statement
-- Note: Use GOTO sparingly as it can make code harder to read and maintain
-- The GOTO statement provides an unconditional jump from the GOTO to a labeled statement in the same batch, stored procedure, or function.
-- It is generally advised to avoid using GOTO as it can lead to "spaghetti code".
-- However, it can be useful in certain scenarios, such as breaking out of nested loops or error handling.
-- Format for GOTO statement is as follows:
-- GOTO label_name
-- label_name: sql_statement | statement_block
-- Example of GOTO statement
-- Uncomment to run
/* BEGIN
    DECLARE @Counter INT = 1;       
    GotoStart:
        IF @Counter <= 3    
        BEGIN
            PRINT 'Goto Counter: ' + CAST(@Counter AS VARCHAR);
            SET @Counter = @Counter + 1;
            GOTO GotoStart; -- Jump back to the label
        END 
    PRINT 'Exited GOTO loop';
END
GO */
-- End of Script


-- CASE Statement
-- The CASE statement goes through conditions and returns a value when the first condition is met (like an IF-THEN-ELSE statement).
-- Once a condition is true, it will stop reading and return the result.
-- If no conditions are true, it returns the value in the ELSE clause.
-- If there is no ELSE part and no conditions are true, it returns NULL.
-- Format for CASE statement is as follows:
-- CASE 
--     WHEN condition1 THEN result1
--     WHEN condition2 THEN result2
--     ...
--     ELSE resultN
-- END
-- Example of CASE statement
-- Uncomment to run

/* BEGIN
    DECLARE @Score INT = 85;
    DECLARE @Grade CHAR(1); 
    SET @Grade = CASE 
                    WHEN @Score >= 90 THEN 'A'
                    WHEN @Score >= 80 THEN 'B'
                    WHEN @Score >= 70 THEN 'C'
                    WHEN @Score >= 60 THEN 'D'
                    ELSE 'F'
                 END;
    PRINT 'The grade is: ' + @Grade;
END
GO */
-- End of Script

-- Another example of CASE statement
/* BEGIN
    DECLARE @DayOfWeek INT = 3;
    DECLARE @DayName VARCHAR(10);
    SET @DayName = CASE @DayOfWeek
                      WHEN 1 THEN 'Monday'
                      WHEN 2 THEN 'Tuesday'
                      WHEN 3 THEN 'Wednesday'
                      WHEN 4 THEN 'Thursday'
                      WHEN 5 THEN 'Friday'
                      WHEN 6 THEN 'Saturday'
                      WHEN 7 THEN 'Sunday'
                      ELSE 'Invalid Day'
                   END;
    PRINT 'The day is: ' + @DayName;
END
GO */
-- End of Script    

-- Another example using AdventureWorks database
/* BEGIN
    DECLARE @EmployeeID INT = 1;
    DECLARE @JobTitle VARCHAR(50);  
    SELECT @JobTitle = JobTitle FROM [HumanResources].[Employee] WHERE BusinessEntityID = @EmployeeID;
    SET @JobTitle = CASE 
                        WHEN @JobTitle = 'Sales Representative' THEN 'Sales'
                        WHEN @JobTitle = 'Research and Development' THEN 'R&D'
                        WHEN @JobTitle = 'Production Technician' THEN 'Production'
                        ELSE 'Other'
                    END;
    PRINT 'The department is: ' + @JobTitle;
END
GO */
-- End of Script
-- Cleanup (if any temporary objects were created, none in this case)
-- DROP TABLE IF EXISTS #TempTable; -- Uncomment if a temp table was created
GO  
-- End of Script   


-- Another example using AdventureWorks database
SELECT [JobTitle], [Birthdate], [MaritalStatus], [HireDate],
         CASE 
              WHEN [MaritalStatus] = 'M' THEN 'Married'
              WHEN [MaritalStatus] = 'S' THEN 'Single'
              ELSE 'Other'
         END AS MaritalStatusDescription,
         CASE 
              WHEN DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, [Birthdate]) < 30 THEN 'Under 30'
              WHEN DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, [Birthdate]) BETWEEN 30 AND 50 THEN '30-50'
              ELSE 'Over 50'
         END AS AgeGroup    
FROM [HumanResources].[Employee]
WHERE [JobTitle] IN ('Sales Representative', 'Research and Development', 'Production Technician');
GO
-- End of Script

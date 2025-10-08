-- Full insert statement for inserting data into the 'employees' table

--CREATE TABLE statement for reference (uncomment if table creation is needed)
/* IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'employees')
BEGIN
    CREATE TABLE employees (
        id INT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(100) UNIQUE,
        hire_date DATE,
        job_id VARCHAR(10),
        salary DECIMAL(10, 2)
    );
END */

-- Insert statement (commented out to prevent accidental execution)
/* INSERT INTO employees (id, first_name, last_name, email, hire_date, job_id, salary)
VALUES
(1, 'John', 'Doe', 'john_doe@advworks.com', '2020-01-15', 'IT_PROG', 60000),
(2, 'Jane', 'Smith', 'jane_smith26@advworks.com', '2019-03-22', 'HR_REP', 55000),
(3, 'Emily', 'Johnson', 'emily_924@advworks.com', '2021-07-30', 'FIN_MGR', 75000),
(4, 'Michael', 'Brown', 'mike_b56@advworks.com', '2018-11-12', 'SA_REP', 50000),
(5, 'Jessica', 'Davis', 'jdavis315@advworks.com', '2022-05-09', 'SC_REP', 48000)
; */

-- Select statement to verify inserted data
/* SELECT * FROM employees; */

-- Note: Uncomment the CREATE TABLE and INSERT statements to execute them as needed.-- The INSERT statement is commented out to prevent accidental execution.
-- To execute, remove the comment markers (/* and */) around the desired statements.
-- Ensure that the 'employees' table exists before running the INSERT statement.
-- The SELECT statement at the end can be used to verify that the data has been inserted correctly.


-- INSERT statement format: INSERT INTO Schema.Table (Column1, Column2, ...) VALUES (Value1, Value2, ...);

-- Example:

-- Insert new currency data into the 'currencies' table
/* INSERT INTO [Sales].[Currency] 
(
    CurrencyCode, 
    Name, 
    ModifiedDate
    )
VALUES
( 'KYD', 'Cayman Dollar', GETDATE() ); */

-- Select statement to verify the inserted currency data
/* SELECT * FROM [Sales].[Currency] WHERE CurrencyCode = 'KYD'; */


-- Insert new curency (bitcoin - BTC) data into the 'currencies' table
/* INSERT INTO [Sales].[Currency] 
VALUES
( 'BTC', 'Bitcoin', GETDATE() ); */ 

-- Insert new currency (Litecoin - LTC) data into the 'currencies' table if not exists
IF NOT EXISTS (SELECT 1 FROM [Sales].[Currency] WHERE CurrencyCode = 'LTC')
BEGIN
    INSERT INTO [Sales].[Currency] (CurrencyCode, Name, ModifiedDate)
    VALUES ('LTC', 'Litecoin', GETDATE());
END

-- Select statement to verify the inserted currency data
/* SELECT * FROM [Sales].[Currency] WHERE CurrencyCode = 'BTC'; */

-- Partial insert statement (for reference, not to be executed)
-- INSERT INTO [Sales].[Currency] (CurrencyCode, Name, ModifiedDate) VALUES ('LTC', 'Litecoin'); 
-- Note: The above partial insert statement is incomplete but it should run without errors if the ModifiedDate column allows NULLs or has a default value.

-- Select statement to verify the inserted currency data
/* SELECT * FROM [Sales].[Currency] WHERE CurrencyCode = 'LTC'; */      


-- Inserting related data into another table 
-- Insert new CountryRegionCurrency data into the 'CountryRegionCurrency' table
/* INSERT INTO [Sales].[CountryRegionCurrency] 
(
    CountryRegionCode, 
    CurrencyCode, 
    ModifiedDate
)
VALUES
( 'KY', 'KYD', GETDATE() ),
( 'US', 'LTC', GETDATE() ); */

-- Select statement to verify the inserted CountryRegionCurrency data
/* SELECT * FROM [Sales].[CountryRegionCurrency] WHERE CountryRegionCode = 'KY'; */

-- Insert new Sales Teritory data into the 'SalesTerritory' table
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

-- Select statement to verify the inserted SalesTerritory data
/* SELECT * FROM [Sales].[SalesTerritory] WHERE CountryRegionCode = 'BS'; */


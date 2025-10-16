-- Title: T-SQL Transcations and Concurency Reference
-- Date: 2025-10-16
-- Author: Alin Airinei
-- Purpose: Create a reference list of useful queries and statements 
--
-- Tags: T-SQL, Transactions, SQL Server, Reference, Concurrency, Data Integrity, Error Handling
-- Usage: Run on local SQL Server with appropriate SA credentials
-- Note: Uncomment the statements to execute them as needed.


-- Transactions in T-SQL
-- Transactions are used to ensure data integrity and consistency. They allow you to group multiple SQL statements into a single unit of work that can be committed or rolled back as a whole.
-- This reference includes common transaction-related commands and settings in T-SQL.
-- Transaction types include:
-- 1. Explicit Transactions: Manually started and ended using BEGIN TRANSACTION, COMMIT, and ROLLBACK.
-- 2. Implicit Transactions: Automatically started by SQL Server when certain statements are executed, and must be explicitly committed or rolled back. -- This mode can be enabled using SET IMPLICIT_TRANSACTIONS ON. 
-- 3. Auto-commit Transactions: Each individual statement is treated as a transaction and is automatically committed if it completes successfully.  

-- Acid Properties of Transactions:
-- 1. Atomicity: Ensures that all operations within a transaction are completed successfully. If any operation fails, the entire transaction is rolled back.
-- 2. Consistency: Ensures that a transaction brings the database from one valid state to another, maintaining database invariants. 
-- 3. Isolation: Ensures that concurrent transactions do not interfere with each other. The effects of a transaction are not visible to other transactions until it is committed.
-- 4. Durability: Ensures that once a transaction is committed, its changes are permanent, even in the event of a system failure.   

--Isolation levels:
-- 1. Read Uncommitted: Allows dirty reads, meaning a transaction can read data that has been modified by another transaction but not yet committed.
-- 2. Read Committed: The default isolation level. Prevents dirty reads by ensuring that a transaction can only read data that has been committed by other transactions.
-- 3. Repeatable Read: Prevents non-repeatable reads by ensuring that if a transaction reads a row, no other transaction can modify that row until the first transaction is complete.
-- 4. Serializable: The highest isolation level. Prevents phantom reads by ensuring that if a transaction reads a set of rows, no other transaction can insert, update, or delete rows that would affect the result set until the first transaction is complete.
-- 5. Snapshot: Uses row versioning to provide a transactionally consistent view of the data as it existed at the start of the transaction, allowing for high concurrency without locking.  


-- Basic Locking, Blocking and Deadlocks:
-- 1. Locking: SQL Server uses locks to manage concurrent access to data. Locks can be at different levels (row, page, table) and types (shared, exclusive).    
-- 2. Blocking: Occurs when one transaction holds a lock on a resource that another transaction is trying to access. The second transaction must wait until the first transaction releases the lock.
-- 3. Deadlocks: Occur when two or more transactions are waiting for each other to release locks, resulting in a standstill. SQL Server automatically detects deadlocks and resolves them by terminating one of the transactions.

-- Types of Locks:
-- 1. Shared Locks (S): Used for read operations. Multiple transactions can hold shared locks on the same resource simultaneously.
-- 2. Exclusive Locks (X): Used for write operations. Only one transaction can hold an exclusive lock on a resource at a time.
-- 3. Update Locks (U): Used when a transaction intends to modify a resource. It allows multiple transactions to read the resource but prevents other transactions from acquiring exclusive locks.
-- 4. Intent Locks (IS, IX): Indicate a transaction's intention to acquire a shared or exclusive lock on a resource at a lower level in the hierarchy (e.g., table level).
-- 5. Schema Locks (Sch-S, Sch-M): Used to protect the schema of a database object during operations that modify the schema (e.g., ALTER TABLE).
-- 6. Bulk Update Locks (BU): Used during bulk copy operations to allow multiple transactions to read the data while preventing other transactions from acquiring exclusive locks.
-- 7. Range Locks: Used to protect a range of rows in a table, typically during index scans or range queries.
-- 8. Key-Range Locks: Used to protect a range of index keys, preventing phantom reads in serializable transactions.
-- 9. Application Locks: Custom locks that can be used by applications to manage concurrency at the application level.  

-- ============================================================================================================================================
/*
-- BEGIN TRANSACTION: Starts a new transaction.
BEGIN TRANSACTION;  
-- COMMIT TRANSACTION: Commits the current transaction, making all changes permanent.
COMMIT TRANSACTION;  
-- ROLLBACK TRANSACTION: Rolls back the current transaction, undoing all changes made in the transaction.
ROLLBACK TRANSACTION;  
-- SAVEPOINT: Sets a savepoint within a transaction to which you can later roll back.
SAVE TRANSACTION SavePointName;  
-- SET TRANSACTION ISOLATION LEVEL: Sets the isolation level for the current session.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;  
-- SET IMPLICIT_TRANSACTIONS: Enables or disables implicit transactions.
SET IMPLICIT_TRANSACTIONS ON;  
-- SET XACT_ABORT: Specifies whether SQL Server automatically rolls back the current transaction when a T-SQL statement raises a runtime error.
SET XACT_ABORT ON;  
-- @@TRANCOUNT: Returns the number of active transactions for the current connection.
SELECT @@TRANCOUNT;  
-- BEGIN TRY...END TRY / BEGIN CATCH...END CATCH: Used for error handling in transactions.
BEGIN TRY  
    BEGIN TRANSACTION;  
    -- Your SQL statements here
    COMMIT TRANSACTION;  
END TRY  
BEGIN CATCH  
    ROLLBACK TRANSACTION;  
    -- Error handling code here
END CATCH;  
-- SET NOCOUNT: Controls whether the message indicating the number of rows affected by a T-SQL statement is returned.
SET NOCOUNT ON;  
-- SET ANSI_WARNINGS: Controls whether certain conditions generate warnings or errors.
SET ANSI_WARNINGS ON;  
-- SET ARITHABORT: Specifies whether a query is terminated when an overflow or divide-by-zero error occurs during query execution.
SET ARITHABORT ON;  
-- SET CONCAT_NULL_YIELDS_NULL: Specifies whether concatenating a NULL value with a string yields NULL.
SET CONCAT_NULL_YIELDS_NULL ON;  
-- SET QUOTED_IDENTIFIER: Specifies how SQL Server treats quoted identifiers.
SET QUOTED_IDENTIFIER ON;  
-- SET ANSI_NULLS: Controls how SQL Server handles comparisons with NULL values.
SET ANSI_NULLS ON;  
-- SET ANSI_PADDING: Controls how SQL Server handles trailing spaces in variable-length columns.
SET ANSI_PADDING ON;  
-- SET ANSI_NULL_DFLT_ON: Specifies whether the default behavior for new columns is to allow NULLs.
SET ANSI_NULL_DFLT_ON ON;  
-- SET CURSOR_CLOSE_ON_COMMIT: Specifies whether cursors are closed when a transaction is committed.
SET CURSOR_CLOSE_ON_COMMIT OFF;  
-- SET DEADLOCK_PRIORITY: Sets the deadlock priority for the current session.
SET DEADLOCK_PRIORITY LOW;  
-- SET LOCK_TIMEOUT: Specifies the number of milliseconds a statement waits for a lock to be released.
SET LOCK_TIMEOUT 5000;  
-- SET TRANSACTION SNAPSHOT: Enables or disables the use of row versioning-based isolation levels.
SET TRANSACTION SNAPSHOT ON;  
-- SET RECURSIVE_TRIGGERS: Enables or disables recursive triggers.
SET RECURSIVE_TRIGGERS OFF;  
-- SET CONTEXT_INFO: Sets the context information for the current session.
DECLARE @Info VARBINARY(128) = CAST('MyContextInfo' AS VARBINARY(128));  
SET CONTEXT_INFO @Info;  
-- SET SESSION_CONTEXT: Sets a key-value pair in the session context.
EXEC sp_set_session_context 'MyKey', 'MyValue';  
-- GET SESSION_CONTEXT: Retrieves a value from the session context.
SELECT SESSION_CONTEXT(N'MyKey');  
-- DBCC OPENTRAN: Displays information about the oldest active transaction.
DBCC OPENTRAN;  
-- DBCC USEROPTIONS: Displays the current SET options for the session.      
DBCC USEROPTIONS;  
*/

-- Simulating a Transaction with Error Handling
/* BEGIN TRANSACTION

SELECT * FROM [Person].[Address]
WHERE AddressID = 1

SELECT @@SPID

COMMIT TRANSACTION */
/* 
SELECT @@SPID

BEGIN TRANSACTION

UPDATE [Person].[Address]
SET AddressLine1 = '1200 Napa Jamaica'
WHERE AddressID = 1

COMMIT TRANSACTION -- The transaction is committed here, making the update permanent. 

SELECT * FROM [Person].[Address]
WHERE AddressID = 1 */


-- Rollback Example
/* BEGIN TRANSACTION    
SELECT * FROM [Person].[Address]
WHERE AddressID = 1     
SELECT @@SPID
UPDATE [Person].[Address]
SET AddressLine1 = '1200 Napa Jamaica'
WHERE AddressID = 1
ROLLBACK TRANSACTION -- The transaction is rolled back here, undoing the update. 
SELECT * FROM [Person].[Address]
WHERE AddressID = 1
SELECT @@SPID */    

-- Savepoint Example
/* BEGIN TRANSACTION
SELECT * FROM [Person].[Address]
WHERE AddressID = 1     
SELECT @@SPID
UPDATE [Person].[Address]
SET AddressLine1 = '1200 Napa Jamaica'
WHERE AddressID = 1
SAVE TRANSACTION MySavePoint -- A savepoint is created here.
UPDATE [Person].[Address]
SET AddressLine1 = '1300 Napa Jamaica'
WHERE AddressID = 1
ROLLBACK TRANSACTION MySavePoint -- The transaction is rolled back to the savepoint, undoing the second update.
COMMIT TRANSACTION -- The transaction is committed here, making the first update permanent.
SELECT * FROM [Person].[Address]
WHERE AddressID = 1
SELECT @@SPID */    
-- Implicit Transaction Example
/* SET IMPLICIT_TRANSACTIONS ON
SELECT * FROM [Person].[Address]
WHERE AddressID = 1     
SELECT @@SPID
UPDATE [Person].[Address]
SET AddressLine1 = '1200 Napa Jamaica'
WHERE AddressID = 1
-- The transaction is still open here, waiting for a COMMIT or ROLLBACK.
COMMIT TRANSACTION -- The transaction is committed here, making the update permanent.
SELECT * FROM [Person].[Address]
WHERE AddressID = 1
SELECT @@SPID
SET IMPLICIT_TRANSACTIONS OFF */        

-- Error Handling Example
/* BEGIN TRY  
    BEGIN TRANSACTION;  
    UPDATE [Person].[Address]
    SET AddressLine1 = '1200 Napa Jamaica'
    WHERE AddressID = 1;  
    -- Intentionally causing an error by dividing by zero
    DECLARE @x INT = 1, @y INT = 0;
    DECLARE @z INT;
    SET @z = @x / @y;  
    COMMIT TRANSACTION;  
END TRY  
BEGIN CATCH  
    ROLLBACK TRANSACTION;  
    SELECT ERROR_NUMBER() AS ErrorNumber,
           ERROR_MESSAGE() AS ErrorMessage;
END CATCH;  
SELECT * FROM [Person].[Address]
WHERE AddressID = 1 */          



-- Note: Always test transaction-related commands in a safe environment before applying them to production databases.
-- ============================================================================================================================================
-- End of File
-- ============================================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================
-- ============================================================================================================================================


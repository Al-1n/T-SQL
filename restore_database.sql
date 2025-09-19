-- Title: Restore AdventureWorks2022
-- Date: 2025-09-17
-- Author: Alin Airinei
-- Purpose: Restore sample DB from .bak for local analysis/portfolio
-- Notes: Kept previous attempts below for debugging
-- Tags: restore, adventureworks, backup
-- Usage: Run on local SQL Server with appropriate SA credentials
--
-- 2025-09-17: Saved previous attempts / notes
-- Previous (commented and successful) restore attempt — kept for debugging
-- RESTORE DATABASE [AdventureWorks2022]
-- FROM DISK = N'/var/opt/mssql/backups/AdventureWorks2022.bak'
-- WITH MOVE N'AdventureWorks2022' TO N'/var/opt/mssql/data/AdventureWorks2022.mdf',
--      MOVE N'AdventureWorks2022'  TO N'/var/opt/mssql/data/AdventureWorks2022_log.ldf',
--      RECOVERY, REPLACE;

SELECT * FROM AdventureWorks2022.HumanResources.Department
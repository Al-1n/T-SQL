RESTORE DATABASE [AdventureWorks2022]
FROM DISK = N'/var/opt/mssql/backups/AdventureWorks2022.bak'
WITH MOVE N'AdventureWorks2022' TO N'/var/opt/mssql/data/AdventureWorks2022.mdf',
    MOVE N'AdventureWorks2022_log'  TO N'/var/opt/mssql/data/AdventureWorks2022_log.ldf',
     RECOVERY, REPLACE;

--
-- 2025-09-17: Saved previous attempts / notes
-- Previous (commented) restore attempt — kept for debugging
-- RESTORE DATABASE [AdventureWorks2022]
-- FROM DISK = N'/var/opt/mssql/backups/AdventureWorks2022.bak'
-- WITH MOVE N'AdventureWorks2022' TO N'/var/opt/mssql/data/AdventureWorks2022.mdf',
--      MOVE N'AdventureWorks2022'  TO N'/var/opt/mssql/data/AdventureWorks2022_log.ldf',
--      RECOVERY, REPLACE;
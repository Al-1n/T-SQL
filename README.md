# AdventureWorks2022 SQL Samples

This repository contains SQL scripts used for restoring and experimenting with the AdventureWorks2022 sample database locally.

## Getting the AdventureWorks2022 .bak

Microsoft distributes AdventureWorks sample databases. To obtain the `.bak` file:

1. Go to the official Microsoft SQL Server samples page or the GitHub repository for AdventureWorks. The canonical source is the Microsoft SQL Server samples on GitHub:

   https://github.com/microsoft/sql-server-samples

2. Search for `AdventureWorks` (look for the `AdventureWorks2022.bak` variant). Download the `.bak` file release or archive.

3. Copy the downloaded `.bak` into a folder accessible by your SQL Server instance, typically `/var/opt/mssql/backups` on Linux or the SQL Server backup folder on Windows.

## Restore instructions (Linux SQL Server example)

1. Copy the `.bak` into SQL Server backups folder and give the `mssql` user ownership:

```bash
sudo mkdir -p /var/opt/mssql/backups
sudo cp /path/to/AdventureWorks2022.bak /var/opt/mssql/backups/
sudo chown mssql:mssql /var/opt/mssql/backups/AdventureWorks2022.bak
```

2. Inspect the backup to find logical file names (useful for `MOVE`):

```bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Your_SA_password' \
  -Q "RESTORE FILELISTONLY FROM DISK = N'/var/opt/mssql/backups/AdventureWorks2022.bak';"
```

3. Restore the database (example):

```sql
RESTORE DATABASE [AdventureWorks2022]
FROM DISK = N'/var/opt/mssql/backups/AdventureWorks2022.bak'
WITH MOVE N'<LogicalDataName>' TO N'/var/opt/mssql/data/AdventureWorks2022.mdf',
     MOVE N'<LogicalLogName>'  TO N'/var/opt/mssql/data/AdventureWorks2022_log.ldf',
     RECOVERY, REPLACE;
```

Replace `<LogicalDataName>` and `<LogicalLogName>` with the values returned by `RESTORE FILELISTONLY`.



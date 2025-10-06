IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N"enrollment_db")
BEGIN
    CREATE DATABASE enrollment_db;
END
GO

USE enrollment_db;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.enrollment') AND type = 'U')


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.enrollment_allowed_module') AND type = 'U')

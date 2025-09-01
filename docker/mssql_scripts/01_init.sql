
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'identity_db')
BEGIN
    CREATE DATABASE identity_db;
END;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'course_db')
BEGIN
    CREATE DATABASE course_db;
END;
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'progress_db')
BEGIN
    CREATE DATABASE progress_db;
END;
GO

USE progress_db;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.progress') AND type = 'U')
BEGIN
    CREATE TABLE dbo.progress (
        id                          BIGINT IDENTITY(1,1) PRIMARY KEY,
        student_id                  BIGINT IDENTITY(1,1) NOT NULL,
        enrollment_id               BIGINT IDENTITY(1,1) NOT NULL,
        course_id                   BIGINT IDENTITY(1,1) NOT NULL,
        progress_percent            FLOAT NOT NULL,
        progress_status             NVARCHAR(15) NOT NULL,
        created_by                  NVARCHAR(100) NOT NULL,
        created_on                  DATETIMEOFFSET NOT NULL,
        last_modified_by            NVARCHAR(100) NOT NULL,
        last_modified_on            DATETIMEOFFSET NOT NULL,

        CONSTRAINT FK_PROGRESS
        FOREIGN KEY (progress_id) REFERENCES dbo.progress ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.lesson_progress') AND type = 'U')
BEGIN
    CREATE TABLE dbo.payment_method (
        id                          BIGINT IDENTITY(1,1) PRIMARY KEY,
        progress_id                 BIGINT IDENTITY(1,1) NOT NULL,
        lesson_id                   BIGINT IDENTITY(1,1) NULL,
        watched_duration_sec        INT NULL,
        completed                   BIT NOT NULL DEFAULT 0,
        created_by                  NVARCHAR(100) NOT NULL,
        created_on                  DATETIMEOFFSET NOT NULL,
        last_modified_by            NVARCHAR(100) NOT NULL,
        last_modified_on            DATETIMEOFFSET NOT NULL,

        CONSTRAINT FK_PROGRESS
        FOREIGN KEY (progress_id) REFERENCES dbo.progress ON DELETE CASCADE
    );
END;
GO
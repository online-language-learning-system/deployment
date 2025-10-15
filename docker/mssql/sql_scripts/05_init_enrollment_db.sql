IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N"enrollment_db")
BEGIN
    CREATE DATABASE enrollment_db;
END
GO

USE enrollment_db;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.enrollment') AND type = 'U')
BEGIN
    CREATE TABLE dbo.enrollment (
        id                          BIGINT IDENTITY(1,1) PRIMARY KEY,
        student_id                  NVARCHAR(255) NOT NULL,
        course_id                   BIGINT NOT NULL,
        enrollment_type             NVARCHAR(255) NOT NULL,
        enrollment_status           NVARCHAR(20) NOT NULL,
        trial_start_on              DATETIMEOFFSET NULL,
        trial_end_on                DATETIMEOFFSET NULL,
        created_by                  NVARCHAR(100) NOT NULL,
        created_on                  DATETIMEOFFSET NOT NULL,
        last_modified_by            NVARCHAR(100) NOT NULL,
        last_modified_on            DATETIMEOFFSET NOT NULL
    );
END;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.enrollment_allowed_module') AND type = 'U')
BEGIN
    CREATE TABLE dbo.enrollment_allowed_module (
        id                  BIGINT IDENTITY(1,1) PRIMARY KEY,
        module_id           BIGINT NOT NULL,
        enrollment_id       BIGINT NOT NULL,

        CONSTRAINT FK_ENROLLMENT
        FOREIGN KEY (enrollment_id) REFERENCES dbo.enrollment(id) ON DELETE CASCADE
    );
END;
GO
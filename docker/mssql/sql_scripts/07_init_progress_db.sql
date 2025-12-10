-- =============================================
-- 🗃️ TẠO DATABASE
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'progress_db')
BEGIN
    CREATE DATABASE progress_db;
END
GO

USE progress_db;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbo')
BEGIN
    EXEC('CREATE SCHEMA dbo');
END
GO

-- =============================================
-- 🧩 BẢNG: progress
-- =============================================
CREATE TABLE dbo.progress (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    student_id NVARCHAR(255) NULL,
    enrollment_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    progress_percent FLOAT DEFAULT 0.0,
    progress_status NVARCHAR(50) NULL,

    -- Các cột kế thừa từ AbstractAuditEntity (đổi tên cho khớp với entity)
    created_by NVARCHAR(255) NULL,
    created_on DATETIMEOFFSET(7) DEFAULT SYSDATETIMEOFFSET(),
    last_modified_by NVARCHAR(255) NULL,
    last_modified_on DATETIMEOFFSET(7) DEFAULT SYSDATETIMEOFFSET(),

    CONSTRAINT uq_progress_enrollment_course UNIQUE (enrollment_id, course_id)
);
GO

-- =============================================
-- 🧩 BẢNG: lesson_progress
-- =============================================
CREATE TABLE dbo.lesson_progress (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    progress_id BIGINT NULL,
    lesson_id BIGINT NOT NULL,
    watched_duration_sec INT DEFAULT 0,
    completed BIT NOT NULL DEFAULT 0,
    completed_at DATETIMEOFFSET(7) NULL,

    -- Audit columns (đổi tên)
    created_by NVARCHAR(255) NULL,
    created_on DATETIMEOFFSET(7) DEFAULT SYSDATETIMEOFFSET(),
    last_modified_by NVARCHAR(255) NULL,
    last_modified_on DATETIMEOFFSET(7) DEFAULT SYSDATETIMEOFFSET(),

    CONSTRAINT fk_lesson_progress_progress FOREIGN KEY (progress_id)
        REFERENCES dbo.progress (id)
        ON DELETE CASCADE
);
GO

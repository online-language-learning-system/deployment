-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'enrollment_db')
BEGIN
    CREATE DATABASE enrollment_db;
END
GO

-- Chọn database cần sử dụng
USE enrollment_db;
GO

-- Tạo schema nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dto')
BEGIN
    EXEC('CREATE SCHEMA dto');
END
GO

-- Bảng enrollment
CREATE TABLE dto.enrollment (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    student_id NVARCHAR(255),
    course_id BIGINT,

    -- enum lưu dạng string
    enrollment_type NVARCHAR(50) NOT NULL,
    enrollment_status NVARCHAR(50) NOT NULL,

    trial_start_on DATETIMEOFFSET,
    trial_end_on DATETIMEOFFSET,

    -- Audit fields
    created_by NVARCHAR(255),
    created_on DATETIMEOFFSET,
    last_modified_by NVARCHAR(255),
    last_modified_on DATETIMEOFFSET
);
GO

-- Bảng enrollment_allowed_module
CREATE TABLE dto.enrollment_allowed_module (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    module_id BIGINT NOT NULL,
    enrollment_id BIGINT NOT NULL,

    CONSTRAINT fk_enrollment_allowed_module_enrollment
        FOREIGN KEY (enrollment_id)
        REFERENCES dto.enrollment(id)
        ON DELETE CASCADE
);
GO

-- 1️⃣ Tạo database nếu chưa có
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'notification_db')
BEGIN
    CREATE DATABASE notification_db;
END
GO

-- 2️⃣ Chọn database
USE notification_db;
GO

-- 3️⃣ Tạo schema dbo (mặc định SQL Server có sẵn, nhưng thêm để đảm bảo)
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbo')
BEGIN
    EXEC('CREATE SCHEMA dbo');
END
GO

-- 4️⃣ Bảng Notification
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='notification' AND xtype='U')
BEGIN
    CREATE TABLE dbo.notification (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        recipient NVARCHAR(255) NOT NULL,
        notification_status NVARCHAR(50) NOT NULL,

        -- Audit fields (từ AbstractAuditEntity)
        created_by NVARCHAR(255) NULL,
        created_on DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET(),
        last_modified_by NVARCHAR(255) NULL,
        last_modified_on DATETIMEOFFSET DEFAULT SYSDATETIMEOFFSET()
    );
END
GO

-- 5️⃣ Bảng Notification_Content
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='notification_content' AND xtype='U')
BEGIN
    CREATE TABLE dbo.notification_content (
        id BIGINT IDENTITY(1,1) PRIMARY KEY,
        notification_id BIGINT NOT NULL,
        content NVARCHAR(MAX) NOT NULL,

        CONSTRAINT FK_notification_content_notification FOREIGN KEY (notification_id)
            REFERENCES dbo.notification(id)
            ON DELETE CASCADE
    );
END
GO


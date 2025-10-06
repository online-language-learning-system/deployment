IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'order_db')
BEGIN
    CREATE DATABASE order_db;
END;
GO

USE order_db;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.[order]') AND type = 'U')
BEGIN
    CREATE TABLE dbo.[order] (
        id                          BIGINT IDENTITY(1,1) PRIMARY KEY,
        user_id                     NVARCHAR(255) NOT NULL,
        payment_id                  BIGINT NULL,
        total_price                 DECIMAL(9, 0) NOT NULL,
        total_discount_amount       FLOAT NULL,
        order_status                NVARCHAR(15) NOT NULL,
        reject_reason               TEXT NULL,
        created_by                  NVARCHAR(100) NOT NULL,
        created_on                  DATETIMEOFFSET NOT NULL,
        last_modified_by            NVARCHAR(100) NOT NULL,
        last_modified_on            DATETIMEOFFSET NOT NULL
    );
END;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.order_item') AND type = 'U')
BEGIN
    CREATE TABLE dbo.order_item (
        id                          BIGINT IDENTITY(1,1) PRIMARY KEY,
        order_id                    BIGINT NOT NULL,
        course_id                   BIGINT NOT NULL,
        course_title                NVARCHAR(255) NOT NULL,
        course_price                DECIMAL(9, 0) NOT NULL,
        discount_amount             FLOAT NULL,

        CONSTRAINT FK_ORDER
        FOREIGN KEY (order_id) REFERENCES dbo.[order](id) ON DELETE CASCADE
    );
END;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'cart_db')
BEGIN
    CREATE DATABASE cart_db;
END;
GO

USE cart_db;

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.cart_item') AND type = 'U')
BEGIN
    CREATE TABLE dbo.cart_item (
        user_id                 VARCHAR(255) NOT NULL,
        course_id               BIGINT NOT NULL,
        created_by              NVARCHAR(100) NOT NULL,
        created_on              DATETIMEOFFSET NOT NULL,
        last_modified_by        NVARCHAR(100) NOT NULL,
        last_modified_on        DATETIMEOFFSET NOT NULL,

        PRIMARY KEY (user_id, course_id)
    );
END;
GO
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'payment_db')
BEGIN
    CREATE DATABASE payment_db;
END;
GO

USE payment_db;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.payment_method') AND type = 'U')
BEGIN
    CREATE TABLE dbo.payment_method (
        paymentmethod_id INT IDENTITY(1,1) PRIMARY KEY,
        method_name NVARCHAR(50) NOT NULL,
        provider NVARCHAR(50) NULL,
        active BIT NOT NULL DEFAULT 1
    );
END;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.payment_method WHERE method_name = 'VNPay')
BEGIN
    INSERT INTO dbo.payment_method (method_name, provider, active)
    VALUES ('VNPay', 'VNPay', 1);
END;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.payment') AND type = 'U')
BEGIN
    CREATE TABLE dbo.payment (
        payment_id BIGINT IDENTITY(1,1) PRIMARY KEY,
        order_id BIGINT NOT NULL,
        user_id NVARCHAR(255) NOT NULL,
        amount DECIMAL(18,2) NOT NULL,
        currency NVARCHAR(10) NOT NULL DEFAULT N'Đ',
        paymentmethod_id INT NOT NULL,
        payment_status NVARCHAR(30) NOT NULL DEFAULT N'PENDING',
        transaction_code NVARCHAR(100) NULL,
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME NULL,
        last_modified_on DATETIMEOFFSET NULL,
        last_modified_by NVARCHAR(100) NULL,

        CONSTRAINT FK_payment_paymentmethod FOREIGN KEY (paymentmethod_id)
            REFERENCES dbo.payment_method(paymentmethod_id)
    );
END;
GO

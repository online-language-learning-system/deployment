
-- CREATE DATABASE
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'course_db')
BEGIN
	CREATE DATABASE course_db;
END;
GO

USE course_db;
GO

-- CREATE SCHEMA
IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'app')
BEGIN
	EXEC('CREATE SCHEMA app');
END;
GO

-- COURSES TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'app.courses') AND type = 'U') -- type = 'U': User table
BEGIN
	CREATE TABLE app.courses (
		id						UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
		title					NVARCHAR(255) NOT NULL,
		price                   DECIMAL(10, 2) NOT NULL,
		description				NVARCHAR(255) NULL,
		start_date				DATETIME NOT NULL,
		end_date				DATETIME NOT NULL,
		created_by				NVARCHAR(100) NOT NULL,
		created_on				DATETIME NOT NULL,
		last_modified_by		NVARCHAR(100) NOT NULL,
        last_modified_on		DATETIME NOT NULL
	);
END;
GO

MERGE app.courses AS target
USING (VALUES
    (N'Tiếng Nhật sơ cấp 1', 199.99, N'Học bảng chữ cái Hiragana, Katakana và từ vựng cơ bản', '2025-09-01', '2025-11-01'),
    (N'Tiếng Nhật sơ cấp 2', 219.99, N'Mở rộng từ vựng và ngữ pháp cơ bản', '2025-09-15', '2025-11-15'),
    (N'Tiếng Nhật trung cấp 1', 249.99, N'Ngữ pháp và hội thoại nâng cao', '2025-10-01', '2025-12-01'),
    (N'Tiếng Nhật trung cấp 2', 269.99, N'Hội thoại thực tế và kỹ năng nghe đọc', '2025-10-10', '2025-12-10'),
    (N'Tiếng Nhật N5', 199.99, N'Ôn luyện và thi chứng chỉ JLPT N5', '2025-09-05', '2025-11-05'),
    (N'Tiếng Nhật N4', 229.99, N'Ôn luyện và thi chứng chỉ JLPT N4', '2025-09-20', '2025-11-20'),
    (N'Tiếng Nhật giao tiếp cơ bản', 179.99, N'Học các mẫu câu hội thoại hàng ngày', '2025-09-25', '2025-12-01'),
    (N'Tiếng Nhật thương mại', 299.99, N'Giao tiếp trong môi trường công sở và kinh doanh', '2025-10-01', '2025-12-15'),
    (N'Tiếng Nhật nghe hiểu', 189.99, N'Rèn kỹ năng nghe và phản xạ nhanh', '2025-10-05', '2025-12-20'),
    (N'Tiếng Nhật viết thư tín', 169.99, N'Học viết email, thư từ bằng Tiếng Nhật chuẩn', '2025-10-10', '2025-12-25')
) AS source (title, price, description, start_date, end_date)
ON target.title = source.title
WHEN NOT MATCHED THEN
    INSERT (id, title, price, description, start_date, end_date, created_by, created_on, last_modified_by, last_modified_on)
    VALUES (NEWID(), source.title, source.price, source.description, source.start_date, source.end_date, 'admin', GETDATE(), 'admin', GETDATE());
GO


-- MODULES TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'app.modules') AND type = 'U')
BEGIN
	CREATE TABLE app.modules (
		id						UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
		course_id				UNIQUEIDENTIFIER NOT NULL,
		title					NVARCHAR(255) NOT NULL,
		position				INT NOT NULL DEFAULT 0,
		description				VARCHAR(255) NULL,	
		created_on				DATETIME NOT NULL,
        last_modified_on		DATETIME NOT NULL
	);
END;
GO

-- LESSONS TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'app.lessons') AND TYPE = 'U')
BEGIN
	CREATE TABLE app.lessons (
		id						UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
		module_id				UNIQUEIDENTIFIER NOT NULL,
		title					NVARCHAR(255) NOT NULL,
		content_ref				UNIQUEIDENTIFIER NULL,
		position				INT NOT NULL DEFAULT 0,
		description				VARCHAR(255) NULL,
		created_on				DATETIME NOT NULL,
        last_modified_on		DATETIME NOT NULL
	);
END;
GO
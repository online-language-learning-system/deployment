
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

-- COURSE CATEGORY TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'app.course_category') AND type = 'U')
BEGIN
	CREATE TABLE app.course_category (
		id						BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
		level                   NVARCHAR(255) NOT NULL,
		description				NVARCHAR(255) NULL,
		created_by				NVARCHAR(100) NOT NULL,
		last_modified_by		NVARCHAR(100) NOT NULL,
		created_on				DATETIME NOT NULL,
        last_modified_on		DATETIME NOT NULL
	);
END;
GO

-- COURSES TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'app.courses') AND type = 'U') -- type = 'U': User table
BEGIN
	CREATE TABLE app.courses (
		id						BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
		title					NVARCHAR(255) NOT NULL,
		teaching_language       NVARCHAR(255) NOT NULL,
		price                   DECIMAL(10, 2) NOT NULL,
		description				NVARCHAR(255) NULL,
		start_date				DATETIME NOT NULL,
		end_date				DATETIME NOT NULL,
		is_approval             BIT NOT NULL,
		created_by				NVARCHAR(100) NOT NULL,
		created_on				DATETIME NOT NULL,
		last_modified_by		NVARCHAR(100) NOT NULL,
        last_modified_on		DATETIME NOT NULL
	);
END;
GO

MERGE app.courses AS target
USING (VALUES
    -- DATA INITIALIZATION
) AS source (title, teaching_language, price, description, start_date, end_date)
ON target.title = source.title
WHEN NOT MATCHED THEN
    INSERT (teaching_language, title, price, description, start_date, end_date, created_by, created_on, last_modified_by, last_modified_on)
    VALUES (source.teaching_language, source.title, source.price, source.description, source.start_date, source.end_date, 'admin', GETDATE(), 'admin', GETDATE());
GO

-- COURSE IMAGE TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'app.course_image') AND type = 'U')
BEGIN
	CREATE TABLE app.course_image (
		id						BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
        image_url				NVARCHAR(255) NOT NULL,
        course_id				BIGINT,
	);
END;
GO

-- MODULES TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'app.modules') AND type = 'U')
BEGIN
	CREATE TABLE app.modules (
		id						BIGINT NOT NULL PRIMARY KEY DEFAULT NEWID(),
		course_id				BIGINT NOT NULL,
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
		id						BIGINT NOT NULL PRIMARY KEY DEFAULT NEWID(),
		module_id				BIGINT NOT NULL,
		title					NVARCHAR(255) NOT NULL,
		content_ref				BIGINT NULL,
		position				INT NOT NULL DEFAULT 0,
		description				VARCHAR(255) NULL,
		created_on				DATETIME NOT NULL,
        last_modified_on		DATETIME NOT NULL
	);
END;
GO
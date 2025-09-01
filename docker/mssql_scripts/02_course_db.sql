
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
		title					VARCHAR(255) NOT NULL,
		description				VARCHAR(255) NULL,
		start_date				TIMESTAMP NOT NULL,
		end_date				TIMESTAMP NOT NULL,
		created_by				VARCHAR(100) NOT NULL,
		created_on				TIMESTAMP NOT NULL,
		last_modifield_by		VARCHAR(100) NOT NULL,
        last_modifield_on		TIMESTAMP NOT NULL
	);
END;
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
		created_on				TIMESTAMP NOT NULL,
        last_modifield_on		TIMESTAMP NOT NULL
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
		created_on				TIMESTAMP NOT NULL,
        last_modifield_on		TIMESTAMP NOT NULL
	);
END;
GO
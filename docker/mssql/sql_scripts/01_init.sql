IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'identity_db')
BEGIN
    CREATE DATABASE identity_db;
END;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'course_db')
BEGIN
    CREATE DATABASE course_db;
END;
GO

USE course_db;

-- COURSE CATEGORY TABLE AND INIT DATA
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.course_category') AND type = 'U')
BEGIN
    CREATE TABLE dbo.course_category (
        id                  BIGINT IDENTITY(1,1) PRIMARY KEY,
        category_level      NVARCHAR(5) NOT NULL,
        description         NVARCHAR(255) NOT NULL
    );

    INSERT INTO dbo.course_category (category_level, description)
    VALUES
        (N'N5', N'Cơ bản sơ cấp:' + CHAR(13) + CHAR(10) +
            N'Hiểu và sử dụng các cụm từ, câu cơ bản trong tiếng Nhật. ' +
            N'Đọc và nhận biết hiragana, katakana, và một số kanji rất đơn giản. ' +
            N'Giới thiệu bản thân, hỏi những câu đơn giản, và tham gia các cuộc trò chuyện ngắn hàng ngày.'),

        (N'N4', N'Sơ cấp trên:' + CHAR(13) + CHAR(10) +
            N'Hiểu các cuộc trò chuyện cơ bản nói chậm trong đời sống hàng ngày. ' +
            N'Đọc và hiểu các câu cơ bản sử dụng từ vựng và kanji phổ biến. ' +
            N'Thực hiện giao tiếp đơn giản trong cuộc sống thường nhật.'),

        (N'N3', N'Trung cấp:' + CHAR(13) + CHAR(10) +
            N'Hiểu các tình huống hàng ngày với các cuộc trò chuyện phức tạp hơn. ' +
            N'Đọc các văn bản có nội dung cụ thể như tiêu đề, bài luận, hoặc thư từ.'),
        (N'N2', N'Trung cấp cao:' + CHAR(13) + CHAR(10) +
            N'Hiểu các chủ đề chung và các cuộc trò chuyện chi tiết với tốc độ tự nhiên. ' +
            N'Đọc báo chí, bài xã luận, tạp chí và các bài viết chuyên sâu.'),

        (N'N1', N'Nâng cao:' + CHAR(13) + CHAR(10) +
            N'Hiểu tiếng Nhật trong nhiều bối cảnh khác nhau, bao gồm các chủ đề trừu tượng hoặc phức tạp. ' +
            N'Đọc và hiểu các văn bản nâng cao như tài liệu học thuật và tác phẩm văn học.');

END;

-- COURSES TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.course') AND type = 'U')
BEGIN
    CREATE TABLE dbo.course (
        id                      BIGINT IDENTITY(1,1) PRIMARY KEY,
        category_id             BIGINT NOT NULL,
        title                   NVARCHAR(100) NOT NULL,
        teaching_language       NVARCHAR(20) NOT NULL,
        price                   DECIMAL(9, 0) NOT NULL,
        description             NVARCHAR(255) NOT NULL,
        start_date               DATETIMEOFFSET NOT NULL,
        end_date                 DATETIMEOFFSET NOT NULL,
        approval_status          NVARCHAR(20) NOT NULL,
        created_by              NVARCHAR(100) NOT NULL,
        created_on              DATETIMEOFFSET NOT NULL,
        last_modified_by        NVARCHAR(100) NOT NULL,
        last_modified_on        DATETIMEOFFSET NOT NULL,

        CONSTRAINT FK_Course_Category
        FOREIGN KEY (category_id) REFERENCES dbo.course_category(id) ON DELETE CASCADE
    );
END;

-- IMAGE TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.course_image') AND type = 'U')
BEGIN
    CREATE TABLE dbo.course_image (
        id              BIGINT IDENTITY(1,1) PRIMARY KEY,
        course_id       BIGINT NOT NULL,
        image_url       NVARCHAR(255) NOT NULL,

        CONSTRAINT FK_Course_Image
        FOREIGN KEY (course_id) REFERENCES dbo.course(id) ON DELETE CASCADE
    );
END;

-- MODULE TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.course_module') AND type = 'U')
BEGIN
    CREATE TABLE dbo.course_module (
        id                    BIGINT IDENTITY(1,1) PRIMARY KEY,
        course_id             BIGINT NOT NULL,
        title                 NVARCHAR(100) NOT NULL,
        description           NVARCHAR(255) NOT NULL,
        order_index           INT NOT NULL,
        can_free_trial        BIT NOT NULL,
        created_by            NVARCHAR(100) NOT NULL,
        created_on            DATETIMEOFFSET NOT NULL,
        last_modified_by      NVARCHAR(100) NOT NULL,
        last_modified_on      DATETIMEOFFSET NOT NULL,

        CONSTRAINT FK_Course_Module
        FOREIGN KEY (course_id) REFERENCES dbo.course(id) ON DELETE CASCADE
    );
END;

-- LESSON TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.lesson') AND type = 'U')
BEGIN
    CREATE TABLE dbo.lesson (
        id                    BIGINT IDENTITY(1,1) PRIMARY KEY,
        module_id             BIGINT NOT NULL,
        title                 NVARCHAR(100) NOT NULL,
        description           NVARCHAR(255) NOT NULL,
        duration              INTEGER NULL,
        created_by            NVARCHAR(100) NOT NULL,
        created_on            DATETIMEOFFSET NOT NULL,
        last_modified_by      NVARCHAR(100) NOT NULL,
        last_modified_on      DATETIMEOFFSET NOT NULL,

        CONSTRAINT FK_Course_Lesson
        FOREIGN KEY (module_id) REFERENCES dbo.course_module(id) ON DELETE CASCADE
    );
END;

-- LESSON RESOURCE TABLE
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.lesson_resource') AND type = 'U')
BEGIN
    CREATE TABLE dbo.lesson_resource (
        id                    BIGINT IDENTITY(1,1) PRIMARY KEY,
        lesson_id             BIGINT NOT NULL,
        resource_type         NVARCHAR(10) NOT NULL,
        resource_url          NVARCHAR(255) NULL,

        CONSTRAINT FK_Lesson_Resource
        FOREIGN KEY (lesson_id) REFERENCES dbo.lesson(id) ON DELETE CASCADE
    );
END;


USE course_db;

IF NOT EXISTS (SELECT 1 FROM dbo.course)
BEGIN
    INSERT INTO dbo.course
    (category_id, title, teaching_language, price, description, start_date, end_date,
     approval_status, created_by, created_on, last_modified_by, last_modified_on)
    VALUES
    (
        2,
        N'Khóa học Tiếng Nhật Trung Cấp',
        N'Tiếng Việt',
        199000,
        N'Nâng cao kỹ năng tiếng Nhật qua hội thoại, ngữ pháp và đọc hiểu.',
        '2026-12-25T08:30:00+07:00',
        '2027-12-25T08:30:00+07:00',
        N'APPROVED',
        N'Super Admin',
        SYSDATETIMEOFFSET(),
        N'Super Admin',
        SYSDATETIMEOFFSET()
    );

    -- GET COURSE ID THAT INSERTED
    DECLARE @CourseId BIGINT = SCOPE_IDENTITY();


    -- INSERT IMAGE
    INSERT INTO dbo.course_image
        (course_id, image_url)
    VALUES (
        @CourseId,
        N'01_image.jpg'
    );

    -- INSERT RELATIVE MODULE
    INSERT INTO dbo.course_module
        (course_id, title, description, order_index, can_free_trial,
        created_by, created_on, last_modified_by, last_modified_on)
    VALUES
        (
            @CourseId,
            N'Ngữ pháp và hội thoại',
            N'Học ngữ pháp nâng cao và áp dụng vào hội thoại thực tế.',
            1,
            1,
            N'Super Admin',
            SYSDATETIMEOFFSET(),
            N'Super Admin',
            SYSDATETIMEOFFSET()
        );

    DECLARE @ModuleId BIGINT = SCOPE_IDENTITY();

    INSERT INTO dbo.lesson (
        module_id, title, description, duration,
        created_by, created_on, last_modified_by, last_modified_on)
    VALUES (
        @ModuleId,
        N'Ngữ pháp JLPT N4',
        N'Các cấu trúc ngữ pháp cần thiết cho trình độ N4.',
        60,
        N'Super Admin',
        SYSDATETIMEOFFSET(),
        N'Super Admin',
        SYSDATETIMEOFFSET()
    );

    DECLARE @LessonId1 BIGINT = SCOPE_IDENTITY();

    INSERT INTO dbo.lesson_resource (lesson_id, resource_type, resource_url)
    VALUES
        (@LessonId1, N'WORD', N'01_lesson.docx'),
        (@LessonId1, N'PDF', N'02_lesson.pdf');

    INSERT INTO dbo.lesson (
        module_id, title, description, duration,
        created_by, created_on, last_modified_by, last_modified_on)
    VALUES (
        @ModuleId,
        N'Hội thoại nâng cao',
        N'Luyện hội thoại theo chủ đề hàng ngày.',
        50,
        N'Super Admin',
        SYSDATETIMEOFFSET(),
        N'Super Admin',
        SYSDATETIMEOFFSET()
    );

    DECLARE @LessonId2 BIGINT = SCOPE_IDENTITY();

    INSERT INTO dbo.lesson_resource (lesson_id, resource_type, resource_url)
    VALUES
        (@LessonId2, N'WORD', N'03_lesson.docx'),
        (@LessonId2, N'VIDEO', N'04_lesson.mp4');

END;
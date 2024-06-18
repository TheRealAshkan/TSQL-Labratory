USE Laboratory;
GO

-- ایجاد Stored Procedure برای ثبت اطلاعات آزمایشات
DROP PROCEDURE IF EXISTS SPTestInfo
GO

CREATE PROCEDURE SPTestInfo
    @TestTypeID int,
    @PatientID int,
    @TestDate DATE,
    @ResponseDate DATE,
    @Price int,
    @DeliveryStatus NVARCHAR(50)
AS
BEGIN
    -- بررسی وجود بیمار با PatientID مورد نظر
    IF EXISTS (SELECT 1 FROM Patient WHERE PatientID = @PatientID)
    BEGIN
        -- وارد کردن اطلاعات آزمایش به جدول Test
        INSERT INTO Test (TestTypeID, TestDate, ResponseDate, Price, DeliveryStatus, PatientID)
        VALUES (@TestTypeID, @TestDate, @ResponseDate, @Price, @DeliveryStatus, @PatientId);
        
        PRINT 'اطلاعات آزمایش با موفقیت ثبت شد.';
    END
    ELSE
    BEGIN
        PRINT 'بیمار با کد مورد نظر وجود ندارد.';
    END
END;
GO


-- EXEC SPTestInfo 
--     @TestTypeID = 3,
--     @PatientID = 3,
--     @TestDate = N'2024-01-01',
--     @ResponseDate = N'2024-01-01',
--     @Price = 1250000,
--     @DeliveryStatus = 1






-- ویرایش نام و نام خانوادگی بیماران
DROP PROCEDURE IF EXISTS SPUpdatePatientNames
GO

CREATE PROCEDURE SPUpdatePatientNames
    @PatientID int,
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100)
AS
BEGIN
    UPDATE Patient
    SET
        FirstName = @FirstName,
        LastName = @LastName
    WHERE PatientID = @PatientID   
END;
GO


-- EXEC SPUpdatePatientNames 
--     @PatientID = 1,
--     @FirstName = N'اشکان',
--     @LastName = N'مهدی زاده'



-- لیست آزمایش های تحویل نشده به بیماران
DROP PROCEDURE IF EXISTS SPTestResultNotDelivered
GO

CREATE PROCEDURE SPTestResultNotDelivered
    @PatientID int
AS
BEGIN
    SELECT 
        t.TestID, 
        t.PatientID,
       tt.TestTitle AS N'آزمایش'
    FROM Test t 
    JOIN TestType tt ON t.TestTypeID = tt.TestTypeID
    WHERE t.DeliveryStatus = 0 AND t.PatientID = @PatientID
END;
GO


EXEC SPTestResultNotDelivered 
    @PatientID = 1


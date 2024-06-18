USE Laboratory;
GO

INSERT INTO TestType (TestTitle, Price)
VALUES 
(N'آزمایش خون', 200000),
(N'آزمایش اوره', 180000),
(N'آزمایش ادرار', 180000),
(N'آزمایش ویتامین D', 180000),
(N'آزمایش قند خون', 180000);
GO


INSERT INTO InsuranceType (Title)
VALUES 
(N'بیمه آزاد'),
(N'بیمه تامین اجتماعی'),
(N'بیمه خدمات درمانی');
GO


INSERT INTO Patient 
(
    NationalCode,
    FirstName,
    LastName,
    BirthDate,
    FatherName,
    Gender
)
VALUES 
('0313040605', N'اشکان',N'مهدی زاده', '2000-01-01', N'محمدعلی', 1),
('1234567890', N'رضا',N'قادری', '2004-01-01', N'قنبر', 0);
GO


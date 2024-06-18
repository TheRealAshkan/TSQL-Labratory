USE Laboratory;
GO


-- ایجاد ویو برای نمایش تعداد جزئیات آزمایش هر شخص
DROP VIEW IF EXISTS TestDetailsCountPerPatient; 
GO

CREATE VIEW TestDetailsCountPerPatient AS
SELECT 
    p.PatientID AS N'شناسه بیمار',
    CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار',
    COUNT(td.DetailID) AS N'تعداد جزئیات آزمایش'
FROM Test t
LEFT JOIN TestDetail td ON t.TestID = td.TestID
LEFT JOIN Patient p ON t.PatientID = p.PatientID
GROUP BY 
    p.PatientID,
    p.FirstName,
    p.LastName;
GO

SELECT * FROM TestDetailsCountPerPatient


-- ایجاد ویو برای نمایش سه نفر از افرادی که بیشترین درآمدزایی داشته‌اند
DROP VIEW IF EXISTS Top3IncomePatients; 
GO
CREATE VIEW Top3IncomePatients AS (
    SELECT TOP 3 
        p.PatientID AS N'شناسه بیمار',
        CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار',
        SUM(t.Price) AS N'جمع هزینه آزمایشات'
    FROM Patient p
    JOIN Test t ON p.PatientID = t.PatientID
    GROUP BY 
        p.PatientID,
        p.FirstName,
        p.LastName
)
GO

SELECT * FROM Top3IncomePatients



-- افرادی که آزمایش اوره داشته اند و آزمایش ویتامین D نداشتن
DROP VIEW IF EXISTS PatientsWithUreaAndNoVitaminD ; 
GO
CREATE VIEW PatientsWithUreaAndNoVitaminD  AS (
    SELECT
        p.PatientID AS N'شناسه بیمار',
        CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار'
    FROM Patient p
    WHERE 
    EXISTS (
        SELECT 1
        FROM Test t
        WHERE t.PatientID = p.PatientID
        AND t.TestTypeID = 5
    )
    AND NOT EXISTS (
        SELECT 1
        FROM Test t
        WHERE t.PatientID = p.PatientID
        AND t.TestTypeID = 3
    )
);
GO

SELECT * FROM PatientsWithUreaAndNoVitaminD 



-- ایجاد ویو برای نمایش افراد با آزمایش آهن و بیمه آزاد
DROP VIEW IF EXISTS PatientsWithIronTestAndFreeInsurance  ; 
GO
CREATE VIEW PatientsWithIronTestAndFreeInsurance   AS (
    SELECT
        p.PatientID AS N'شناسه بیمار',
        CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار'
    FROM Patient p
    JOIN Test t ON p.PatientID = t.PatientID
    WHERE 
        t.TestTypeID = 4
        AND p.InsuranceTypeID = 1
);
GO

SELECT * FROM PatientsWithIronTestAndFreeInsurance  


-- افرادی که بیش از دو نوع آزمایش و بیمه خدمات درمانی دارند
DROP VIEW IF EXISTS PatientsWithMoreThanTwoTestsAndMedicalInsurance; 
GO
CREATE VIEW PatientsWithMoreThanTwoTestsAndMedicalInsurance AS (
    SELECT
        p.PatientID AS N'شناسه بیمار',
        CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار'
    FROM Patient p
    JOIN Test t ON p.PatientID = t.PatientID
    WHERE 
        p.InsuranceTypeID = 2
    GROUP BY 
        p.PatientID,
        p.FirstName,
        p.LastName
    HAVING 
    COUNT(DISTINCT t.TestTypeID) > 2
);
GO

SELECT * FROM PatientsWithMoreThanTwoTestsAndMedicalInsurance



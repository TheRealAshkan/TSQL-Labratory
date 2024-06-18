-- میزان درامد هر ماه
SELECT 
    YEAR(t.TestDate) AS N'سال'  ,
    MONTH(t.TestDate) AS N'ماه'  ,
    SUM(t.Price) AS N'میزان درامد'
FROM 
    Test t
GROUP BY 
    YEAR(t.TestDate),
    MONTH(TestDate)

-- لیست آزمایشاتی که تحویل مشتریان نشده اند
SELECT 
    t.TestID AS N'شناسه آزمایش',
    tt.TestTitle AS N'عنوان آزمایش',
    CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار'
FROM 
    Test t
INNER JOIN TestType tt ON t.TestTypeID = tt.TestTypeID
INNER JOIN Patient p ON t.PatientID = p.PatientID
WHERE
    t.DeliveryStatus = 0


-- میزان درامد از هر نوع بیمه
SELECT 
    it.Title AS N'بیمه',
    SUM(t.Price) AS N'میزان درامد'
FROM 
    Test t
INNER JOIN Patient p ON t.PatientID = p.PatientID
INNER JOIN InsuranceType it ON it.InsuranceTypeID = p.InsuranceTypeID
GROUP BY 
    it.InsuranceTypeID,
    it.Title


-- افرادی که بیش از دوبار مراجعه کردن
SELECT 
    p.PatientID AS N'شناسه بیمار',
    CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار',
    COUNT(t.TestID) AS N'تعداد مراجعه'
FROM Test t
JOIN Patient p ON (t.PatientID = p.PatientID)
GROUP BY 
    p.PatientID,
    p.FirstName,
    p.LastName
HAVING 
    COUNT(t.TestID) > 2 


-- نمایش جزئیات کامل آخرین آزمایش مربوط به فردی که 4 بار مراجعه داشته است
SELECT 
    t.TestID AS N'شناسه آزمایش',
    tt.TestTitle AS N'عنوان آزمایش',
    t.TestDate AS N'تاریخ آزمایش',
    t.ResponseDate AS N'تاریخ نتیجه آزمایش',
    t.Price AS N'هزینه آزمایش',
    CONCAT(p.FirstName , ' ' , p.LastName) AS N'نام بیمار',
    DATEDIFF(YEAR, p.BirthDate, GETDATE()) AS N'سن بیمار',
    p.FatherName AS N'نام پدر',
    CASE 
        WHEN p.Gender = 1 THEN N'مرد'
        WHEN p.Gender = 0 THEN N'زن'
    END AS  N'جنسیت',
    p.InsuranceCode AS N'کد بیمه',
    td.TestResult AS N'نتیجه آزمایش'
FROM Test t
JOIN Patient p ON t.PatientID = p.PatientID
JOIN TestType tt ON t.TestTypeID = tt.TestTypeID
LEFT JOIN TestDetail td ON t.TestID = td.TestID
WHERE 
    t.PatientID IN (
        SELECT 
            p.PatientID
        FROM 
            Test t
        JOIN 
            Patient p ON t.PatientID = p.PatientID
        GROUP BY 
            p.PatientID,
            p.FirstName,
            p.LastName
        HAVING 
            COUNT(t.TestID) = 4
    )
AND 
    t.TestDate = (
        SELECT MAX(TestDate)
        FROM Test
        WHERE PatientID = p.PatientID
    );

-- BAI TAP: TRUY VAN DU LIEU VOI CSDL QUAN LY SINH VIEN
-- MySQL
-- Luu y: Cac ten bang/cot duoi day theo cau truc pho bien:
-- Student(StudentID, StudentName, ClassID)
-- Class(ClassID, ClassName, StartDate)
-- Subject(SubID, SubName, Credit)
-- Mark(StudentID, SubID, Mark)
-- Neu CSDL cua ban dat ten cot/bang khac, hay sua cho dung truoc khi chay.

-- 1. Hien thi sinh vien co ten bat dau bang chu h
SELECT *
FROM Student
WHERE LOWER(StudentName) LIKE 'h%';

-- 2. Hien thi cac lop co thoi gian bat dau vao thang 12
SELECT *
FROM Class
WHERE MONTH(StartDate) = 12;

-- 3. Hien thi cac mon hoc co Credit trong khoang tu 3 den 5 (bao gom 3 va 5)
SELECT *
FROM Subject
WHERE Credit BETWEEN 3 AND 5;

-- 4. Thay doi ClassID cua sinh vien co ten Hung thanh 2
-- Kiem tra ket qua SELECT truoc khi UPDATE neu co nhieu sinh vien cung ten.
UPDATE Student
SET ClassID = 2
WHERE StudentName = 'Hung';

-- 5. Hien thi StudentName, SubName, Mark;
-- sap xep diem giam dan, neu trung diem thi ten sinh vien tang dan
SELECT s.StudentName, sub.SubName, m.Mark
FROM Student AS s
JOIN Mark AS m ON m.StudentID = s.StudentID
JOIN Subject AS sub ON sub.SubID = m.SubID
ORDER BY m.Mark DESC, s.StudentName ASC;

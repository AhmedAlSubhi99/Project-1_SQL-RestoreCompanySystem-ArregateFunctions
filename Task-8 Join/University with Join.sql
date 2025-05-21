use UNIVERSITY;

-- 1. Display the department ID, name, and the full name of the faculty managing it. 
SELECT d.Department_id, d.D_Name, F_Name AS manager_name
FROM department d INNER JOIN faculty f 
ON d.Department_id = f.Department_id;

-- 2. Display each program's name and the name of the department offering it. 
SELECT C.Course_Name, D.D_Name AS Department_Name
FROM Course C inner JOIN Handle_Course HC 
ON C.Course_id = HC.Course_id
left JOIN Department D 
ON HC.Department_id = D.Department_id;

-- 3. Display the full student data and the full name of their faculty advisor. 
SELECT S.*, F.F_Name AS Advisor_Name
FROM Student S Right OUTER JOIN Advises A 
ON S.S_id = A.S_id
LEFT OUTER JOIN Faculty F
ON A.F_id = F.F_id;

-- 4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'.
SELECT E.Exam_Code AS Class_ID, C.Course_Name, E.Room
FROM Exams E INNER JOIN Department D ON E.Department_id = D.Department_id
RIGHT OUTER JOIN Handle_Course HC ON D.Department_id = HC.Department_id
LEFT OUTER JOIN Course C ON HC.Course_id = C.Course_id
WHERE E.Room LIKE 'A%' OR E.Room LIKE 'B%';

-- 5. Display full data about courses whose titles start with "I" (e.g., "Introduction to...").
SELECT * 
FROM Course 
WHERE Course_Name LIKE 'I%';

-- 6. Display names of students in program ID 3 whose GPA is between 2.5 and 3.5. 
SELECT S.Fname, S.Lname,s.GPA
FROM Student S
JOIN Enroll E ON S.S_id = E.S_id
WHERE E.Course_id = 303
AND S.GPA BETWEEN 2.5 AND 3.5;

-- 7. Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course. 

-- Note: We dont provide grade table

-- 8. Find names of students who are advised by "Dr. Ahmed Hassan". 
SELECT S.Fname, S.Lname, F.F_Name
FROM Student S INNER JOIN Advises A ON S.S_id = A.S_id
RIGHT OUTER JOIN Faculty F ON A.F_id = F.F_id
WHERE F.F_Name = 'Dr. Ahmed';

-- 9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title.
SELECT S.Fname, S.Lname, C.Course_Name
FROM Student S LEFT OUTER JOIN Enroll E ON S.S_id = E.S_id
RIGHT OUTER JOIN Course C ON E.Course_id = C.Course_id
ORDER BY C.Course_Name;

-- 10.  For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class. 
SELECT E.Exam_Code AS Class_ID, C.Course_Name, D.D_Name AS Department_Name, F.F_Name AS Faculty_Name
FROM Exams E
JOIN Department D ON E.Department_id = D.Department_id
JOIN Handle_Course HC ON D.Department_id = HC.Department_id
JOIN Course C ON HC.Course_id = C.Course_id
JOIN Faculty F ON F.Department_id = D.Department_id
WHERE E.Room LIKE '%Main%';

-- 11.  Display all faculty members who manage any department. 
SELECT F.*
FROM Faculty F INNER JOIN Department D 
ON F.Department_id = D.Department_id;

-- 12.  Display all students and their advisors' names, even if some students don’t have advisors yet.
SELECT S.Fname, S.Lname, F.F_Name AS Advisor_Name
FROM Student S
LEFT JOIN Advises A ON S.S_id = A.S_id
LEFT JOIN Faculty F ON A.F_id = F.F_id;


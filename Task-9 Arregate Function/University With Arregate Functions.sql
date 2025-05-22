-- 6. Count total number of students in the Student table. 
SELECT COUNT(*) AS Total_Students
FROM Student;

-- 7. Count number of students per city (group by City in Student). 
SELECT City, COUNT(S_id) AS Students_Per_City
FROM Student
GROUP BY City
ORDER BY Students_Per_City DESC;

-- In the data I dont include City column

-- 8. Count students per course using Enrols (group by CourseID). 
SELECT Course_id, COUNT(S_id) AS Students_Per_Course
FROM Enroll
GROUP BY Course_id;

-- 9. Count number of courses per department using Course (group by DepartmentID).
SELECT D.D_Name AS Department_Name, D.Department_id, COUNT(DISTINCT C.Course_id) AS Courses_Per_Department
FROM Department D
JOIN Handle_Course HC ON D.Department_id = HC.Department_id
JOIN Course C ON HC.Course_id = C.Course_id
GROUP BY D.Department_id, D.D_Name;

-- 10. Count number of students assigned to each hostel (group by HostelID). 
SELECT Hostel_id, COUNT(*) AS Students_Per_Hostel
FROM Student
GROUP BY Hostel_id;

-- In the data I dont include FK (Hostel_id)
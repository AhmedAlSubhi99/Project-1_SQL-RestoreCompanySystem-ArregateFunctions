-- 1.  Count total number of employees in the Employees table. 
SELECT COUNT(*) AS Total_Employees
FROM employee;

-- 2.  Calculate average salary from the Salaries table. 
SELECT AVG(salary) AS Average_Salary
FROM employee;

-- 3.  Count employees in each department using Employees grouped by Dept_ID. 
SELECT Dno AS Department_ID, COUNT(*) AS Employee_Count
FROM employee
GROUP BY Dno;

-- 4.  Find total salary per department by joining Employees and Salaries. 
SELECT Dno AS Department_ID, SUM(salary) AS Total_Salary
FROM employee
GROUP BY Dno;

-- 5. Show departments (Dept_ID) having more than 5 employees with their counts.
SELECT Dno AS Department_ID, COUNT(*) AS Employee_Count
FROM employee
GROUP BY Dno
HAVING COUNT(*) > 5;

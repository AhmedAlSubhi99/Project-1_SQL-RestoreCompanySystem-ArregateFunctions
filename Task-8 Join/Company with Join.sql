-- Display the department ID, department name, manager ID, and the full name of the manager.
SELECT d.Dnum, d.dname, d.MGRSSN, CONCAT(e.fname, ' ', e.lname) AS Manager_name
FROM departments d inner JOIN employee e 
ON d.MGRSSN = e.SSN;

-- Display the names of departments and the names of the projects they control. 
SELECT d.Dname, p.Pname
FROM project p left outer JOIN departments d
ON d.Dnum = p.Dnum;

-- Display full data of all dependents, along with the full name of the employee they depend on. 
SELECT d.*, CONCAT(e.fname, ' ', e.lname) AS Employee_name
FROM dependent d full outer JOIN employee e 
ON d.ESSN = e.SSN;

-- Display the project ID, name, and location of all projects located in Cairo or Alex. 
SELECT Pnumber, Pname, Plocation, City
FROM project 
WHERE City IN ('Cairo', 'Alex');

-- Display all project data where the project name starts with the letter 'A'. 
SELECT * FROM project
WHERE pname LIKE 'A%';

-- Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE. 
SELECT ssn, fname, Lname , Salary
FROM employee
WHERE Dno = 30 AND salary BETWEEN 1000 AND 2000;

-- Retrieve the names of employees in department 10 who work ≥ 10 hours/week on the "AL Rabwah" project. 
SELECT DISTINCT e.fname, e.lname , Hours
FROM employee e inner JOIN Works_for w ON e.SSN = w.ESSn inner JOIN project p ON w.Pno = p.Pnumber
WHERE e.Dno = 10 AND p.Pname = 'AL Rabwah' AND w.hours >= 10;

-- Find the names of employees who are directly supervised by "Kamel Mohamed". 
SELECT e.fname, e.lname
FROM employee e inner JOIN employee s ON e.Superssn = s.SSN
WHERE CONCAT(s.fname, ' ', s.lname) = 'Kamel Mohamed';

-- Retrieve the names of employees and the names of the projects they work on, sorted by project name. 
SELECT e.fname, e.lname, p.pname
FROM employee e left outer JOIN Works_for w ON e.SSN = w.ESSn
right outer JOIN project p ON w.Pno = p.Pnumber
ORDER BY p.pname;

-- For each project located in Cairo, display the project number, controlling department name, manager's last name, address, and birthdate. 
SELECT p.Pnumber, d.dname, e.lname, e.Address, e.Bdate
FROM project p full outer JOIN departments d ON p.Dnum = d.Dnum inner JOIN employee e ON d.MGRSSN= e.SSN
WHERE p.City = 'Cairo';

-- Display all data of managers in the company. 
SELECT DISTINCT e.* 
FROM employee e
right outer JOIN departments d 
ON e.SSN = d.MGRSSN;

-- Display all employees and their dependents, even if some employees have no dependents.
SELECT e.*, d.Dependent_name
FROM employee e
LEFT JOIN dependent d ON e.SSN = d.ESSN;




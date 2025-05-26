-- Step 1: Create and Populate Tables
CREATE TABLE Employees 
(
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary INT,
    DeptID INT
);

INSERT INTO Employees (EmpID, Name, Salary, DeptID)
VALUES
    (1, 'Alice', 60000, 101),
    (2, 'Bob', 45000, 102),
    (3, 'Charlie', 75000, 101),
    (4, 'Diana', 50000, 103),
    (5, 'Eve', 68000, 102);

CREATE TABLE Departments 
(
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100)
);

INSERT INTO Departments (DeptID, DeptName, Location)
VALUES
    (101, 'Engineering', 'New York'),
    (102, 'Sales', 'Chicago'),
    (103, 'HR', 'San Francisco');

-- Step 2: Tasks
-- 1. Create a View `HighEarners`
-- Show employee `Name` and `Salary` for employees earning more than 60,000.

CREATE VIEW HighEarners
AS SELECT Name, Salary
FROM Employees
WHERE Salary > 60000;

SELECT * FROM HighEarners;

-- 2. Create a View `EmpDepartmentInfo`
-- Join Employees and Departments tables.
-- Show: `Name`, `Salary`, `DeptName`, `Location`.

CREATE VIEW EmpDepartmentInfo AS
SELECT e.Name, e.Salary, d.DeptName, d.Location
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID;

SELECT * FROM EmpDepartmentInfo;

-- 3. Create a View `ChicagoEmployees`
-- Show employees working in the Chicago department.

CREATE VIEW ChicagoEmployees AS
SELECT e.Name, e.Salary
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE d.Location = 'Chicago';

SELECT * FROM ChicagoEmployees;

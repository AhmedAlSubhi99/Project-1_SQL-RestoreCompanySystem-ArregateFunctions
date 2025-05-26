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

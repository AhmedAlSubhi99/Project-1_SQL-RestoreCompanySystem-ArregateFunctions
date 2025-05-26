--1. Create a scalar function that takes date and returns Month name of that date.
CREATE FUNCTION GetMonthName(@inputDate DATE)
RETURNS VARCHAR(15)
AS
BEGIN
    RETURN DATENAME(MONTH, @inputDate)
END
--SELECT dbo.GetMonthName('2024-07-18') AS MonthName

--2. Create a multi-statements table-valued function that takes 2 integers and returns the values
--between them.
CREATE FUNCTION GetNumbersBetween(@start INT, @end INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @start
    WHILE @i <= @end
    BEGIN
        INSERT INTO @Numbers VALUES (@i)
        SET @i = @i + 1
    END
    RETURN
END
--SELECT * FROM dbo.GetNumbersBetween(5, 8)

--3. Create inline function that takes Student No and returns Department Name with Student full
--name.
CREATE FUNCTION GetStudentDeptInfo(@St_Id INT)
RETURNS TABLE
AS
RETURN (
    SELECT
        ISNULL(s.St_Fname, '') + ' ' + ISNULL(s.St_Lname, '') AS FullName,
        d.Dept_Name
    FROM Student s
    JOIN Department d ON s.Dept_Id = d.Dept_Id
    WHERE s.St_Id = @St_Id
)
--SELECT * FROM dbo.GetStudentDeptInfo(1)

--4. Create a scalar function that takes Student ID and returns a message to user
CREATE FUNCTION CheckStudentNames(@St_Id INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @message VARCHAR(100)
    DECLARE @fname VARCHAR(50), @lname VARCHAR(50)
    SELECT @fname = St_Fname, @lname = St_Lname
    FROM Student
    WHERE St_Id = @St_Id
    IF @fname IS NULL AND @lname IS NULL
        SET @message = 'First name & last name are null'
    ELSE IF @fname IS NULL
        SET @message = 'First name is null'
    ELSE IF @lname IS NULL
        SET @message = 'Last name is null'
    ELSE
        SET @message = 'First name & last name are not null'
    RETURN @message
END
--SELECT dbo.CheckStudentNames(1) AS NameStatus

--5. Create inline function that takes integer which represents manager ID and displays department
--name, Manager Name and hiring date
CREATE FUNCTION GetManagerDeptInfo(@ManagerId INT)
RETURNS TABLE
AS
RETURN (
    SELECT
        d.Dept_Name,
        i.Ins_Name AS ManagerName,
        d.Manager_hiredate AS HiringDate
    FROM Department d
    JOIN Instructor i ON d.Dept_Manager = i.Ins_Id
    WHERE d.Dept_Manager = @ManagerId
)
--SELECT * FROM dbo.GetManagerDeptInfo(1)

--6. Create multi-statements table-valued function that takes a string
CREATE FUNCTION GetStudentNameInfo(@nameType VARCHAR(20))
RETURNS @result TABLE (NameInfo VARCHAR(100))
AS
BEGIN
    IF @nameType = 'first name'
        INSERT INTO @result
        SELECT ISNULL(St_Fname, '') FROM Student
    ELSE IF @nameType = 'last name'
        INSERT INTO @result
        SELECT ISNULL(St_Lname, '') FROM Student
    ELSE IF @nameType = 'full name'
        INSERT INTO @result
        SELECT ISNULL(St_Fname, '') + ' ' + ISNULL(St_Lname, '') FROM Student
    RETURN
END
--SELECT * FROM dbo.GetStudentNameInfo('full name')

--Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000
--and increases it by 20% if Salary >=3000. Use company DB
DECLARE @E_Id INT, @Salary DECIMAL(10,2)
DECLARE EmpCursor CURSOR FOR
SELECT SSN, Salary FROM Employee
OPEN EmpCursor
FETCH NEXT FROM EmpCursor INTO @E_Id, @Salary
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Salary < 3000
        UPDATE Employee SET Salary = Salary * 1.10 WHERE SSN = @E_Id
    ELSE
        UPDATE Employee SET Salary = Salary * 1.20 WHERE SSN = @E_Id
    FETCH NEXT FROM EmpCursor INTO @E_Id, @Salary
END
CLOSE EmpCursor
DEALLOCATE EmpCursor
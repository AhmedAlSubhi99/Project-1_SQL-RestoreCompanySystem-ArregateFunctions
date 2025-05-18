
Use Company_SD;

SELECT * FROM EMPLOYEE;

SELECT Fname, Lname, Salary, Dno FROM EMPLOYEE;

SELECT Pname, Plocation, Dnum FROM PROJECT;

SELECT 
  Fname + ' ' + Lname AS Full_Name,
  Salary * 12 * 0.10 AS [ANNUAL Salary]
FROM EMPLOYEE;

SELECT SSN, Fname + ' ' + Lname AS Full_Name
FROM EMPLOYEE
WHERE Salary > 1000;

SELECT SSN, Fname + ' ' + Lname AS Full_Name
FROM EMPLOYEE
WHERE Salary * 12 > 10000;

SELECT Fname + ' ' + Lname AS Full_Name, Salary
FROM EMPLOYEE
WHERE Sex = 'F';

SELECT Dnum, Dname
FROM Departments
WHERE MGRSSN = 968574;

SELECT Pnumber, Pname, Plocation
FROM PROJECT
WHERE Dnum = 10;


-- Insert your record only if it doesn't exist
IF NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE SSN = 102672)
BEGIN
    INSERT INTO EMPLOYEE (Fname, Lname, SSN, Bdate, Address, Sex, Dno, Superssn, Salary)
    VALUES ('Ahmed', 'ALsubhi', 102672, '1999-07-05', 'Muscat', 'M', 30, 112233, 3000);
END
ELSE
BEGIN
    UPDATE EMPLOYEE
    SET 
      Fname = 'Ahmed',
      Lname = 'ALsubhi',
      Dno = 30,
      Sex = 'M',
      Address = 'Muscat',
      Bdate = '1999-07-05',
      Superssn = 112233,
      Salary = 3000
    WHERE SSN = 102672;
END

-- Insert your friend's record only if it doesn't exist
IF NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE SSN = 102660)
BEGIN
    INSERT INTO EMPLOYEE (Fname, Lname, SSN, Bdate, Address, Sex, Dno, Superssn, Salary)
    VALUES ('Alwaleed', 'AlHinai', 102660, '1999-10-15', 'Muscat', 'M', 30, NULL, NULL);
END
ELSE
BEGIN
    UPDATE EMPLOYEE
    SET 
      Fname = 'Alwaleed',
      Lname = 'AlHinai',
      Dno = 30,
      Sex = 'M',
      Address = 'Muscat',
      Bdate = '1999-10-15',
      Superssn = NULL,
      Salary = NULL
    WHERE SSN = 102660;
END


UPDATE EMPLOYEE
SET Salary = Salary * 1.20
WHERE SSN = 102672;








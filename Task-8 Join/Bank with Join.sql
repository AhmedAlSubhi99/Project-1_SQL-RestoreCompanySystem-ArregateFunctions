--1. Display branch ID, name, and the name of the employee who manages it. 
SELECT B.B_ID, B.B_Address AS Branch_Name, E.E_Name AS Manager
FROM Branch B
JOIN Employee E ON B.B_ID = E.B_ID
WHERE E.Position = 'Branch Manager';

--2. Display branch names and the accounts opened under each. 
SELECT B.B_Address AS Branch_Name, A.AccNUM, A.A_Type
FROM Branch B
JOIN Employee E ON B.B_ID = E.B_ID
JOIN Assist ASST ON E.E_ID = ASST.E_ID
JOIN Account A ON ASST.C_ID = A.C_ID;

--3. Display full customer details along with their loans. 
SELECT C.*, L.L_Type, L.Amount, L.Issue_Date
FROM Customer C
JOIN Loan L ON C.C_ID = L.C_ID;

--4. Display loan records where the loan office is in 'Alexandria' or 'Giza'. 
SELECT L.*, B.B_Address
FROM Loan L
JOIN Customer C ON L.C_ID = C.C_ID
JOIN Assist A ON C.C_ID = A.C_ID
JOIN Employee E ON A.E_ID = E.E_ID
JOIN Branch B ON E.B_ID = B.B_ID
WHERE B.B_Address LIKE '%Muscat%' OR B.B_Address LIKE '%Sohar%';

--5. Display account data where the type starts with "S" (e.g., "Savings"). 
SELECT * FROM Account
WHERE A_Type LIKE 'S%';

--6. List customers with accounts having balances between 20,000 and 50,000. 
SELECT DISTINCT C.*
FROM Customer C
JOIN Account A ON C.C_ID = A.C_ID
WHERE A.Balance BETWEEN 20000 AND 50000;

--7. Retrieve customer names who borrowed more than 1000 LE from 'Sohar'. 
SELECT C.C_Name, L.Amount
FROM Loan L
JOIN Customer C ON L.C_ID = C.C_ID
INNER JOIN Handle H ON L.L_ID = H.L_ID
INNER JOIN Employee E ON H.E_ID = E.E_ID
JOIN Branch B ON E.B_ID = B.B_ID
WHERE L.Amount > 1000 AND B.B_Address = 'Sohar';

--8. Find all customers assisted by employee "Amira Khaled". 
SELECT C.*
FROM Customer C
JOIN Assist A ON C.C_ID = A.C_ID
JOIN Employee E ON A.E_ID = E.E_ID
WHERE E.E_Name = 'Amira Khaled';

--9. Display each customer’s name and the accounts they hold, sorted by account type.
SELECT C.C_Name, A.AccNUM, A.A_Type
FROM Customer C
JOIN Account A ON C.C_ID = A.C_ID
ORDER BY A.A_Type;

--10.  For each loan issued in Cairo, show loan ID, customer name, employee handling it, and branch name. 
SELECT L.L_ID, C.C_Name, E.E_Name AS Handled_By, B.B_Address AS Branch
FROM Loan L
INNER JOIN Customer C ON L.C_ID = C.C_ID
INNER JOIN Handle H ON L.L_ID = H.L_ID
JOIN Employee E ON H.E_ID = E.E_ID
JOIN Branch B ON E.B_ID = B.B_ID
WHERE B.B_Address LIKE '%Muscat%';

--11.  Display all employees who manage any branch. 
SELECT * FROM Employee
WHERE Position = 'Branch Manager';

--12.  Display all customers and their transactions, even if some customers have no transactions yet.
SELECT C.C_Name, T.T_Type, T.Amount, T.T_Date
FROM Customer C
LEFT JOIN Account A ON C.C_ID = A.C_ID
LEFT JOIN Transaction0 T ON A.AccNUM = T.AccNUM;

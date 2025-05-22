-- 21. Count total number of customers in Customers table. 
SELECT COUNT(*) AS Total_Customers
FROM Customer;

-- 22. Average account balance from Accounts table. 
SELECT AVG(Balance) AS Average_Balance
FROM Account;

-- 23. Count accounts per branch grouped by Branch_ID. 
SELECT E.B_ID, COUNT(A.AccNUM) AS Total_Accounts
FROM Employee E
JOIN Assist ASST ON E.E_ID = ASST.E_ID
JOIN Account A ON ASST.C_ID = A.C_ID
GROUP BY E.B_ID;


-- 24. Sum loan amounts per customer from Loans grouped by Customer_ID. 
SELECT C_ID, SUM(Amount) AS Total_Loan_Amount
FROM Loan
GROUP BY C_ID;

-- 25.  List customers with total loan > 200000 grouped by Customer_ID. 
SELECT C.C_ID, C.C_Name, SUM(L.Amount) AS Total_Loan_Amount
FROM Customer C
JOIN Loan L ON C.C_ID = L.C_ID
GROUP BY C.C_ID, C.C_Name
HAVING SUM(L.Amount) > 200000;

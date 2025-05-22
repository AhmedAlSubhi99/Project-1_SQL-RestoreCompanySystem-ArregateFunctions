-- 26. Count total books in Book table
SELECT COUNT(*) AS Total_Books
FROM Book;

-- 27. Average book price from Books table. 
SELECT AVG(Price) AS Average_Book_Price
FROM Book;

-- 28. Count books per library grouped by Library_ID. 
SELECT L_ID AS Library_ID, COUNT(*) AS Book_Count
FROM Book
GROUP BY L_ID;

-- 29. Count books borrowed per member from Borrows table grouped by Member_ID. 
SELECT M_ID AS Member_ID, COUNT(*) AS Books_Borrowed
FROM Loan_Link
GROUP BY M_ID;

-- 30. List members who borrowed more than 3 books grouped by Member_ID. 
SELECT M_ID AS Member_ID, COUNT(*) AS Books_Borrowed
FROM Loan_Link
GROUP BY M_ID
HAVING COUNT(*) > 3;

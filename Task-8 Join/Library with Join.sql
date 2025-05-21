-- 1. Display library ID, name, and the name of the manager. 
SELECT l.L_ID, l.L_Name, s.Full_Name AS Manager_Name
FROM Librarys l INNER JOIN Staff s
ON l.L_ID = s.L_ID
WHERE s.Position = 'Manager';

-- 2. Display library names and the books available in each one. 
SELECT l.L_Name, b.Title AS Book_Title
FROM Librarys l INNER JOIN Book b 
ON l.L_ID = b.L_ID
ORDER BY l.L_Name;

-- 3. Display all member data along with their loan history. 
SELECT m.*, b.Title AS Book_Title, ll.Loan_Date, ll.Due_Date, ll.Return_Date, ll.L_Status
FROM Members m LEFT JOIN Loan_Link ll
ON m.M_ID = ll.M_ID
LEFT JOIN Book b 
ON ll.B_ID = b.B_ID;

-- 4. Display all books located in 'Muscat' or 'Nizwa'. 
SELECT b.*
FROM Book b
INNER JOIN Librarys l 
ON b.L_ID = l.L_ID
WHERE l.L_Location IN ('Muscat', 'Nizwa');

-- 5. Display all books whose titles start with 'T'. 
SELECT *
FROM Book
WHERE Title LIKE 'T%';

-- 6. List members who borrowed books priced between 10 and 30 LE. 
SELECT m.Full_Name
FROM Members m
LEFT OUTER JOIN Loan_Link ll ON m.M_ID = ll.M_ID
INNER JOIN Book b ON ll.B_ID = b.B_ID
WHERE b.Price BETWEEN 10 AND 30;

-- 7. Retrieve members who borrowed and returned books titled 'The Alchemist'. 
SELECT m.Full_Name
FROM Members m
INNER JOIN Loan_Link ll ON m.M_ID = ll.M_ID
INNER JOIN Book b ON ll.B_ID = b.B_ID
WHERE b.Title = 'Intro to SQL' AND ll.L_Status = 'Returned';

-- 8. Find all members assisted by librarian "Sarah Fathy". 
SELECT DISTINCT m.Full_Name
FROM Members m
INNER JOIN Loan_Link ll ON m.M_ID = ll.M_ID
FULL OUTER JOIN Staff s ON ll.B_ID IN (SELECT B_ID FROM Book WHERE L_ID = s.L_ID)
WHERE s.Full_Name = 'Issaq';

-- 9. Display each member’s name and the books they borrowed, ordered by book title. 
SELECT m.Full_Name AS Member_Name, b.Title AS Book_Title
FROM Members m
INNER JOIN Loan_Link ll ON m.M_ID = ll.M_ID
LEFT OUTER JOIN Book b ON ll.B_ID = b.B_ID
ORDER BY b.Title;

-- 10.  For each book located in 'Bahla Library', show title, library name, manager, and shelf info.
SELECT b.Title, l.L_Name, s.Full_Name AS Manager_Name, b.Shelf_Location
FROM Book b
LEFT OUTER JOIN Librarys l ON b.L_ID = l.L_ID
RIGHT OUTER JOIN Staff s ON l.L_ID = s.L_ID AND s.Position = 'Manager'
WHERE l.L_Name = 'Bahla Library';

-- 11.  Display all staff members who manage libraries. 
SELECT s.*
FROM Staff s
WHERE s.Position = 'Manager';

-- 12.  Display all members and their reviews, even if some didn’t submit any review yet.
SELECT m.Full_Name AS Member_Name, b.Title AS Book_Title, r.Comments, r.Rating, r.Review_Date
FROM Members m LEFT JOIN Review_Link r 
ON m.M_ID = r.M_ID
LEFT JOIN Book b 
ON r.B_ID = b.B_ID;
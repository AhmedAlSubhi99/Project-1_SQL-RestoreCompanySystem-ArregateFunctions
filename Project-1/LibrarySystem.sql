-- I can't drop a database that's currently in use.So we use master.
USE master;
GO
-- This closes all connections and drops the database cleanly
ALTER DATABASE LibrarySystem SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE LibrarySystem;
GO
-- Create a fresh BANK 
CREATE DATABASE LibrarySystem;
GO
-- Switch to the new BANK
USE LibrarySystem;
GO

-- =====================
-- Table: Library
-- =====================
CREATE TABLE Librarys 
(
    L_ID INT PRIMARY KEY IDENTITY, -- Auto-incremented on library ID
    L_Name VARCHAR(100) NOT NULL,
    L_Location VARCHAR(100), 
    Establish_Year INT,
    Contact_Number VARCHAR(15)
);

-- =====================
-- Table: Staff
-- =====================
CREATE TABLE Staff
(
    S_ID INT PRIMARY KEY IDENTITY, -- Auto-incremented on staff ID
    Full_Name VARCHAR(100) NOT NULL, 
    Position VARCHAR(50),
    Establish_Year INT, 
    Contact_Number VARCHAR(15),
	L_ID INT,
    FOREIGN KEY (L_ID) REFERENCES Librarys(L_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- =====================
-- Table: Members
-- =====================
CREATE TABLE Members 
(
    M_ID INT PRIMARY KEY IDENTITY, -- Auto-incremented on Member ID
    Full_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15), 
    Email VARCHAR(100),
    Membership_Start_Date DATE
);

-- =====================
-- Table: Book
-- =====================
CREATE TABLE Book
(
    B_ID INT PRIMARY KEY IDENTITY, -- Auto-incremented on book ID
    ISBN VARCHAR(20) NOT NULL,
    Shelf_Location VARCHAR(50),
    IsAvailable BIT DEFAULT 1, -- TRUE (1) means the book is currently available
    Title VARCHAR(200) NOT NULL,
    Genre VARCHAR(50) CHECK (Genre IN ('Fiction', 'Non-fiction', 'Reference', 'Children')),
    Price DECIMAL(10,2) CHECK (Price > 0),
	L_ID INT,
    FOREIGN KEY (L_ID) REFERENCES Librarys(L_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- =====================
-- Table: Loan_Link
-- =====================
CREATE TABLE Loan_Link
(
    B_ID INT, 
    M_ID INT, 
    Loan_Date DATE NOT NULL, 
    Due_Date DATE, 
    Return_Date DATE, 
    L_Status VARCHAR(20) CHECK (L_Status IN ('Issued', 'Returned', 'Overdue')) DEFAULT 'Issued',
    PRIMARY KEY (B_ID, M_ID, Loan_Date), 
    FOREIGN KEY (B_ID) REFERENCES Book(B_ID) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (M_ID) REFERENCES Members(M_ID) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- =====================
-- Table: Review_Link
-- =====================
CREATE TABLE Review_Link 
(
    B_ID INT,
    M_ID INT, 
    Review_Date DATE, 
    Comments VARCHAR(255) DEFAULT 'No comments', 
    Rating INT CHECK (Rating BETWEEN 1 AND 5), 
    PRIMARY KEY (B_ID, M_ID, Review_Date),
    FOREIGN KEY (B_ID) REFERENCES Book(B_ID) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (M_ID) REFERENCES Members(M_ID) ON DELETE CASCADE ON UPDATE CASCADE 
);

-- ===========================
-- Table: Method_Payment
-- ===========================
CREATE TABLE Method_Payment
(
    Method_ID INT PRIMARY KEY IDENTITY, -- Auto-increment method ID
    Method VARCHAR(20) CHECK (Method IN ('Cash', 'Card')) -- Check Cash or Card are only accepted
);

-- =====================
-- Table: Payments
-- =====================
CREATE TABLE Payments 
(
    P_ID INT PRIMARY KEY IDENTITY, -- Auto-increment payment ID
    Pay_Date DATE NOT NULL, 
    Amount DECIMAL(10,2) CHECK (Amount > 0), --Check Payment must be positive
    Transaction_Details VARCHAR(255),
    B_ID INT NULL,
    M_ID INT NULL,
    Loan_Date DATE NULL,
	Method_ID INT,
	FOREIGN KEY (Method_ID) REFERENCES Method_Payment(Method_ID),
    FOREIGN KEY (B_ID, M_ID, Loan_Date) REFERENCES Loan_Link(B_ID, M_ID, Loan_Date) ON DELETE SET NULL ON UPDATE CASCADE -- Sets to NULL if review is deleted
);

-- Insert sample libraries
INSERT INTO Librarys (L_Name, L_Location, Establish_Year, Contact_Number)
VALUES 
('Muscat Library', 'Muscat', 1995, '968-1000'),
('Bahla Library', 'Bahla', 2005, '968-2000'), 
('Nizwa Library', 'Nizwa', 2010, '968-3000');

-- Insert staff members
INSERT INTO Staff (Full_Name, Position, Establish_Year, Contact_Number, L_ID)
VALUES 
('Samir', 'Librarian', 2000, '968-1010', 1),
('Jamal', 'Technician', 2010, '968-1011', 1),
('Issaq', 'Manager', 2015, '968-1012', 2),
('Basel', 'Assistant', 2020, '968-1013', 3);

-- Insert library members
INSERT INTO Members (Full_Name, Phone, Email, Membership_Start_Date)
VALUES 
('Ali', '968-2020', 'Ali@example.com', '2023-01-10'),
('Ahmed', '968-2021', 'Ahmed@example.com', '2022-12-05'),
('Salim', '968-2022', 'Salim@example.com', '2023-02-01'),
('Noah', '968-2023', 'noah@example.com', '2023-03-15'),
('Mohammed', '968-2024', 'Mohammed@example.com', '2023-04-20'),
('Alwaleed', '968-2025', 'Alwaleed@example.com', '2023-05-25');

-- Insert books available
INSERT INTO Book (ISBN, Shelf_Location, Title, Genre, Price, L_ID)
VALUES 
('968-0001', 'A1', 'Intro to SQL', 'Reference', 45.00, 1),
('968-0002', 'A2', 'The Fictional World', 'Fiction', 30.00, 1),
('968-0003', 'A3', 'Child Play', 'Children', 20.00, 1),
('968-0004', 'B1', 'Science Matters', 'Non-fiction', 50.00, 2),
('968-0005', 'B2', 'My First Book', 'Children', 18.00, 2),
('968-0006', 'B3', 'Advanced SQL', 'Reference', 60.00, 2),
('968-0007', 'C1', 'Magic Tales', 'Fiction', 25.00, 3),
('968-0008', 'C2', 'Nonfiction Now', 'Non-fiction', 40.00, 3),
('968-0009', 'C3', 'History of Fiction', 'Fiction', 35.00, 3),
('968-0010', 'C4', 'Reference Guide', 'Reference', 55.00, 3);

-- Insert book loans between members and books
INSERT INTO Loan_Link (B_ID, M_ID, Loan_Date, Due_Date, Return_Date, L_Status)
VALUES 
(1, 1, '2024-04-01', '2024-04-15', '2024-04-10', 'Returned'),
(2, 1, '2024-05-01', '2024-05-15', NULL, 'Issued'),
(3, 2, '2024-03-01', '2024-03-15', NULL, 'Overdue'),
(4, 2, '2024-05-02', '2024-05-16', NULL, 'Issued'),
(5, 3, '2024-04-10', '2024-04-24', '2024-04-22', 'Returned'),
(6, 4, '2024-03-20', '2024-04-03', NULL, 'Overdue'),
(7, 5, '2024-05-05', '2024-05-19', NULL, 'Issued'),
(8, 6, '2024-05-10', '2024-05-24', NULL, 'Issued'),
(9, 3, '2024-04-05', '2024-04-19', '2024-04-18', 'Returned'),
(10, 1, '2024-05-15', '2024-05-29', NULL, 'Issued');

-- Insert accepted payment methods
INSERT INTO Method_Payment (Method)
VALUES ('Cash'), ('Card');

-- Insert fine payments linked to books and members
INSERT INTO Payments (Pay_Date, Amount, Method_ID, Transaction_Details, B_ID, M_ID, Loan_Date)
VALUES 
('2024-04-20', 10.00, 1, 'Late fee for Book 3', 3, 2, '2024-03-01'),
('2024-04-25', 5.00, 2, 'Late fee for Book 6', 6, 4, '2024-03-20'),
('2024-04-30', 7.50, 1, 'Late fee for Book 9', 9, 3, '2024-04-05'),
('2024-05-01', 6.00, 2, 'Late fee for Book 1', 1, 1, '2024-04-01');

-- Insert reviews 
INSERT INTO Review_Link (B_ID, M_ID, Review_Date, Comments, Rating)
VALUES 
(1, 1, '2024-04-10', 'Very helpful', 5),
(2, 1, '2024-05-10', 'Interesting read', 4),
(3, 2, '2024-03-15', 'Great for kids', 5),
(4, 2, '2024-05-12', 'Good science content', 4),
(5, 3, '2024-04-25', 'Fun to read', 4),
(6, 4, '2024-04-03', 'Bit advanced', 3);

-- Mark Book ID 2 as returned
UPDATE Book
SET IsAvailable = 1
WHERE B_ID = 2;

UPDATE Loan_Link
SET Return_Date = GETDATE(), L_Status = 'Returned'
WHERE B_ID = 2 AND M_ID = 1 AND Loan_Date = '2024-05-01';

UPDATE Loan_Link
SET Return_Date = GETDATE(), L_Status = 'Returned'
WHERE B_ID = 3 AND M_ID = 2 AND Loan_Date = '2024-03-01';


-- Set loan status to Overdue for a book not returned by due date
UPDATE Loan_Link
SET L_Status = 'Overdue'
WHERE B_ID = 4 AND M_ID = 2 AND Return_Date IS NULL AND Due_Date < GETDATE();

-- Delete a specific review
DELETE FROM Review_Link
WHERE B_ID = 1 AND M_ID = 1 AND Review_Date = '2024-04-10';

-- Delete a specific payment
DELETE FROM Payments
WHERE P_ID = 1;

-- View all Libraries
SELECT * FROM Librarys;

-- View all Staff
SELECT * FROM Staff;

-- View all Members
SELECT * FROM Members;

-- View all Books
SELECT * FROM Book;

-- View all Loans
SELECT * FROM Loan_Link;

-- View all Reviews
SELECT * FROM Review_Link;

-- View all Payment Methods
SELECT * FROM Method_Payment;

-- View all Payments
SELECT * FROM Payments;


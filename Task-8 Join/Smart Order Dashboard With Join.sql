
-- Customers Table
CREATE TABLE Customers 
(
    CustomerID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Phone VARCHAR(20),
    ReferralID INT NULL,
    FOREIGN KEY (ReferralID) REFERENCES Customers(CustomerID)
)
;
-- Restaurants Table
CREATE TABLE Restaurants 
(
    RestaurantID INT PRIMARY KEY,
    Name NVARCHAR(100),
    City NVARCHAR(50)
)
;
-- Orders Table
CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
)
;
-- OrderItems Table
CREATE TABLE OrderItems 
(
    OrderItemID INT PRIMARY KEY,
    OrderID INT,
    ItemName NVARCHAR(100),
    Quantity INT,
    Price DECIMAL(6,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
)
;
-- Menu Table
CREATE TABLE Menu 
(
    MenuID INT PRIMARY KEY,
    RestaurantID INT,
    ItemName NVARCHAR(100),
    Price DECIMAL(6,2),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
)
;
-- Insert Sample Data
-- Customers
INSERT INTO Customers VALUES 
(1, 'Ahmed AlHarthy', '91234567', NULL),
(2, 'Fatma AlBalushi', '92345678', 1),
(3, 'Salim AlZadjali', '93456789', NULL),
(4, 'Aisha AlHinai', '94567890', 2)
;
-- Restaurants
INSERT INTO Restaurants VALUES 
(1, 'Shawarma King', 'Muscat'),
(2, 'Pizza World', 'Sohar'),
(3, 'Burger Spot', 'Nizwa')
;
-- Menu
INSERT INTO Menu VALUES
(1, 1, 'Shawarma Chicken', 1.500),
(2, 1, 'Shawarma Beef', 1.800),
(3, 2, 'Pepperoni Pizza', 3.000),
(4, 2, 'Cheese Pizza', 2.500),
(5, 3, 'Classic Burger', 2.000),
(6, 3, 'Zinger Burger', 2.200)
;
-- Orders
INSERT INTO Orders VALUES
(101, 1, 1, '2024-05-01', 'Delivered'),
(102, 2, 2, '2024-05-02', 'Preparing'),
(103, 3, 1, '2024-05-03', 'Cancelled'),
(104, 4, 3, '2024-05-04', 'Delivered')
;
-- OrderItems
INSERT INTO OrderItems VALUES
(1, 101, 'Shawarma Chicken', 2, 1.500),
(2, 101, 'Shawarma Beef', 1, 1.800),
(3, 102, 'Pepperoni Pizza', 1, 3.000),
(4, 104, 'Classic Burger', 2, 2.000),
(5, 104, 'Zinger Burger', 1, 2.200)
;

-- Widget 1: Active Orders Summary
SELECT o.OrderID, c.FullName AS CustomerName, r.Name AS RestaurantName, o.OrderDate
FROM Orders o INNER JOIN Customers c 
ON o.CustomerID = c.CustomerID
INNER JOIN Restaurants r
ON o.RestaurantID = r.RestaurantID
WHERE o.Status = 'Preparing'
;

-- Widget 2: Restaurant Menu Coverage
SELECT r.Name AS RestaurantName, m.ItemName,
    CASE 
        WHEN oi.OrderItemID IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS HasBeenOrdered
FROM Menu m INNER JOIN Restaurants r
ON m.RestaurantID = r.RestaurantID
LEFT JOIN OrderItems oi
ON m.ItemName = oi.ItemName AND m.RestaurantID = (SELECT RestaurantID FROM Orders WHERE OrderID = oi.OrderID )
ORDER BY r.Name, m.ItemName
;

-- Widget 3: Customers Without Orders
SELECT c.CustomerID, c.FullName, c.Phone,
    CASE 
        WHEN o.OrderID IS NULL THEN 'No Orders'
        ELSE 'Has Orders'
    END AS OrderStatus
FROM Customers c LEFT JOIN  Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- Widget 4: Full Engagement Report
SELECT c.CustomerID, c.FullName AS CustomerName, o.OrderID, o.OrderDate, o.Status,
    CASE 
        WHEN c.CustomerID IS NULL THEN 'Orphaned Order'
        WHEN o.OrderID IS NULL THEN 'Customer Never Ordered'
        ELSE 'Normal Order'
    END AS RecordType
FROM Customers c FULL OUTER JOIN Orders o 
ON c.CustomerID = o.CustomerID;

-- Widget 5: Referral Tree 
SELECT c.CustomerID, c.FullName AS CustomerName, r.FullName AS ReferredBy
FROM Customers c
LEFT JOIN Customers r
ON c.ReferralID = r.CustomerID;

-- Widget 6: Menu Performance Tracker 
SELECT r.Name AS RestaurantName, m.ItemName, COUNT(oi.OrderItemID) AS TimesOrdered, SUM(oi.Quantity) AS TotalQuantitySold
FROM Menu m INNER JOIN Restaurants r 
ON m.RestaurantID = r.RestaurantID
LEFT JOIN OrderItems oi 
ON m.ItemName = oi.ItemName AND m.RestaurantID = (SELECT RestaurantID FROM Orders WHERE OrderID = oi.OrderID )
GROUP BY r.Name, m.ItemName
ORDER BY r.Name, TimesOrdered DESC;

-- Widget 7: Unused Customers and Items
SELECT 'Unused Customer' AS Type, c.CustomerID AS ID, c.FullName AS Name, NULL AS RestaurantName, NULL AS ItemName
FROM Customers c
LEFT JOIN Orders o 
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL   
UNION ALL
SELECT 'Unused Item' AS Type, NULL AS ID, NULL AS Name,r.Name AS RestaurantName, m.ItemName
FROM Menu m
INNER JOIN Restaurants r
ON m.RestaurantID = r.RestaurantID
LEFT JOIN OrderItems oi 
ON m.ItemName = oi.ItemName AND m.RestaurantID = (SELECT RestaurantID FROM Orders WHERE OrderID = oi.OrderID)
WHERE oi.OrderItemID IS NULL;

-- Widget 8: Orders with Missing Menu Price Match
SELECT o.OrderID, oi.ItemName, r.Name AS RestaurantName, o.OrderDate
FROM Orders o JOIN OrderItems oi 
ON o.OrderID = oi.OrderID
JOIN Restaurants r 
ON o.RestaurantID = r.RestaurantID
LEFT JOIN Menu m 
ON o.RestaurantID = m.RestaurantID AND oi.ItemName = m.ItemName
WHERE m.MenuID IS NULL;

-- Widget 9: Repeat Customers Report
SELECT c.CustomerID, c.FullName AS CustomerName, COUNT(o.OrderID) AS TotalOrders, MIN(o.OrderDate) AS FirstOrderDate, MAX(o.OrderDate) AS LastOrderDate
FROM Customers c JOIN Orders o 
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FullName
HAVING COUNT(o.OrderID) > 1;

-- Widget 10: Item Referral Revenue
SELECT r.CustomerID AS ReferrerID, r.FullName AS ReferrerName, c.CustomerID AS ReferredCustomerID, c.FullName AS ReferredCustomerName, SUM(oi.Price * oi.Quantity) AS TotalAmountSpent
FROM Customers c LEFT JOIN Customers r 
ON c.ReferralID = r.CustomerID
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN OrderItems oi 
ON o.OrderID = oi.OrderID
GROUP BY r.CustomerID, r.FullName, c.CustomerID, c.FullName
ORDER BY TotalAmountSpent DESC;

-- Widget 11: Update Prices for Bestsellers
UPDATE M
SET M.Price = M.Price * 1.10
FROM Menu M
JOIN (
    SELECT OI.ItemName
    FROM OrderItems OI
    GROUP BY OI.ItemName
    HAVING COUNT(*) > 3
) BestSellers ON M.ItemName = BestSellers.ItemName;

-- Widget 12: Delete Inactive Customers
DELETE FROM Customers
WHERE CustomerID IN (
    SELECT C.CustomerID
    FROM Customers C
    LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
    WHERE O.OrderID IS NULL AND C.ReferralID IS NULL
);

-- Widget 13: Adjust Prices for Inactive Restaurants
UPDATE M
SET M.Price = M.Price * 0.85
FROM Menu M
JOIN Restaurants R ON M.RestaurantID = R.RestaurantID
LEFT JOIN Orders O ON R.RestaurantID = O.RestaurantID
WHERE O.OrderID IS NULL;

-- Widget 14: Register VIP Customers
-- Not provide it

-- Widget 15: Order Dispatch Overview
SELECT c.FullName AS CustomerName, r.Name AS RestaurantName, oi.ItemName, oi.Quantity, oi.Price, (oi.Quantity * oi.Price) AS ItemTotal, o.Status, o.OrderDate
FROM  Orders o
INNER JOIN Customers c 
ON o.CustomerID = c.CustomerID
INNER JOIN Restaurants r 
ON o.RestaurantID = r.RestaurantID
INNER JOIN OrderItems oi 
ON o.OrderID = oi.OrderID
ORDER BY o.OrderDate DESC, o.OrderID, oi.ItemName


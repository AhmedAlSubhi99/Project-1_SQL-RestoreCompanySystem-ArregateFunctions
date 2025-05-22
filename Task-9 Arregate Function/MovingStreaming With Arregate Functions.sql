
Create Table Users
(
UserID INT PRIMARY KEY,
FullName VARCHAR(100),
Email VARCHAR(100),
JoinDate DATE,
SubscriptionType VARCHAR(20)  -- Free, Basic, Premium
);

Create Table Movies
(
MovieID INT PRIMARY KEY,
Title VARCHAR(100),
Genre VARCHAR(50),
ReleaseYear INT,
DurationMinutes INT
);

Create Table WatchHistory
(
WatchID INT PRIMARY KEY,
UserID INT FOREIGN KEY REFERENCES Users(UserID),
MovieID INT FOREIGN KEY REFERENCES Movies(MovieID),
WatchDate DATE,
WatchDuration INT -- in minutes
);


INSERT INTO Users (UserID, FullName, Email, JoinDate, SubscriptionType) VALUES
(1, 'Ali Al Hinai', 'ali@example.com', '2024-01-01', 'Premium'),
(2, 'Noor Al Busaidi', 'noor@example.com', '2024-02-15', 'Basic'),
(3, 'Hassan Al Rawahi', 'hassan@example.com', '2024-03-10', 'Free'),
(4, 'Muna Al Lawati', 'muna@example.com', '2024-04-05', 'Premium'),
(5, 'Salim Al Zadjali', 'salim@example.com', '2024-05-01', 'Basic');

INSERT INTO Movies (MovieID, Title, Genre, ReleaseYear, DurationMinutes) VALUES
(1, 'The Silent Ocean', 'Sci-Fi', 2023, 120),
(2, 'Omani Roots', 'Documentary', 2022, 90),
(3, 'Fast Track', 'Action', 2024, 130),
(4, 'Code & Coffee', 'Drama', 2023, 110),
(5, 'The Last Byte', 'Thriller', 2023, 105);

INSERT INTO WatchHistory (WatchID, UserID, MovieID, WatchDate, WatchDuration) VALUES
(1, 1, 1, '2025-05-10', 120),
(2, 2, 2, '2025-05-11', 80),
(3, 3, 3, '2025-05-12', 60),
(4, 4, 1, '2025-05-12', 90),
(5, 5, 5, '2025-05-13', 105);

-- 1. Total Number of Users
SELECT COUNT(*) AS TotalUsers
FROM Users;

-- 2. Average Duration of All Movies 
SELECT AVG(DurationMinutes) AS AvgMovieDuration
FROM Movies;

-- 3. Total Watch Time 
SELECT SUM(WatchDuration) AS TotalWatchTime
FROM WatchHistory;
-- 4. Number of Movies per Genre 
SELECT Genre, COUNT(*) AS MovieCount
FROM Movies
GROUP BY Genre;

-- 5. Earliest User Join Date 
SELECT MIN(JoinDate) AS EarliestJoinDate
FROM Users;

-- 6. Latest Movie Release Year 
SELECT MAX(ReleaseYear) AS LatestReleaseYear
FROM Movies;

-- 7. Number of Users Per Subscription Type 
SELECT SubscriptionType, COUNT(*) AS UserCount
FROM Users
GROUP BY SubscriptionType;

-- 8. Total Watch Time per User 
SELECT u.UserID, u.FullName, SUM(wh.WatchDuration) AS TotalWatchTime
FROM Users u
LEFT JOIN WatchHistory wh ON u.UserID = wh.UserID
GROUP BY u.UserID, u.FullName;

-- 9. Average Watch Duration per Movie 
SELECT m.MovieID, m.Title, AVG(wh.WatchDuration) AS AvgWatchDuration
FROM Movies m
LEFT JOIN WatchHistory wh ON m.MovieID = wh.MovieID
GROUP BY m.MovieID, m.Title;

-- 10. Average Watch Time per Subscription Type 
SELECT u.SubscriptionType, AVG(wh.WatchDuration) AS AvgWatchTime
FROM Users u
LEFT JOIN WatchHistory wh ON u.UserID = wh.UserID
GROUP BY u.SubscriptionType;

-- 11. Number of Views per Movie (Including Zero) 
SELECT m.MovieID, m.Title, COUNT(wh.WatchID) AS ViewCount
FROM Movies m
LEFT JOIN WatchHistory wh ON m.MovieID = wh.MovieID
GROUP BY m.MovieID, m.Title;

-- 12. Average Movie Duration per Release Year 
SELECT ReleaseYear, AVG(DurationMinutes) AS AvgDuration
FROM Movies
GROUP BY ReleaseYear;

-- 13. Most Watched Movie 
SELECT TOP 1 m.MovieID, m.Title, COUNT(wh.WatchID) AS ViewCount
FROM Movies m
LEFT JOIN WatchHistory wh ON m.MovieID = wh.MovieID
GROUP BY m.MovieID, m.Title
ORDER BY ViewCount DESC;

-- 14. Users Who Watched More Than 100 Minutes 
SELECT u.UserID, u.FullName, SUM(wh.WatchDuration) AS TotalWatchTime
FROM Users u
JOIN WatchHistory wh ON u.UserID = wh.UserID
GROUP BY u.UserID, u.FullName
HAVING SUM(wh.WatchDuration) > 100;

-- 15. Total Watch Time per Genre 
SELECT m.Genre, SUM(wh.WatchDuration) AS TotalWatchTime
FROM Movies m
LEFT JOIN WatchHistory wh ON m.MovieID = wh.MovieID
GROUP BY m.Genre;

-- 16. Identify Binge Watchers (Users Who Watched 2 or More Movies in One Day) 
SELECT u.UserID, u.FullName, wh.WatchDate, COUNT(*) AS MoviesWatched
FROM Users u
JOIN WatchHistory wh ON u.UserID = wh.UserID
GROUP BY u.UserID, u.FullName, wh.WatchDate
HAVING COUNT(*) >= 2;

-- 17. Genre Popularity (Total Watch Duration by Genre) 
SELECT m.Genre, SUM(wh.WatchDuration) AS TotalWatchDuration
FROM Movies m
LEFT JOIN WatchHistory wh ON m.MovieID = wh.MovieID
GROUP BY m.Genre
ORDER BY TotalWatchDuration DESC;

-- 18. User Retention Insight: Number of Users Joined Each Month 
SELECT YEAR(JoinDate) AS JoinYear, MONTH(JoinDate) AS JoinMonth, COUNT(*) AS NewUsers
FROM Users
GROUP BY YEAR(JoinDate), MONTH(JoinDate)
ORDER BY JoinYear, JoinMonth;
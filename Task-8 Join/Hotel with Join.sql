-- 1. Display hotel ID, name, and the name of its manager. 
SELECT B.B_ID, B.B_NAME, S.S_NAME AS Manager_Name
FROM BRANCH B
JOIN STAFF S ON B.B_ID = S.B_ID
WHERE S.Job_Title = 'Manager';

-- 2. Display hotel names and the rooms available under them. 
SELECT B.B_NAME AS Hotel_Name, R.R_NUM, R.R_Type
FROM BRANCH B
JOIN ROOMS R ON B.B_ID = R.B_ID;

-- 3. Display guest data along with the bookings they made. 
SELECT C.*, B.*
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID;

-- 4. Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'.
SELECT B.*, BR.B_Location
FROM BOOKING B
JOIN ROOMS R ON B.R_NUM = R.R_NUM
JOIN BRANCH BR ON R.B_ID = BR.B_ID
WHERE BR.B_Location LIKE '%Al Khuwair%' OR BR.B_Location LIKE '%Sohar Corniche%';

-- 5. Display all room records where room type starts with "S" (e.g., "Suite", "Single"). 
SELECT * FROM ROOMS
WHERE R_Type LIKE 'S%';

-- 6. List guests who booked rooms priced between 1500 and 2500 LE. 
SELECT DISTINCT C.*
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID
JOIN ROOMS R ON B.R_NUM = R.R_NUM
WHERE R.NIGHTLY_RATY BETWEEN 1500 AND 2500;

-- 7. Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown".
SELECT C.C_Name
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID
JOIN ROOMS R ON B.R_NUM = R.R_NUM
JOIN BRANCH BR ON R.B_ID = BR.B_ID
WHERE B.inAvailability = 'Y' AND BR.B_NAME = 'Sohar';

-- 8. Find guests whose bookings were handled by staff member "Mona Ali". 
SELECT DISTINCT C.*
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID
JOIN STAFF S ON B.S_ID = S.S_ID
WHERE S.S_NAME = 'Mona Ali';

-- 9. Display each guest’s name and the rooms they booked, ordered by room type. 
SELECT C.C_Name, R.R_Type
FROM CUSTOMER C
JOIN BOOKING B ON C.C_ID = B.C_ID
JOIN ROOMS R ON B.R_NUM = R.R_NUM
ORDER BY R.R_Type;

-- 10.  For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info. 
SELECT B.B_ID, B.B_NAME, S.S_NAME AS Manager_Name, S.Salary
FROM BRANCH B
JOIN STAFF S ON B.B_ID = S.B_ID
WHERE B.B_Location LIKE '%Cairo%' AND S.Job_Title = 'Manager';

-- 11.  Display all staff members who hold 'Manager' positions. 
SELECT * FROM STAFF
WHERE Job_Title = 'Manager';

-- 12.  Display all guests and their reviews, even if some guests haven't submitted any reviews.
SELECT C.C_Name, R.Comments, R.Rating
FROM CUSTOMER C
LEFT JOIN REVIEW R ON C.C_ID = R.C_ID;

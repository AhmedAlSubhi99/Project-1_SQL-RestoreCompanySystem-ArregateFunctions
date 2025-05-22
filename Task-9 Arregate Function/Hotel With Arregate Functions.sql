-- 16. Count total rooms across all hotels from Rooms table.
SELECT COUNT(*) AS Total_Rooms
FROM ROOMS;

-- 17. Average room price per night from Rooms table.
SELECT AVG(NIGHTLY_RATY) AS Average_Room_Price
FROM ROOMS;

-- 18. Count rooms per hotel grouped by Hotel_ID.
SELECT B_ID AS Hotel_ID, COUNT(*) AS Room_Count
FROM ROOMS
GROUP BY B_ID;

-- 19. Sum booking cost per guest from Bookings grouped by Guest_ID
SELECT B.C_ID AS Guest_ID, SUM(R.NIGHTLY_RATY * DATEDIFF(day, B.Check_in, B.Check_out)) AS Total_Booking_Cost -- for get price of booking
FROM BOOKING B
JOIN ROOMS R ON B.R_NUM = R.R_NUM
GROUP BY B.C_ID;

-- 20. Guests with total bookings > 5000 grouped by Guest_ID
SELECT B.C_ID AS Guest_ID, SUM(R.NIGHTLY_RATY * DATEDIFF(day, B.Check_in, B.Check_out)) AS Total_Booking_Cost
FROM BOOKING B
JOIN ROOMS R ON B.R_NUM = R.R_NUM
GROUP BY B.C_ID
HAVING SUM(R.NIGHTLY_RATY * DATEDIFF(day, B.Check_in, B.Check_out)) > 5000;

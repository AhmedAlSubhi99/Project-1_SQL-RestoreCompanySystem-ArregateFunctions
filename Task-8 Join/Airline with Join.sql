-- 1. Display each flight leg's ID, schedule, and the name of the airplane assigned to it. 
SELECT LI.flight_no, LI.leg_no, LI.flight_date, LI.departure_time, LI.arrival_time, A.AType_name
FROM Leg_Instance LI INNER JOIN Airplane AP ON LI.Airplane_id = AP.Airplane_id
LEFT OUTER JOIN Airplane_Type A ON AP.AType_name = A.AType_name;

-- 2. Display all flight numbers and the names of the departure and arrival airports. 
SELECT F.flight_no, D.Airport_code AS Departure_Airport, DA.A_name AS Departure_Airport_Name, A.Airport_code AS Arrival_Airport, AA.A_name AS Arrival_Airport_Name
FROM Flight F INNER JOIN flight_Leg FL
ON F.flight_no = FL.flight_no
INNER JOIN Depart D 
ON FL.flight_no = D.flight_no AND FL.leg_no = D.leg_no
INNER JOIN Arrive A 
ON FL.flight_no = A.flight_no AND FL.leg_no = A.leg_no
RIGHT OUTER JOIN Airport DA
ON D.Airport_code = DA.Airport_code
LEFT OUTER JOIN Airport AA 
ON A.Airport_code = AA.Airport_code;

-- 3. Display all reservation data with the name and phone of the customer who made each booking. 
SELECT SR.*, C.c_name, C.phone
FROM Seat_Reservation SR INNER JOIN Customer C
ON SR.customer_id = C.customer_id;

-- 4. Display IDs and locations of flights departing from 'CAI' or 'DXB'. 
SELECT D.flight_no, D.leg_no, A.city, A.A_state
FROM Depart D LEFT OUTER JOIN Airport A 
ON D.Airport_code = A.Airport_code
WHERE D.Airport_code IN ('CAI', 'DXB');

-- 5. Display full data of flights whose names start with 'A'. 
SELECT * 
FROM Flight 
WHERE airline LIKE 'A%';

-- 6. List customers who have bookings with total payment between 600 and 1200. 
SELECT C.customer_id, C.c_name, C.phone, SUM(F.amount) AS total_payment
FROM Seat_Reservation SR INNER JOIN Customer C ON SR.customer_id = C.customer_id
LEFT OUTER JOIN Leg_Instance LI ON SR.flight_no = LI.flight_no AND SR.leg_no = LI.leg_no AND SR.flight_date = LI.flight_date
RIGHT OUTER JOIN Flight F1 ON LI.flight_no = F1.flight_no
INNER JOIN Fare F ON F1.Fare_code = F.Code
GROUP BY C.customer_id, C.c_name, C.phone
HAVING SUM(F.amount) BETWEEN 600 AND 1200;


-- 7. Retrieve all passengers on 'Flight 1001' who booked more than 2 seats. 
SELECT C.c_name, COUNT(*) AS seats_booked
FROM Seat_Reservation SR INNER JOIN Customer C ON SR.customer_id = C.customer_id
WHERE SR.flight_no = 1001
GROUP BY C.customer_id, C.c_name
HAVING COUNT(*) > 2;


-- 8. Find names of passengers whose booking was handled by agent "Youssef Hamed". 
-- Example (not usable without modifying schema)

-- Note : We dont provide agents table

-- 9. Display each passenger’s name and the flights they booked, ordered by flight date. 
SELECT C.c_name, SR.flight_no, SR.leg_no, SR.flight_date
FROM Seat_Reservation SR INNER JOIN Customer C 
ON SR.customer_id = C.customer_id
ORDER BY SR.flight_date;

-- 10.  For each flight departing from 'Cairo', display the flight number, departure time, and airline name. 
SELECT F.flight_no, D.scheduled_dep_time, F.airline
FROM Depart D RIGHT OUTER JOIN Airport A
ON D.Airport_code = A.Airport_code
LEFT OUTER JOIN Flight F
ON D.flight_no = F.flight_no
WHERE A.city = 'Cairo';

-- 11.  Display all staff members who are assigned as supervisors for flights. 

--Note : We dont provide supervisors table

-- 12.  Display all bookings and their related passengers, even if some bookings are unpaid.
SELECT SR.*, C.c_name
FROM Seat_Reservation SR LEFT JOIN Customer C ON
SR.customer_id = C.customer_id;


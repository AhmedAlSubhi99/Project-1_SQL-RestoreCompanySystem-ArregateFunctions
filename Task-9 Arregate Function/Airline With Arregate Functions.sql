-- 11. Count total flights in FLIGHT table. 
SELECT COUNT(*) AS Total_Flights
FROM Flight;

-- 12. Average available seats per leg using FLIGHT_LEG table. 
SELECT AVG(AT.Max_seats) AS Average_Available_Seats
FROM Leg_Instance LI
JOIN Airplane AP ON LI.Airplane_id = AP.Airplane_id
JOIN Airplane_Type AT ON AP.AType_name = AT.AType_name;

-- 13. Count flights scheduled per airline from FLIGHT grouped by Airline_ID. 
SELECT airline AS Airline_ID, COUNT(*) AS Flight_Count
FROM Flight
GROUP BY airline;

-- 14. Total payments per leg using LEG_INSTANCE table grouped by Flight_Leg_ID. 
SELECT SR.flight_no, SR.leg_no, SR.flight_date, SUM(F.amount) AS Total_Payment
FROM Seat_Reservation SR
INNER JOIN Leg_Instance LI 
    ON SR.flight_no = LI.flight_no AND SR.leg_no = LI.leg_no AND SR.flight_date = LI.flight_date
INNER JOIN Flight F1 
    ON LI.flight_no = F1.flight_no
INNER JOIN Fare F 
    ON F1.Fare_code = F.Code
GROUP BY SR.flight_no, SR.leg_no, SR.flight_date;

-- 15. List flight legs with total payments > 10000 grouped by Flight_Leg_ID.
SELECT SR.flight_no, SR.leg_no, SR.flight_date, SUM(F.amount) AS Total_Payment
FROM Seat_Reservation SR
INNER JOIN Leg_Instance LI 
    ON SR.flight_no = LI.flight_no AND SR.leg_no = LI.leg_no AND SR.flight_date = LI.flight_date
INNER JOIN Flight F1 
    ON LI.flight_no = F1.flight_no
INNER JOIN Fare F 
    ON F1.Fare_code = F.Code
GROUP BY SR.flight_no, SR.leg_no, SR.flight_date
HAVING SUM(F.amount) > 10000;

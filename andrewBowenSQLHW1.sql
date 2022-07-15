-- Andrew Bowen CUNY SQL Bridge HW 1

-- 1
SELECT MAX(distance) FROM flights;

-- 2
SELECT COUNT(DISTINCT(engines)) FROM planes;

-- 2nd part of the question, I'm ordering it to make the output a bit cleaner
SELECT engines, MAX(seats) FROM planes GROUP BY engines ORDER BY engines;

-- 3
SELECT COUNT(flight) FROM flights;

-- 4
SELECT carrier, COUNT(carrier) FROM flights GROUP BY carrier;

-- 5
SELECT carrier, COUNT(flight) FROM flights
GROUP BY carrier
ORDER BY COUNT(flight) DESC;

-- 6

SELECT carrier, COUNT(flight) FROM flights
GROUP BY carrier
ORDER BY COUNT(flight) DESC LIMIT 5;

-- 7
SELECT carrier, COUNT(flight) FROM flights
WHERE distance > 1000
GROUP BY carrier
ORDER BY COUNT(flight) DESC LIMIT 5;

-- 8: What is the max & min departure delat and air time for each airline? (would like it ordered by carrier/airline)
SELECT MAX(dep_delay), MIN(dep_delay), MAX(air_time), MIN(air_time)
FROM flights
GROUP BY carrier
ORDER BY carrier;



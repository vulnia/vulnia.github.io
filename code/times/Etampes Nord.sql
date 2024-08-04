SELECT DISTINCT st_A.departure_time, st_B.departure_time, st_C.departure_time, st_D.departure_time, st_E.departure_time, st_F.departure_time, st_G.departure_time, t.trip_headsign
FROM stop_times st_A, stop_times st_B, stop_times st_C, stop_times st_D, stop_times st_E, stop_times st_F, stop_times st_G, trips t
WHERE st_A.trip_id = st_B.trip_id
AND st_B.trip_id = st_C.trip_id
AND st_C.trip_id = st_D.trip_id
AND st_D.trip_id = st_E.trip_id
AND st_E.trip_id = st_F.trip_id
AND st_F.trip_id = st_G.trip_id
AND st_A.trip_id = t.trip_id

AND st_A.trip_id IN (
	SELECT trip_id
    FROM trips
    WHERE route_id IN (
		SELECT route_id
        FROM routes
        WHERE route_short_name = "C" )
        
	AND service_id IN (
		SELECT service_id
        FROM calendar_dates
        WHERE date_ BETWEEN '2024-07-29' AND '2024-08-02'
        UNION
        SELECT service_id
        FROM calendar
        WHERE (monday OR tuesday OR wednesday OR thursday OR friday) AND '2024-07-29' >= start_date AND '2024-08-02' <= end_date))
        
AND st_A.stop_id IN (
	SELECT stop_id
    FROM stops
    WHERE stop_name LIKE "Saint-Martin%")
        
AND st_B.stop_id IN (
	SELECT stop_id
    FROM stops
    WHERE stop_name LIKE "Étampes")
    
AND st_C.stop_id IN (
	SELECT stop_id
    FROM stops
    WHERE stop_name LIKE "Étréchy")
    
AND st_D.stop_id IN (
	SELECT stop_id
	FROM stops
    WHERE stop_name LIKE "%Chamarande")
    
AND st_E.stop_id IN (
	SELECT stop_id
    FROM stops
    WHERE stop_name LIKE "Lardy")
    
AND st_F.stop_id IN (
	SELECT stop_id
    FROM stops
    WHERE stop_name LIKE "Bouray")
	
AND st_G.stop_id IN (
	SELECT stop_id
	FROM stops
	WHERE stop_name LIKE "Marolles%")
	
AND t.trip_headsign IN ("SARA","ZARA")

ORDER BY st_A.departure_time;
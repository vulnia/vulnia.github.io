WITH
st_A AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Bibliothèque François Mitterrand"
    )
),
st_B AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Gare d'Austerlitz"
    )
),
st_C AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Saint-Michel Notre-Dame"
    )
),
st_D AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Musée d'Orsay"
    )
),
st_E AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Invalides"
    )
),
st_F AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Pont de l'Alma"
    )
),
st_G AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Champ de Mars Tour Eiffel"
	)
)

SELECT *
FROM(	/*ORDER BY REQUIRES ENCASING UNION IN ONE SELECT*/

SELECT
t.trip_headsign,
st_A.departure_time Ad1,
st_B.departure_time Bd1,
st_C.departure_time Cd1,
st_D.departure_time Dd1,
st_E.departure_time Ed1,
st_F.departure_time Fd1,
st_G.departure_time Gd1

FROM
trips t

LEFT OUTER JOIN st_A ON
t.trip_id = st_A.trip_id
LEFT OUTER JOIN st_B ON
st_A.trip_id = st_B.trip_id
LEFT OUTER JOIN st_C ON
st_B.trip_id = st_C.trip_id
LEFT OUTER JOIN st_D ON
st_C.trip_id = st_D.trip_id
LEFT OUTER JOIN st_E ON
st_D.trip_id = st_E.trip_id
LEFT OUTER JOIN st_F ON
st_E.trip_id = st_F.trip_id
LEFT OUTER JOIN st_G ON
st_F.trip_id = st_G.trip_id

WHERE service_id IN (
    SELECT service_id
    FROM calendar_dates
    WHERE date_ BETWEEN '2024-08-19' AND '2024-08-23'

    UNION

    SELECT service_id
    FROM calendar
    WHERE (monday OR tuesday OR wednesday OR thursday OR friday) AND start_date <= '2024-08-23' AND end_date >= '2024-08-19'
)

AND t.trip_headsign IN ("NORA","VACK","VICO","SARA","ZARA","ORET")

UNION

SELECT
t.trip_headsign,
st_A.departure_time Ad2,
st_B.departure_time Bd2,
st_C.departure_time Cd2,
st_D.departure_time Dd2,
st_E.departure_time Ed2,
st_F.departure_time Fd2,
st_G.departure_time Gd2

FROM
trips t

LEFT OUTER JOIN st_G ON
t.trip_id = st_G.trip_id
LEFT OUTER JOIN st_F ON
st_G.trip_id = st_F.trip_id
LEFT OUTER JOIN st_E ON
st_F.trip_id = st_E.trip_id
LEFT OUTER JOIN st_D ON
st_E.trip_id = st_D.trip_id
LEFT OUTER JOIN st_C ON
st_D.trip_id = st_C.trip_id
LEFT OUTER JOIN st_B ON
st_C.trip_id = st_B.trip_id
LEFT OUTER JOIN st_A ON
st_B.trip_id = st_A.trip_id


WHERE service_id IN (
    SELECT service_id
    FROM calendar_dates
    WHERE date_ BETWEEN '2024-08-19' AND '2024-08-23'

    UNION

    SELECT service_id
    FROM calendar
    WHERE (monday OR tuesday OR wednesday OR thursday OR friday) AND start_date <= '2024-08-23' AND end_date >= '2024-08-19'
)

AND t.trip_headsign IN ("NORA","VACK","VICO","SARA","ZARA","ORET")

) derived /* ORDER BY REQUIRES ENCASING UNION IN ONE SELECT*/

ORDER BY COALESCE(Bd1,SUBTIME(Ed1,"0:10:0"))

INTO OUTFILE '/usr/local/mysql/mysql-files/bfm-nord.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
;

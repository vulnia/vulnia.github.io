WITH
st_A AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Saint-Martin d'Étampes"
    )
),
st_B AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Étampes"
    )
),
st_C AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Étréchy"
    )
),
st_D AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Gare de Chamarande"
    )
),
st_E AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Lardy"
    )
),
st_F AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Bouray"
    )
),
st_G AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Marolles-en-Hurepoix"
    )
),
st_H AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Brétigny"
    )
),
st_I AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Saint-Michel-sur-Orge"
    )
),
st_J AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Sainte-Geneviève-des-Bois"
    )
),
st_K AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Épinay-sur-Orge"
    )
),
st_L AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Savigny-sur-Orge"
    )
),
st_M AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Juvisy"
    )
),
st_N AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Bibliothèque François Mitterrand"
    )
),
st_O AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Gare d'Austerlitz"
    )
),
st_P AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Saint-Michel Notre-Dame"
    )
),
st_Q AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Musée d'Orsay"
    )
),
st_R AS (
    SELECT *
    FROM stop_times
    WHERE stop_id IN(
        SELECT stop_id
        FROM stops
        WHERE stop_name LIKE "Invalides"
    )
)

SELECT
t.trip_headsign,
st_A.departure_time,
st_B.departure_time,
st_C.departure_time,
st_D.departure_time,
st_E.departure_time,
st_F.departure_time,
st_G.departure_time,
st_H.departure_time,
st_I.departure_time,
st_J.departure_time,
st_K.departure_time,
st_L.departure_time,
st_M.departure_time,
st_N.arrival_time,
st_O.arrival_time,
st_P.arrival_time,
st_Q.arrival_time,
st_R.arrival_time

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
LEFT OUTER JOIN st_H ON
st_G.trip_id = st_H.trip_id
LEFT OUTER JOIN st_I ON
st_H.trip_id = st_I.trip_id
LEFT OUTER JOIN st_J ON
st_I.trip_id = st_J.trip_id
LEFT OUTER JOIN st_K ON
st_J.trip_id = st_K.trip_id
LEFT OUTER JOIN st_L ON
st_K.trip_id = st_L.trip_id
LEFT OUTER JOIN st_M ON
st_L.trip_id = st_M.trip_id
LEFT OUTER JOIN st_N ON
st_M.trip_id = st_N.trip_id
LEFT OUTER JOIN st_O ON
st_N.trip_id = st_O.trip_id
LEFT OUTER JOIN st_P ON
st_O.trip_id = st_P.trip_id
LEFT OUTER JOIN st_Q ON
st_P.trip_id = st_Q.trip_id
LEFT OUTER JOIN st_R ON
st_Q.trip_id = st_R.trip_id


WHERE service_id IN (
    SELECT service_id
    FROM calendar_dates
    WHERE date_ BETWEEN '2024-08-19' AND '2024-08-23'

    UNION

    SELECT service_id
    FROM calendar
    WHERE (monday OR tuesday OR wednesday OR thursday OR friday) AND '2024-08-19' >= start_date AND '2024-08-23' <= end_date
)

AND t.trip_headsign IN ("SARA","ZARA")

ORDER BY st_A.departure_time

INTO OUTFILE '/usr/local/mysql/mysql-files/etampes-nord.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

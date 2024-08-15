LOAD DATA INFILE '/usr/local/mysql/mysql-files/transilien-gtfs/trips.txt' INTO TABLE trips
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(route_id, service_id, trip_id, trip_headsign, trip_short_name, direction_id, @vblock_id, @vshape_id, wheelchair_accessible, bikes_allowed)
SET
block_id = NULLIF(@vblock_id,''),
shape_id = NULLIF(@vshape_id,'')
;

LOAD DATA INFILE '/usr/local/mysql/mysql-files/transilien-gtfs/stops.txt' INTO TABLE stops
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(stop_id, @vstop_code, stop_name, @vstop_desc, @vstop_lon, @vstop_lat, @vzone_id, @vstop_url, @vlocation_type, parent_station, @vstop_timezone, @vlevel_id, @vwheelchair_boarding, @vplatform_code)
SET
stop_code = NULLIF(@vstop_code,''),
stop_desc = NULLIF(@vstop_desc,''),
stop_lon = TRUNCATE(@vstop_lon,10),
stop_lat = TRUNCATE(@vstop_lat,10),
zone_id = NULLIF(@vzone_id,''),
stop_url = NULLIF(@vstop_url,''),
location_type = NULLIF(@vlocation_type,''),
stop_timezone = NULLIF(@vstop_timezone,''),
level_id = NULLIF(@vlevel_id,''),
wheelchair_boarding = NULLIF(@vwheelchair_boarding,''),
platform_code = NULLIF(@vplatform_code,'')
;

LOAD DATA INFILE '/usr/local/mysql/mysql-files/transilien-gtfs/stop_times.txt' INTO TABLE stop_times
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(trip_id, arrival_time, departure_time, stop_id, stop_sequence, pickup_type, drop_off_type, @vlocal_zone_id, @vstop_headsign, timepoint)
SET
local_zone_id = NULLIF(@vlocal_zone_id,''),
stop_headsign = NULLIF(@vstop_headsign,'')
;

LOAD DATA INFILE '/usr/local/mysql/mysql-files/transilien-gtfs/routes.txt' INTO TABLE routes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(route_id, agency_id, route_short_name, route_long_name, @vroute_desc, route_type, @vroute_url, route_color, route_text_color, @vroute_sort_order)
SET
route_desc = NULLIF(@vroute_desc,''),
route_url = NULLIF(@vroute_url,''),
route_sort_order = NULLIF(@vroute_sort_order,'')
;

LOAD DATA INFILE '/usr/local/mysql/mysql-files/transilien-gtfs/calendar.txt' INTO TABLE calendar 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA INFILE '/usr/local/mysql/mysql-files/transilien-gtfs/calendar_dates.txt' INTO TABLE calendar_dates
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
;

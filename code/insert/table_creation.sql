CREATE TABLE calendar (
	tid_calendar INT PRIMARY KEY NOT NULL,
	service_id VARCHAR(50),
	monday BOOL,
	tuesday BOOL,
	wednesday BOOL,
	thursday BOOL,
	friday BOOL, 
	saturday BOOL,
	sunday BOOL,
	start_date DATE, 
	end_date DATE		
	);
	
CREATE TABLE calendar_dates (
	tid_calendar_dates INT PRIMARY KEY NOT NULL,
	service_id VARCHAR(50),
	date_ DATE,
	exception_type TINYINT
	);

CREATE TABLE routes (
	tid_routes INT PRIMARY KEY NOT NULL,
	route_id VARCHAR(20),
	agency_id VARCHAR(10),
	route_short_name VARCHAR(10),
	route_long_name VARCHAR(100),
	route_desc VARCHAR(200),
	route_type TINYINT,
	route_url VARCHAR(200),
	route_color VARCHAR(6),
	route_text_color VARCHAR(6),
	route_sort_order INT
	);
	
CREATE TABLE stop_times (
	tid_stop_times INT PRIMARY KEY NOT NULL,
	trip_id VARCHAR(50),
	arrival_time TIME,
	departure_time TIME,
	stop_id VARCHAR(40),
	stop_sequence SMALLINT,
	pickup_type BOOL,
	drop_off_type BOOL,
	local_zone_id TINYINT,
	stop_headsign VARCHAR(20),
	timepoint TINYINT
	);
	
	
CREATE TABLE stops (
	tid_stops INT PRIMARY KEY NOT NULL,
	stop_id VARCHAR(40),
	stop_code VARCHAR(20),
	stop_name VARCHAR(200),
	stop_desc VARCHAR(200),
	stop_lon DOUBLE,
	stop_lat DOUBLE,
	zone_id TINYINT,
	stop_url VARCHAR(200),
	location_type TINYINT,
	parent_station VARCHAR(20),
	stop_timezone VARCHAR(20),
	level_id TINYINT,
	wheelchair_boarding BOOL,
	platform_code SMALLINT
	);
	
CREATE TABLE trips (
	tid_trips INT PRIMARY KEY NOT NULL,
	route_id VARCHAR(20),
	service_id VARCHAR(50),
	trip_id VARCHAR(50),
	trip_headsign VARCHAR(200), 
	trip_short_name VARCHAR(20), 
	direction_id TINYINT,
	block_id INT,
	shape_id INT,
	wheelchair_accessible BOOL,
	bikes_allowed BOOL
	);

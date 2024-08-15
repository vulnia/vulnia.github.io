CREATE TABLE calendar(
	service_id VARCHAR(50) PRIMARY KEY NOT NULL,
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
	service_id VARCHAR(50),
	date_ DATE,
	exception_type TINYINT,
	PRIMARY KEY(service_id, date_)
	);

CREATE TABLE routes (
	route_id VARCHAR(20) PRIMARY KEY NOT NULL,
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
	trip_id VARCHAR(50),
	arrival_time TIME,
	departure_time TIME,
	stop_id VARCHAR(40),
	stop_sequence SMALLINT,
	pickup_type BOOL,
	drop_off_type BOOL,
	local_zone_id TINYINT,
	stop_headsign VARCHAR(20),
	timepoint TINYINT,
	PRIMARY KEY (trip_id, stop_id)
	);
	
	
CREATE TABLE stops (
	stop_id VARCHAR(40) PRIMARY KEY NOT NULL,
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
	route_id VARCHAR(20),
	service_id VARCHAR(50),
	trip_id VARCHAR(50) PRIMARY KEY NOT NULL,
	trip_headsign VARCHAR(200), 
	trip_short_name VARCHAR(20), 
	direction_id TINYINT,
	block_id INT,
	shape_id INT,
	wheelchair_accessible BOOL,
	bikes_allowed BOOL
	);

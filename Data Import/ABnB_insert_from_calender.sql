-- this dataset is large, increase the connction timout to load it
-- 		almost half of the timeslots don't have a listing in the table!?
--      int was not big enough for the listing_id, BIGINT UNSIGNED used instead


use airbnb_berlin;

SET GLOBAL connect_timeout = 120;
SET GLOBAL net_read_timeout = 120;
SET GLOBAL mysqlx_read_timeout = 120;
SET GLOBAL mysqlx_connect_timeout = 120;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/calendar.csv' IGNORE INTO TABLE listing_calendar
	FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    
    (listing_id, calendar_date, @avalable, @dummy, @dummy, minimum_nights, maximum_nights)
    SET avalable = case 
		WHEN @avalable = 't' THEN TRUE
        WHEN @avalable = 'f' THEN FALSE
        ELSE NULL
	END;

SET GLOBAL connect_timeout = 10;
SET GLOBAL net_read_timeout = 30;
SET GLOBAL mysqlx_read_timeout = 30;
SET GLOBAL mysqlx_connect_timeout = 30;


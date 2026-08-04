CREATE DATABASE if NOT EXISTS airbnb_berlin;
use airbnb_berlin;



CREATE TABLE if NOT EXISTS listings(
	id BIGINT UNSIGNED PRIMARY KEY,
    descriptive_name VARCHAR(300) NOT NULL,
    host_id int UNSIGNED NOT NULL,
    neighbourhood_group VARCHAR(60),
    neighbourhood VARCHAR(60) NOT NULL,
    latitude DOUBLE NOT NULL,
    longitude DOUBLE NOT NULL,
    room_type VARCHAR(30),
    price FLOAT,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month FLOAT,
    calculated_host_listings_count INT,
    availability_365 INT,
    number_of_reviews_ltm INT,
    licence VARCHAR(500),
    FOREIGN KEY(neighbourhood_group, neighbourhood)
		REFERENCES neighbourhoods(neighbourhood_group, neighbourhood),
	FOREIGN KEY(host_id)
		REFERENCES listing_hosts(id)
);

CREATE TABLE if NOT EXISTS listing_calendar(
	listing_id BIGINT UNSIGNED,
    calendar_date DATE, 
    avalable BOOLEAN,
    minimum_nights INT,
    maximum_nights INT,
    FOREIGN KEY (listing_id)
		REFERENCES listings(id),
	PRIMARY KEY(listing_id, calendar_date)
);


CREATE TABLE if NOT EXISTS neighbourhoods(
	neighbourhood_group VARCHAR(60),
    neighbourhood VARCHAR(60),
    PRIMARY KEY(neighbourhood_group, neighbourhood)
);


CREATE TABLE if NOT EXISTS listing_hosts(
	id INT UNSIGNED PRIMARY KEY,
    host_name VARCHAR(40)
);
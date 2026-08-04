-- load into temp table
-- insert into listing_hosts then listings


use airbnb_berlin;


DROP table IF EXISTS totaldata;

CREATE table totaldata(
	id BIGINT UNSIGNED PRIMARY KEY,
    descriptive_name VARCHAR(300) NOT NULL,
    host_id int NOT NULL,
    host_name VARCHAR(40),
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
    licence VARCHAR(500)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/listings.csv' ignore INTO TABLE totaldata
	FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (id, descriptive_name, host_id, host_name, neighbourhood_group, neighbourhood, latitude, longitude, room_type, @inp_price, minimum_nights, number_of_reviews, @inp_last_review, @inp_reviews_per_month, calculated_host_listings_count, availability_365, number_of_reviews_ltm, licence)
    SET price = nullif(@inp_price, ''),
    last_review = nullif(@inp_last_review, ''),
    reviews_per_month = nullif(@inp_reviews_per_month, '');
    
INSERT IGNORE INTO listing_hosts(id, host_name) SELECT host_id, host_name FROM totaldata;


INSERT IGNORE INTO listings(id, descriptive_name, host_id, neighbourhood_group, neighbourhood, latitude, longitude, room_type, price, minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count, availability_365, number_of_reviews_ltm, licence) 
					 SELECT id, descriptive_name, host_id, neighbourhood_group, neighbourhood, latitude, longitude, room_type, price, minimum_nights, number_of_reviews, last_review, reviews_per_month, calculated_host_listings_count, availability_365, number_of_reviews_ltm, licence 
    FROM totaldata; 
    
DROP table totaldata;
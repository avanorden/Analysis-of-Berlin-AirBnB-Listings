use airbnb_berlin;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/neighbourhoods.csv' IGNORE INTO TABLE neighbourhoods
	FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES
    (@inp_neighbourhood_group, @inp_neighbourhood)
    SET neighbourhood_group = nullif(@inp_neighbourhood_group, ''),
    neighbourhood = nullif(@inp_neighbourhood, '');
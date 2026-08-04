use airbnb_berlin;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/neighbourhoods.csv' IGNORE INTO TABLE neighbourhoods
	FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;
    
SELECT * FROM neighbourhoods where length(neighbourhood) = (select max(length(neighbourhood)) from neighbourhoods);


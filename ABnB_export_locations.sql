use airbnb_berlin;

-- output listing locations

(SELECT 'id',
    'descriptive_name',
    'neighbourhood',
    'neighbourhood_group',
    'latitude',
    'longitude',
    'price')
UNION ALL
(SELECT DISTINCT
    id,
    REPLACE(descriptive_name, '"', ''),
    neighbourhood,
    neighbourhood_group,
    latitude,
    longitude,
    price
FROM
    listings
WHERE
    price IS NOT NULL)
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/output_locations.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';


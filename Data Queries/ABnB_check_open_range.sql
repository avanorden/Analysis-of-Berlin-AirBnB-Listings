-- checking for an open range of days at a given district
use airbnb_berlin;

SET @start_date = cast('2025-10-08' as DATE);
SET @end_date = cast('2025-10-10' as DATE);
SET @district = 'Mitte';


SET @stay_length = DATEDIFF(@end_date, @start_date) + 1;

-- put the subquery result in a temporary TABLE to speed up query
CREATE TABLE avalable_listings(
	id BIGINT UNSIGNED PRIMARY KEY
);

-- puts the ids of avalable listings into the avalable_listings table
-- checks if all days are avalable, assuming all unavailable days have been filtered out from the group
-- HAVING date_add(@start_date, INTERVAL COUNT(*) - 1 DAY) = @end_date;
INSERT INTO avalable_listings
SELECT 
    listing_id
FROM
    listing_calendar
WHERE
    calendar_date >= @start_date
		AND calendar_date <= @end_date
        AND avalable = TRUE
        AND (minimum_nights <= @stay_length
        AND maximum_nights >= @stay_length)
GROUP BY listing_id
HAVING COUNT(*) =  @stay_length;


SELECT 
    id,
    descriptive_name,
    neighbourhood,
    price,
    DATEDIFF(@end_date, @start_date) + 1 AS days,
    price * (DATEDIFF(@end_date, @start_date) + 1) AS total_price
FROM
    listings
WHERE
    neighbourhood_group = @district
        AND price IS NOT NULL
        AND id = SOME (SELECT id FROM avalable_listings)
ORDER BY price DESC;



DROP TABLE avalable_listings;



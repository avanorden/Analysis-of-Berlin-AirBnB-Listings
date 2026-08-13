
-- rank months based on how many bookings it has

USE airbnb_berlin;

CREATE OR REPLACE VIEW bookings_by_month AS
SELECT 
	monthname(calendar_date) as booking_month, 
    count(avalable) as bookings, 
    RANK() OVER (ORDER BY count(avalable) DESC) as booking_ranking 
FROM listing_calendar 
WHERE avalable = FALSE 
GROUP BY booking_month;

SELECT booking_month, bookings, booking_ranking FROM bookings_by_month;


-- rank months for each district based on how many bookings it has
CREATE OR REPLACE VIEW bookings_by_district AS 
SELECT 
	neighbourhood_group, 
	monthname(calendar_date) as month, 
    count(avalable) as bookings, 
    RANK() OVER (PARTITION BY neighbourhood_group ORDER BY count(avalable) DESC) as district_booking_ranking 
FROM listing_calendar
JOIN listings on listing_id = listings.id
WHERE avalable = FALSE
GROUP BY neighbourhood_group, month
ORDER BY neighbourhood_group;


SET @selected_district = 'Treptow - Köpenick';

SELECT 
    neighbourhood_group,
    month,
    district_booking_ranking,
    (SELECT 
            booking_ranking
        FROM
            bookings_by_month
        WHERE
            booking_month = month) AS overall_month_ranking
FROM
    bookings_by_district
HAVING neighbourhood_group = @selected_district
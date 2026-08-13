

use airbnb_berlin;

-- show the price for the district with the higest average price

-- rank districts by average price
SELECT 
    neighbourhood_group as district, round(AVG(price), 0) AS average_cost, RANK() OVER (ORDER BY AVG(price) DESC) as price_ranking
FROM
    listings
WHERE
	price < (select AVG(price) from listings) +  2 * (select STDDEV(price) from listings)
GROUP BY neighbourhood_group
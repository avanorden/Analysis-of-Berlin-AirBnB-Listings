-- avreage the prices in each neighborhood and sort by price

use airbnb_berlin;

SELECT 
    neighbourhood, neighbourhood_group, round(AVG(price), 0) AS average_price
FROM
    listings
WHERE
    price < (select AVG(price) from listings) +  2 * (select STDDEV(price) from listings)
GROUP BY neighbourhood , neighbourhood_group
ORDER BY average_price DESC;

-- avreage the prices in each neighborhood and sort by price

use airbnb_berlin;

SELECT 
    neighbourhood, neighbourhood_group, AVG(price) AS average_price
FROM
    listings
WHERE
    price != 0.00
GROUP BY neighbourhood , neighbourhood_group
ORDER BY average_price DESC;
-- show the price for the district with the higest average price

USE airbnb_berlin;


SELECT 
    neighbourhood_group, AVG(price) AS average
FROM
    listings
WHERE
    price != 0.00
GROUP BY neighbourhood_group
ORDER BY average DESC
LIMIT 1;


-- rank districts by average price
SELECT 
    neighbourhood_group as district, AVG(price) AS average_cost, RANK() OVER (ORDER BY AVG(price) DESC) as price_ranking
FROM
    listings
GROUP BY neighbourhood_group;
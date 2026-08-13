--  does an airBNB listing exist in the same location at a lower price
use airbnb_berlin;

set @listing_id = cast(85560 as UNSIGNED);
set @listing_day = cast('2025-10-08' as DATE);

-- check to see if (id, day) is valid
SELECT avalable from listing_calendar WHERE listing_id = @listing_id AND calendar_date = @listing_day;



SELECT id, descriptive_name, price FROM listings WHERE
neighbourhood = (SELECT neighbourhood from listings WHERE id = @listing_id) 
AND price < (SELECT price from listings WHERE id = @listing_id) 
AND id = SOME (SELECT listing_id from listing_calendar WHERE calendar_date = @listing_day AND avalable = TRUE);

USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;


==========================
1. Overall Conversion Rate
SELECT

ROUND(

(
COUNT_IF(event_type='PURCHASE')
* 100.0
)

/

NULLIF(
COUNT_IF(event_type='HOME_PAGE'),
0
),

2

) AS conversion_rate_percentage

FROM silver_clickstream;
--------
2. Cart Abandonment Rate
SELECT

ROUND(

(

COUNT_IF(event_type='ADD_TO_CART')

-

COUNT_IF(event_type='PURCHASE')

)

* 100.0

/

NULLIF(
COUNT_IF(event_type='ADD_TO_CART'),
0
),

2

)

AS cart_abandonment_rate

FROM silver_clickstream;
-----------
3. Funnel Analysis
SELECT

COUNT_IF(event_type='HOME_PAGE')
AS home_page_visits,

COUNT_IF(event_type='SEARCH')
AS searches,

COUNT_IF(event_type='PRODUCT_VIEW')
AS product_views,

COUNT_IF(event_type='ADD_TO_CART')
AS add_to_cart,

COUNT_IF(event_type='CHECKOUT')
AS checkouts,

COUNT_IF(event_type='PURCHASE')
AS purchases

FROM silver_clickstream;
------------------
4. Top Purchased Products
SELECT

product_id,

COUNT(*) purchases

FROM silver_clickstream

WHERE event_type='PURCHASE'

GROUP BY product_id

ORDER BY purchases DESC

LIMIT 20;
5. Most Viewed Products
SELECT

product_id,

COUNT(*) views

FROM silver_clickstream

WHERE event_type='PRODUCT_VIEW'

GROUP BY product_id

ORDER BY views DESC

LIMIT 20;
6. Product Conversion Rate
SELECT

product_id,

COUNT_IF(
event_type='PRODUCT_VIEW'
) views,

COUNT_IF(
event_type='PURCHASE'
) purchases,

ROUND(

COUNT_IF(
event_type='PURCHASE'
)
*100.0

/

NULLIF(
COUNT_IF(
event_type='PRODUCT_VIEW'
),
0
),

2

) conversion_rate

FROM silver_clickstream

GROUP BY product_id

ORDER BY conversion_rate DESC;
7. Top Countries
SELECT

country,

COUNT(*) total_events

FROM silver_clickstream

GROUP BY country

ORDER BY total_events DESC;
8. Top Purchasing Countries
SELECT

country,

COUNT(*) purchases

FROM silver_clickstream

WHERE event_type='PURCHASE'

GROUP BY country

ORDER BY purchases DESC;
9. Device Analytics
SELECT

device_type,

COUNT(*) total_events

FROM silver_clickstream

GROUP BY device_type

ORDER BY total_events DESC;
10. Device Conversion Analysis
SELECT

device_type,

COUNT_IF(
event_type='PURCHASE'
) purchases,

COUNT_IF(
event_type='HOME_PAGE'
) visits,

ROUND(

COUNT_IF(
event_type='PURCHASE'
)
*100.0

/

NULLIF(
COUNT_IF(
event_type='HOME_PAGE'
),
0
),

2

) conversion_rate

FROM silver_clickstream

GROUP BY device_type;
11. Average Session Duration
SELECT

ROUND(

AVG(
session_duration_seconds
),

2

) avg_session_duration_seconds

FROM gold_session_analytics;
12. Longest Sessions
SELECT

session_id,

user_id,

session_duration_seconds

FROM gold_session_analytics

ORDER BY session_duration_seconds DESC

LIMIT 20;
13. Daily Traffic Trend
SELECT

DATE(event_time) event_date,

COUNT(*) total_events

FROM silver_clickstream

GROUP BY DATE(event_time)

ORDER BY event_date;
14. Daily Purchase Trend
SELECT

DATE(event_time) event_date,

COUNT(*) purchases

FROM silver_clickstream

WHERE event_type='PURCHASE'

GROUP BY DATE(event_time)

ORDER BY event_date;
15. Most Active Customers
SELECT

user_id,

COUNT(*) total_events

FROM silver_clickstream

GROUP BY user_id

ORDER BY total_events DESC

LIMIT 20;

16. Customers With Highest Purchases
SELECT

user_id,

COUNT(*) purchases

FROM silver_clickstream

WHERE event_type='PURCHASE'

GROUP BY user_id

ORDER BY purchases DESC

LIMIT 20;
17. Session Distribution
SELECT

CASE

WHEN session_duration_seconds < 60
THEN 'UNDER_1_MIN'

WHEN session_duration_seconds < 300
THEN '1_TO_5_MIN'

WHEN session_duration_seconds < 900
THEN '5_TO_15_MIN'

ELSE '15_PLUS_MIN'

END duration_bucket,

COUNT(*) sessions

FROM gold_session_analytics

GROUP BY duration_bucket

ORDER BY sessions DESC;
18. Product Funnel
SELECT

product_id,

COUNT_IF(
event_type='PRODUCT_VIEW'
) views,

COUNT_IF(
event_type='ADD_TO_CART'
) carts,

COUNT_IF(
event_type='PURCHASE'
) purchases

FROM silver_clickstream

GROUP BY product_id;
19. Revenue Analytics

(assuming generator contains product prices)

SELECT

SUM(product_price)
AS total_revenue,

AVG(product_price)
AS avg_order_value

FROM silver_clickstream

WHERE event_type='PURCHASE';
20. Executive KPI Dashboard Query
SELECT

COUNT(DISTINCT user_id)
AS total_users,

COUNT(DISTINCT session_id)
AS total_sessions,

COUNT_IF(event_type='PURCHASE')
AS total_purchases,

COUNT_IF(event_type='PRODUCT_VIEW')
AS total_product_views,

COUNT_IF(event_type='ADD_TO_CART')
AS total_cart_adds,

COUNT_IF(event_type='CHECKOUT')
AS total_checkouts

FROM silver_clickstream;
==========================

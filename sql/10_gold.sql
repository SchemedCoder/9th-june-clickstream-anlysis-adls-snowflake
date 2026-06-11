USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==================================================
-- GOLD SESSION ANALYTICS
-- ==================================================

CREATE OR REPLACE TABLE gold_session_analytics AS

SELECT

```
session_id,

user_id,

MIN(event_time) AS session_start,

MAX(event_time) AS session_end,

DATEDIFF(
    SECOND,
    MIN(event_time),
    MAX(event_time)
) AS session_duration_seconds,

COUNT(*) AS total_events,

COUNT(DISTINCT product_id) AS products_viewed
```

FROM silver_clickstream

GROUP BY

```
session_id,
user_id;
```

-- ==================================================
-- GOLD PRODUCT ANALYTICS
-- ==================================================

CREATE OR REPLACE TABLE gold_product_analytics AS

SELECT

```
product_id,

COUNT_IF(event_type = 'PRODUCT_VIEW') AS views,

COUNT_IF(event_type = 'ADD_TO_CART') AS cart_adds,

COUNT_IF(event_type = 'PURCHASE') AS purchases,

ROUND(

    COUNT_IF(event_type = 'PURCHASE')
    * 100.0

    /

    NULLIF(
        COUNT_IF(event_type = 'PRODUCT_VIEW'),
        0
    ),

    2

) AS conversion_rate
```

FROM silver_clickstream

WHERE product_id IS NOT NULL

GROUP BY product_id;

-- ==================================================
-- GOLD FUNNEL ANALYTICS
-- ==================================================

CREATE OR REPLACE TABLE gold_funnel_analytics AS

SELECT

```
COUNT_IF(event_type = 'HOME_PAGE') AS home_page_visits,

COUNT_IF(event_type = 'SEARCH') AS searches,

COUNT_IF(event_type = 'PRODUCT_VIEW') AS product_views,

COUNT_IF(event_type = 'ADD_TO_CART') AS add_to_cart,

COUNT_IF(event_type = 'CHECKOUT') AS checkouts,

COUNT_IF(event_type = 'PURCHASE') AS purchases
```

FROM silver_clickstream;

-- ==================================================
-- GOLD CUSTOMER ANALYTICS
-- ==================================================

CREATE OR REPLACE TABLE gold_customer_analytics AS

SELECT

```
user_id,

COUNT(DISTINCT session_id) AS sessions,

COUNT(*) AS total_events,

COUNT_IF(event_type = 'PURCHASE') AS purchases,

COUNT_IF(event_type = 'ADD_TO_CART') AS cart_adds
```

FROM silver_clickstream

GROUP BY user_id;

-- ==================================================
-- GOLD REVENUE ANALYTICS
-- ==================================================

CREATE OR REPLACE TABLE gold_revenue_analytics AS

SELECT

```
DATE(event_time) AS sales_date,

SUM(product_price) AS revenue,

AVG(product_price) AS average_order_value,

COUNT(*) AS total_orders
```

FROM silver_clickstream

WHERE event_type = 'PURCHASE'

GROUP BY DATE(event_time);

-- ==================================================
-- ANALYTICS VIEWS
-- ==================================================

CREATE OR REPLACE VIEW vw_session_analytics AS

SELECT *
FROM gold_session_analytics;

CREATE OR REPLACE VIEW vw_product_analytics AS

SELECT *
FROM gold_product_analytics;

CREATE OR REPLACE VIEW vw_funnel_analytics AS

SELECT *
FROM gold_funnel_analytics;

CREATE OR REPLACE VIEW vw_customer_analytics AS

SELECT *
FROM gold_customer_analytics;

CREATE OR REPLACE VIEW vw_revenue_analytics AS

SELECT *
FROM gold_revenue_analytics;

USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==========================================
-- SILVER TABLE
-- ==========================================

USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==================================================
-- SILVER TABLE
-- ==================================================

CREATE OR REPLACE TABLE silver_clickstream (

```
event_id STRING,

user_id STRING,

session_id STRING,

page STRING,

event_type STRING,

product_id STRING,

product_price NUMBER(10,2),

device_type STRING,

country STRING,

event_time TIMESTAMP_NTZ,

ingestion_time TIMESTAMP_NTZ,

is_late_event BOOLEAN,

record_created_at TIMESTAMP_NTZ
```

);

-- ==================================================
-- LOAD SILVER TABLE
-- ==================================================

INSERT INTO silver_clickstream

SELECT

```
event_id,

user_id,

session_id,

UPPER(TRIM(page)) AS page,

UPPER(TRIM(event_type)) AS event_type,

product_id,

product_price,

UPPER(TRIM(device_type)) AS device_type,

UPPER(TRIM(country)) AS country,

event_time,

ingestion_time,

CASE

    WHEN DATEDIFF(
        MINUTE,
        event_time,
        ingestion_time
    ) > 30

    THEN TRUE

    ELSE FALSE

END AS is_late_event,

CURRENT_TIMESTAMP() AS record_created_at
```

FROM

(

```
SELECT *

FROM

(

    SELECT

        *,

        ROW_NUMBER()
        OVER
        (
            PARTITION BY event_id
            ORDER BY ingestion_time DESC
        ) AS rn

    FROM bronze_clickstream_stream

)

WHERE rn = 1
```

)

WHERE

```
event_id IS NOT NULL

AND user_id IS NOT NULL

AND event_type IS NOT NULL;
```

-- ==================================================
-- VALIDATION QUERIES
-- ==================================================

SELECT COUNT(*) AS total_records
FROM silver_clickstream;

SELECT COUNT(*) AS late_events
FROM silver_clickstream
WHERE is_late_event = TRUE;

SELECT
event_type,
COUNT(*) AS total_events
FROM silver_clickstream
GROUP BY event_type
ORDER BY total_events DESC;

SELECT
country,
COUNT(*) AS total_events
FROM silver_clickstream
GROUP BY country
ORDER BY total_events DESC;

SELECT
device_type,
COUNT(*) AS total_events
FROM silver_clickstream
GROUP BY device_type
ORDER BY total_events DESC;

-- ==================================================
-- VIEW
-- ==================================================

CREATE OR REPLACE VIEW vw_silver_clickstream AS

SELECT *
FROM silver_clickstream;

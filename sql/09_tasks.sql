USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

USE WAREHOUSE CLICKSTREAM_WH;

-- ==========================================
-- SILVER LOAD TASK
-- ==========================================

CREATE OR REPLACE TASK load_silver_task

WAREHOUSE = CLICKSTREAM_WH

SCHEDULE = '1 MINUTE'

WHEN

SYSTEM$STREAM_HAS_DATA(
'BRONZE_CLICKSTREAM_STREAM'
)

AS

INSERT INTO silver_clickstream

SELECT

event_id,
user_id,
session_id,

UPPER(TRIM(page)),

UPPER(TRIM(event_type)),

product_id,

UPPER(TRIM(device_type)),

UPPER(TRIM(country)),

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

END,

CURRENT_TIMESTAMP()

FROM bronze_clickstream_stream;

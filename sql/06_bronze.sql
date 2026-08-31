USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==================================================
-- BRONZE TABLE
-- ==================================================

CREATE OR REPLACE TABLE bronze_clickstream (

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

ingestion_time TIMESTAMP_NTZ
DEFAULT CURRENT_TIMESTAMP()

);


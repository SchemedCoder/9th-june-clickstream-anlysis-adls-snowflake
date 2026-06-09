USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==========================================
-- SILVER TABLE
-- ==========================================

CREATE OR REPLACE TABLE silver_clickstream (

event_id STRING,

user_id STRING,

session_id STRING,

page STRING,

event_type STRING,

product_id STRING,

device_type STRING,

country STRING,

event_time TIMESTAMP_NTZ,

ingestion_time TIMESTAMP_NTZ,

is_late_event BOOLEAN,

record_created_at TIMESTAMP_NTZ

);

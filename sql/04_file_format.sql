USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==================================================
-- FILE FORMAT
-- ==================================================

CREATE OR REPLACE FILE FORMAT clickstream_csv

TYPE = CSV

FIELD_DELIMITER = ','

SKIP_HEADER = 1

FIELD_OPTIONALLY_ENCLOSED_BY = '"'

NULL_IF = ('NULL','null','')

EMPTY_FIELD_AS_NULL = TRUE;

-- ==================================================
-- VALIDATE
-- ==================================================

DESC FILE FORMAT clickstream_csv;

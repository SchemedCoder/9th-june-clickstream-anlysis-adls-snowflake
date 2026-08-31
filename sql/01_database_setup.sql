-- ==================================================
-- DATABASE
-- ==================================================

CREATE DATABASE IF NOT EXISTS CLICKSTREAM_DB;

USE DATABASE CLICKSTREAM_DB;

-- ==================================================
-- SCHEMA
-- ==================================================

CREATE SCHEMA IF NOT EXISTS CLICKSTREAM;

USE SCHEMA CLICKSTREAM;

-- ==================================================
-- WAREHOUSE
-- ==================================================

CREATE WAREHOUSE IF NOT EXISTS CLICKSTREAM_WH

WITH

WAREHOUSE_SIZE='XSMALL'
AUTO_SUSPEND=60
AUTO_RESUME=TRUE
INITIALLY_SUSPENDED=TRUE;

USE WAREHOUSE CLICKSTREAM_WH;

-- ==================================================
-- VERIFY
-- ==================================================

SHOW DATABASES;

SHOW SCHEMAS;

SHOW WAREHOUSES;


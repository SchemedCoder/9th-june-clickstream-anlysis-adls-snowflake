USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==========================================
-- STREAM ON BRONZE TABLE
-- ==========================================

CREATE OR REPLACE STREAM bronze_clickstream_stream

ON TABLE bronze_clickstream

APPEND_ONLY = TRUE;

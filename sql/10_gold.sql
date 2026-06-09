USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==========================================
-- SESSION ANALYTICS
-- ==========================================

CREATE OR REPLACE TABLE gold_session_analytics AS

SELECT

session_id,

user_id,

MIN(event_time) session_start,

MAX(event_time) session_end,

DATEDIFF(
SECOND,
MIN(event_time),
MAX(event_time)
) session_duration_seconds,

COUNT(*) total_events,

COUNT(
DISTINCT product_id
) products_viewed

FROM silver_clickstream

GROUP BY

session_id,
user_id;

USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==================================================
-- EXTERNAL STAGE
-- ==================================================

CREATE OR REPLACE STAGE clickstream_stage

STORAGE_INTEGRATION = clickstream_adls_int

URL='azure://clickstreamstorage.dfs.core.windows.net/clickstream';

-- ==================================================
-- VERIFY FILES
-- ==================================================

LIST @clickstream_stage;

USE DATABASE CLICKSTREAM_DB;

USE SCHEMA CLICKSTREAM;

-- ==================================================
-- SNOWPIPE
-- ==================================================

CREATE OR REPLACE PIPE clickstream_pipe

AUTO_INGEST = FALSE

AS

COPY INTO bronze_clickstream

FROM @clickstream_stage

FILE_FORMAT = (

FORMAT_NAME = clickstream_csv

)

ON_ERROR = CONTINUE;

-- ==================================================
-- VERIFY PIPE
-- ==================================================

SHOW PIPES;

DESC PIPE clickstream_pipe;


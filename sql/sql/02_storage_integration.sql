-- ==================================================
-- STORAGE INTEGRATION
-- ==================================================

CREATE OR REPLACE STORAGE INTEGRATION clickstream_adls_int

TYPE = EXTERNAL_STAGE

STORAGE_PROVIDER = AZURE

ENABLED = TRUE

AZURE_TENANT_ID = '<YOUR_AZURE_TENANT_ID>'

STORAGE_ALLOWED_LOCATIONS = (

'azure://clickstreamstorage.dfs.core.windows.net/clickstream'

);

-- ==================================================
-- VERIFY
-- ==================================================

DESC INTEGRATION clickstream_adls_int;

![CI](https://github.com/SchemedCoder/clickstream-snowflake-platform/actions/workflows/ci.yml/badge.svg)

Built a cloud-native Clickstream Analytics Platform using Azure Data Lake Storage Gen2, Snowflake, Snowpipe, Streams, Tasks, SQL, and Python. Designed a Bronze-Silver-Gold architecture for customer journey analytics, conversion funnel reporting, and product performance tracking.

## Architecture

Clickstream Events

↓

ADLS Gen2

↓

Snowflake External Stage

↓

Snowpipe

↓

Bronze

↓

Streams

↓

Silver

↓

Tasks

↓

Gold

↓

Analytics Views

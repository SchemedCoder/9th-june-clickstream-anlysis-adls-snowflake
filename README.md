![CI](https://github.com/SchemedCoder/clickstream-snowflake-platform/actions/workflows/ci.yml/badge.svg)

# Clickstream Analytics Platform

This repository contains a cloud-native Clickstream Analytics Platform built using Azure Data Lake Storage Gen2, Snowflake, Snowpipe, Streams, Tasks, SQL, and Python. It implements a Bronze-Silver-Gold architecture for customer journey analytics, conversion funnel reporting, and product performance tracking.

## Quickstart

This project uses a `Makefile` to simplify common operations.

1. **Install Dependencies:**
   ```bash
   make install
   ```
2. **Environment Variables:**
   Copy `.env.example` to `.env` and fill in your Azure/Snowflake credentials.
3. **Generate and Validate Mock Data:**
   ```bash
   make generate
   make validate
   ```
4. **Upload to ADLS Gen2:**
   ```bash
   make upload
   ```

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

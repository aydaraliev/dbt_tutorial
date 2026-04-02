#!/bin/bash
grep -q "read_parquet" /root/nyc_yellow_taxi/models/taxi_rides/taxi_rides_raw.sql 2>/dev/null && \
grep -q "dbt run" /tmp/dbt_history 2>/dev/null && \
test -f /root/nyc_yellow_taxi/dbt.duckdb

#!/bin/bash
grep -q "nyc_yellow_taxi:" /root/nyc_yellow_taxi/profiles.yml 2>/dev/null && \
grep -q "type: duckdb" /root/nyc_yellow_taxi/profiles.yml 2>/dev/null && \
grep -q "dbt debug" /tmp/dbt_history 2>/dev/null

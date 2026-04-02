#!/bin/bash
grep -q "nyc_yellow_taxi:" /root/.dbt/profiles.yml 2>/dev/null && \
grep -q "type: duckdb" /root/.dbt/profiles.yml 2>/dev/null && \
grep -q "dbt debug" /tmp/dbt_history 2>/dev/null

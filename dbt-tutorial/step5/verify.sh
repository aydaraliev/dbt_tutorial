#!/bin/bash
test -f /root/nyc_yellow_taxi/models/taxi_zone_summary.sql && \
grep -q "dbt run" /tmp/dbt_history 2>/dev/null

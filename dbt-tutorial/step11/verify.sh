#!/bin/bash
grep -q "ref('taxi_rides_raw')" /root/nyc_yellow_taxi/models/taxi_rides/creditcard_riders_by_day.sql 2>/dev/null && \
grep -q "dbt run -f\|dbt run --full-refresh" /tmp/dbt_history 2>/dev/null

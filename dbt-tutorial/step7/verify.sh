#!/bin/bash
grep -qi "count" /root/nyc_yellow_taxi/models/taxi_rides/total_creditcard_riders_by_day.sql 2>/dev/null && \
grep -q "payment_type = 1" /root/nyc_yellow_taxi/models/taxi_rides/total_creditcard_riders_by_day.sql 2>/dev/null && \
grep -q "dbt run" /tmp/dbt_history 2>/dev/null

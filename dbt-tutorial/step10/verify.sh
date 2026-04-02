#!/bin/bash
test -f /root/nyc_yellow_taxi/target/compiled/nyc_yellow_taxi/models/taxi_rides/total_amounts.sql && \
grep -q "dbt compile" /tmp/dbt_history 2>/dev/null

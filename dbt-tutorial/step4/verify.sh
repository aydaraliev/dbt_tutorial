#!/bin/bash
test -f /root/my_dbt_project/models/taxi_zone_summary.sql && \
grep -q "dbt run" /tmp/dbt_history 2>/dev/null

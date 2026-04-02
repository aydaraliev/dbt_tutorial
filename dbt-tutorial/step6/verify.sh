#!/bin/bash
test -f /root/nyc_yellow_taxi/models/schema.yml && \
grep -q "dbt test\|dbt build" /tmp/dbt_history 2>/dev/null

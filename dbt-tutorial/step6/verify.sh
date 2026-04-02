#!/bin/bash
test -f /root/my_dbt_project/models/schema.yml && \
grep -q "dbt test\|dbt build" /tmp/dbt_history 2>/dev/null

#!/bin/bash
test -f /root/my_dbt_project/models/customer_orders.sql && \
grep -q "dbt run" /tmp/dbt_history 2>/dev/null

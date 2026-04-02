#!/bin/bash
test -f /root/my_dbt_project/models/schema.yml && \
cd /root/my_dbt_project && dbt test --no-print 2>&1 | grep -q "Pass"

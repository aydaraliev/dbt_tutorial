#!/bin/bash
# Verify schema tests exist and pass
test -f /root/my_dbt_project/models/schema.yml && \
cd /root/my_dbt_project && dbt test --no-print 2>&1 | grep -q "Pass"

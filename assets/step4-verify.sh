#!/bin/bash
test -f /root/my_dbt_project/models/schema.yml && \
cd /root/my_dbt_project && /opt/dbt-env/bin/dbt test 2>&1 | grep -q "Pass"

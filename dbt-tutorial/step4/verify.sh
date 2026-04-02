#!/bin/bash
test -f /root/my_dbt_project/dbt_project.yml && \
test -f /root/.dbt/profiles.yml && \
grep -q "dbt debug" /tmp/dbt_history 2>/dev/null

#!/bin/bash
# Check that dbt was run — look in the command log or check if dbt logs dir was created
grep -q "dbt" /tmp/cmd_history 2>/dev/null || test -d /root/logs 2>/dev/null

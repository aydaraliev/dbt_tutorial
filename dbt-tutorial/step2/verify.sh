#!/bin/bash
grep -q "dbt --version\|dbt -v" /tmp/dbt_history 2>/dev/null

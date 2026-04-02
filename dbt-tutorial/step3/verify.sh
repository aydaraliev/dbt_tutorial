#!/bin/bash
grep -q "dbt -h\|dbt --help" /tmp/dbt_history 2>/dev/null

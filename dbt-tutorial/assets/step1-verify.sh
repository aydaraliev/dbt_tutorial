#!/bin/bash
# User must have run "dbt" (bare command, no subcommand)
grep -q "dbt$" /tmp/dbt_history 2>/dev/null

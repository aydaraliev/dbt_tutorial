#!/bin/bash
# Check that dbt was run by looking at shell history
grep -q "^dbt$" ~/.bash_history 2>/dev/null || grep -q "^dbt " ~/.bash_history 2>/dev/null

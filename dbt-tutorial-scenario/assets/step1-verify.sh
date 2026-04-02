#!/bin/bash
grep -q "^dbt$" ~/.bash_history 2>/dev/null || grep -q "^dbt " ~/.bash_history 2>/dev/null

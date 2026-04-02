#!/bin/bash
# Verify dbt project was initialized and connection works
test -f /root/my_dbt_project/dbt_project.yml && test -f /root/.dbt/profiles.yml

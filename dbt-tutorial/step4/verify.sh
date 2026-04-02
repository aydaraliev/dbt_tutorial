#!/bin/bash
test -f /root/nyc_yellow_taxi/dbt_project.yml && \
test -d /root/nyc_yellow_taxi/models && \
test -d /root/nyc_yellow_taxi/tests && \
test -d /root/nyc_yellow_taxi/macros && \
test -d /root/nyc_yellow_taxi/analyses && \
test -d /root/nyc_yellow_taxi/seeds && \
test -d /root/nyc_yellow_taxi/snapshots

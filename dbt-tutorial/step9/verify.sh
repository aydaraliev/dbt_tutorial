#!/bin/bash
grep -q "Первичный импорт" /root/nyc_yellow_taxi/models/model_properties.yml 2>/dev/null && \
test -f /root/nyc_yellow_taxi/target/catalog.json

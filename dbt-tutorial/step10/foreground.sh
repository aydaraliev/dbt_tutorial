#!/bin/bash
# Create Jinja-templated model
cat > /root/nyc_yellow_taxi/models/taxi_rides/total_amounts.sql << 'SQLEOF'
select
{% for column_name in ['fare_amount', 'tip_amount', 'tolls_amount', 'total_amount'] %}
    {{column_name}}{% if not loop.last %},{% endif %}
{% endfor %}
from taxi_rides_raw
SQLEOF

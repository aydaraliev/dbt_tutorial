#!/bin/bash
# Create creditcard_riders_by_day.sql with direct reference (needs ref)
cat > /root/nyc_yellow_taxi/models/taxi_rides/creditcard_riders_by_day.sql << 'EOF'
-- Обновите SQL, чтобы использовать Jinja-ссылку
select
    date_part('day', tpep_pickup_datetime) as day,
    count(*) as total_riders
    -- Обновите строку ниже, используя Jinja-функцию
from taxi_rides_raw
where payment_type = 1
group by day
EOF

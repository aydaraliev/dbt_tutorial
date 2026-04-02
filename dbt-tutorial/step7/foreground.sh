#!/bin/bash
# Create datacheck script for this step
cat > /root/nyc_yellow_taxi/datacheck << 'SCRIPT'
#!/bin/bash
cd /root/nyc_yellow_taxi
RESULT=$(/opt/dbt-env/bin/python3 -c "
import duckdb
con = duckdb.connect('dbt.duckdb', read_only=True)
try:
    rows = con.execute('SELECT day, total_cc_riders FROM main.total_creditcard_riders_by_day ORDER BY day LIMIT 5').fetchall()
    total = con.execute('SELECT SUM(total_cc_riders) FROM main.total_creditcard_riders_by_day').fetchone()[0]
    print(f'Sample (first 5 days):')
    for r in rows:
        print(f'  Day {int(r[0]):2d}: {r[1]} riders')
    print(f'Total credit card riders: {total}')
except Exception as e:
    print(f'Error: {e}')
    exit(1)
con.close()
" 2>&1)
echo "$RESULT"
SCRIPT
chmod +x /root/nyc_yellow_taxi/datacheck

# Create the model with blanks for the user to fill in
cat > /root/nyc_yellow_taxi/models/taxi_rides/total_creditcard_riders_by_day.sql << 'EOF'

-- Update with SQL to return requested information
select
    date_part('day', tpep_pickup_datetime) as day,
    ____ as total_cc_riders
from taxi_rides_raw
-- Refer to the Payment_type in schema doc
where payment_type = ____
group by day
EOF

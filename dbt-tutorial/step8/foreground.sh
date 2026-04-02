#!/bin/bash
# Create datacheck script for this step
cat > /root/nyc_yellow_taxi/datacheck << 'SCRIPT'
#!/bin/bash
cd /root/nyc_yellow_taxi
/opt/dbt-env/bin/python3 -c "
import duckdb, sys
con = duckdb.connect('dbt.duckdb', read_only=True)
try:
    rows = con.execute('SELECT day, total_cc_riders FROM main.total_creditcard_riders_by_day ORDER BY day').fetchall()
    total = sum(r[1] for r in rows)
    print('Day | CC Riders')
    for r in rows:
        print(f'  {int(r[0]):2d}  | {r[1]}')
    print(f'Total credit card riders: {total}')
    if total == 384853:
        print('Datacheck PASSED')
    else:
        print(f'Datacheck FAILED: expected 384853, got {total}')
        sys.exit(1)
except Exception as e:
    print(f'Error: {e}')
    sys.exit(1)
con.close()
"
SCRIPT
chmod +x /root/nyc_yellow_taxi/datacheck

# Create data dictionary
cat > /root/nyc_yellow_taxi/data_dictionary.txt << 'DICT'
NYC Yellow Taxi - Payment Type Codes
=====================================
1 = Credit card
2 = Cash
3 = No charge
4 = Dispute
5 = Unknown
6 = Voided trip
DICT

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

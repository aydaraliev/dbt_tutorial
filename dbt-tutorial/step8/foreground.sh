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

# Create data dictionary directly in project
cat > /root/nyc_yellow_taxi/data_dictionary.txt << 'DICT'
NYC Yellow Taxi Trip Data - Data Dictionary
=============================================

Columns:
  VendorID              - TPEP provider (1 = Creative Mobile, 2 = VeriFone)
  tpep_pickup_datetime  - Pickup date and time
  tpep_dropoff_datetime - Dropoff date and time
  passenger_count       - Number of passengers
  trip_distance         - Trip distance in miles
  RatecodeID            - Rate code (1=Standard, 2=JFK, 3=Newark, 4=Nassau/Westchester, 5=Negotiated, 6=Group)
  store_and_fwd_flag    - Store and forward flag (Y/N)
  PULocationID          - Pickup taxi zone ID
  DOLocationID          - Dropoff taxi zone ID
  payment_type          - Payment method (see codes below)
  fare_amount           - Meter fare amount
  extra                 - Extra charges (rush hour, overnight)
  mta_tax               - MTA tax ($0.50)
  tip_amount            - Tip amount (auto-populated for credit card)
  tolls_amount          - Total tolls paid
  improvement_surcharge - Improvement surcharge ($0.30)
  total_amount          - Total amount charged to passenger
  congestion_surcharge  - Congestion surcharge
  airport_fee           - Airport fee

Payment Type Codes:
  1 = Credit card
  2 = Cash
  3 = No charge
  4 = Dispute
  5 = Unknown
  6 = Voided trip
DICT

# Create the model with blanks for the user to fill in
cat > /root/nyc_yellow_taxi/models/taxi_rides/total_creditcard_riders_by_day.sql << 'EOF'
-- Заполните SQL-запрос для получения нужных данных
select
    date_part('day', tpep_pickup_datetime) as day,
    ____ as total_cc_riders
from taxi_rides_raw
-- Код типа оплаты см. в data_dictionary.txt
where payment_type = ____
group by day
EOF

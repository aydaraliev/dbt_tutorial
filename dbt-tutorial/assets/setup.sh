#!/bin/bash

apt-get update -qq && apt-get install -y -qq python3-pip python3-venv > /dev/null 2>&1

python3 -m venv /opt/dbt-env
/opt/dbt-env/bin/pip install --quiet dbt-duckdb

# dbt wrapper: logs every invocation then calls the real binary
cat > /usr/local/bin/dbt << 'WRAPPER'
#!/bin/bash
echo "$(date -Iseconds) dbt $*" >> /tmp/dbt_history
exec /opt/dbt-env/bin/dbt "$@"
WRAPPER
chmod +x /usr/local/bin/dbt

# Data dictionary available throughout the tutorial
mkdir -p /root/data
cat > /root/data/data_dictionary.txt << 'DICT'
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

touch /tmp/setup-done

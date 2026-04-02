#!/bin/bash
# Copy parquet data into the project directory
cp /root/data/yellow_tripdata_2023-01.parquet /root/nyc_yellow_taxi/yellow_tripdata_2023-01-partial.parquet 2>/dev/null || true

# Create model directory and SQL file with blank
mkdir -p /root/nyc_yellow_taxi/models/taxi_rides
cat > /root/nyc_yellow_taxi/models/taxi_rides/taxi_rides_raw.sql << 'EOF'
select * from '____'
EOF

# Remove example models
rm -rf /root/nyc_yellow_taxi/models/example 2>/dev/null

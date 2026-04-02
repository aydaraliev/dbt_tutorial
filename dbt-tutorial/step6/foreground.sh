#!/bin/bash
# Copy parquet data into the project directory
cp /root/assets/yellow_tripdata_2023-01.parquet /root/nyc_yellow_taxi/yellow_tripdata_2023-01-partial.parquet 2>/dev/null || true

# Create model directory and broken SQL file
mkdir -p /root/nyc_yellow_taxi/models/taxi_rides
cat > /root/nyc_yellow_taxi/models/taxi_rides/taxi_rides_raw.sql << 'EOF'
with source_data as (
    -- Add the query as described to generate the data model
    _____
)

select * from source_data
EOF

# Remove example models
rm -rf /root/nyc_yellow_taxi/models/example 2>/dev/null

# Create datacheck script
cat > /root/nyc_yellow_taxi/datacheck << 'SCRIPT'
#!/bin/bash
cd /root/nyc_yellow_taxi
/opt/dbt-env/bin/dbt run-operation generate_schema_name 2>/dev/null
ROW_COUNT=$(/opt/dbt-env/bin/python3 -c "
import duckdb
con = duckdb.connect('dbt.duckdb', read_only=True)
try:
    result = con.execute('SELECT COUNT(*) FROM main.taxi_rides_raw').fetchone()
    print(result[0])
except:
    print(0)
con.close()
" 2>/dev/null)
echo "Total rides: $ROW_COUNT"
if [ "$ROW_COUNT" = "500000" ]; then
    echo "Datacheck PASSED"
    exit 0
else
    echo "Datacheck FAILED: expected 500000 rows"
    exit 1
fi
SCRIPT
chmod +x /root/nyc_yellow_taxi/datacheck

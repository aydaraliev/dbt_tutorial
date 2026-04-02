#!/bin/bash
# Overwrite taxi_rides_raw.sql with CTE template containing a blank
cat > /root/nyc_yellow_taxi/models/taxi_rides/taxi_rides_raw.sql << 'EOF'
with source_data as (
    -- Add the query as described to generate the data model
    _____
)

select * from source_data
EOF

# Create datacheck script
cat > /root/nyc_yellow_taxi/datacheck << 'SCRIPT'
#!/bin/bash
cd /root/nyc_yellow_taxi
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
else
    echo "Datacheck FAILED: expected 500000 rows"
fi
SCRIPT
chmod +x /root/nyc_yellow_taxi/datacheck

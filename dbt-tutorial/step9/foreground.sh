#!/bin/bash
# Create model_properties.yml with blank description
cat > /root/nyc_yellow_taxi/models/model_properties.yml << 'EOF'
version: 2

models:
  - name: taxi_rides_raw
    description: _____
    access: public
EOF

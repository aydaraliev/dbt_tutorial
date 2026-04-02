#!/bin/bash
# Create profiles.yml template with blanks for the user to fill in
mkdir -p /root/.dbt
cat > /root/.dbt/profiles.yml << 'EOF'
# Modify the project name
_____:
  outputs:
    dev:
      # Change the database type
      type: _____
      path: dbt.duckdb
  target: dev
EOF

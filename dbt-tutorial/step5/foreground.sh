#!/bin/bash
# Create profiles.yml template with blanks for the user to fill in
mkdir -p /root/.dbt
cat > /root/.dbt/profiles.yml << 'EOF'
# Укажите имя проекта
_____:
  outputs:
    dev:
      # Укажите тип базы данных
      type: _____
      path: dbt.duckdb
  target: dev
EOF

#!/bin/bash

# Install PostgreSQL
apt-get update -qq && apt-get install -y -qq postgresql postgresql-contrib python3-pip python3-venv > /dev/null 2>&1

# Start PostgreSQL
service postgresql start

# Create database and user for dbt
sudo -u postgres psql -c "CREATE USER dbt_user WITH PASSWORD 'dbt_pass';"
sudo -u postgres psql -c "CREATE DATABASE dbt_db OWNER dbt_user;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE dbt_db TO dbt_user;"

# Seed some raw data for the tutorial
sudo -u postgres psql -d dbt_db -c "
CREATE SCHEMA raw;
GRANT ALL ON SCHEMA raw TO dbt_user;
GRANT ALL ON ALL TABLES IN SCHEMA raw TO dbt_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA raw GRANT ALL ON TABLES TO dbt_user;

CREATE TABLE raw.customers (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO raw.customers (id, name, email, created_at) VALUES
(1, 'Alice', 'alice@example.com', '2024-01-15'),
(2, 'Bob', 'bob@example.com', '2024-02-20'),
(3, 'Charlie', 'charlie@example.com', '2024-03-10');

CREATE TABLE raw.orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES raw.customers(id),
    amount NUMERIC(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    ordered_at TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO raw.orders (id, customer_id, amount, status, ordered_at) VALUES
(1, 1, 99.99, 'completed', '2024-01-20'),
(2, 1, 49.50, 'completed', '2024-02-01'),
(3, 2, 150.00, 'returned', '2024-02-25'),
(4, 3, 75.00, 'completed', '2024-03-15'),
(5, 2, 200.00, 'pending', '2024-03-20');
"

# Install dbt in a virtual environment
python3 -m venv /opt/dbt-env
/opt/dbt-env/bin/pip install --quiet dbt-postgres

# Make dbt available globally
ln -sf /opt/dbt-env/bin/dbt /usr/local/bin/dbt

touch /tmp/setup-done

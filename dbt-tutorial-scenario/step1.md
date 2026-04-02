# Install dbt and set up PostgreSQL

A setup script is running in the background to install PostgreSQL and dbt.

Wait for the setup to complete:

```
while [ ! -f /tmp/setup-done ]; do echo "Waiting for setup..."; sleep 2; done && echo "Setup complete!"
```{{exec}}

Verify that dbt is installed:

```
dbt --version
```{{exec}}

Verify that PostgreSQL is running and has our sample data:

```
sudo -u postgres psql -d dbt_db -c "SELECT * FROM raw.customers;"
```{{exec}}

```
sudo -u postgres psql -d dbt_db -c "SELECT * FROM raw.orders;"
```{{exec}}

You should see 3 customers and 5 orders in the output.

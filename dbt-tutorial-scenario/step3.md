# Create and run your first model

First, remove the example models that dbt generated:

```
rm -rf /root/my_dbt_project/models/example
```{{exec}}

Create a model that joins customers with their order summaries:

```
cat > /root/my_dbt_project/models/customer_orders.sql << 'EOF'
WITH customer_orders AS (
    SELECT
        c.id AS customer_id,
        c.name,
        c.email,
        COUNT(o.id) AS total_orders,
        SUM(o.amount) AS total_amount
    FROM raw.customers c
    LEFT JOIN raw.orders o ON c.id = o.customer_id
    GROUP BY c.id, c.name, c.email
)

SELECT
    customer_id,
    name,
    email,
    total_orders,
    total_amount
FROM customer_orders
EOF
```{{exec}}

Now run dbt:

```
cd /root/my_dbt_project && dbt run
```{{exec}}

You should see output showing that the `customer_orders` model was created successfully.

Verify the result by querying the new view:

```
sudo -u postgres psql -d dbt_db -c "SELECT * FROM public.customer_orders;"
```{{exec}}

dbt created a **view** in the `public` schema from your SQL model.

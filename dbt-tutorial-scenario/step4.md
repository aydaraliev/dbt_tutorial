# Run dbt test

Add a schema file with tests for the model:

```
cat > /root/my_dbt_project/models/schema.yml << 'EOF'
version: 2

models:
  - name: customer_orders
    description: "Customer order summary"
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null
      - name: name
        tests:
          - not_null
      - name: total_orders
        tests:
          - not_null
EOF
```{{exec}}

Run the tests:

```
cd /root/my_dbt_project && dbt test
```{{exec}}

All 4 tests should pass. dbt verified that:
- `customer_id` is unique and not null
- `name` is not null
- `total_orders` is not null

You can also run everything together:

```
dbt build
```{{exec}}

`dbt build` runs models and tests in dependency order in a single command.
